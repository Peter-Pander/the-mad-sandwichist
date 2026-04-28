class SandwichesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:index]
  before_action :authenticate_user!, only: %i[new create toggle_favorite]
  before_action :set_sandwich, only: %i[show]
  before_action :set_user, only: %i[create]  # Set the current user

  def toggle_favorite
    @sandwich = Sandwich.find(params[:id])

    if current_user.favorited?(@sandwich)
      current_user.unfavorite(@sandwich)
    else
      current_user.favorite(@sandwich)
    end

    respond_to do |format|
      format.turbo_stream do
        turbo_streams = [
          turbo_stream.replace("sandwich_#{@sandwich.id}", partial: "sandwiches/sandwich_card", locals: { sandwich: @sandwich })
        ]

        # Conditionally update the sandwich list only if filtering is active
        if params[:filter] == "favorites"
          turbo_streams << turbo_stream.replace("sandwiches_list", partial: "sandwiches/list", locals: { sandwiches: current_user.favorited_sandwiches })
        end

        render turbo_stream: turbo_streams
      end
      format.html { redirect_to sandwiches_path }
    end
  end

  def index
    @sandwiches = if params[:filter] == "favorites"
                    current_user.favorited_sandwiches
                  else
                    Sandwich.all
                  end

    @sandwiches = @sandwiches.where("name ILIKE ?", "%#{params[:query]}%") if params[:query].present?

    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("search-results", partial: "sandwiches/sandwich_cards", locals: { sandwiches: @sandwiches })
      end
    end
  end

  def new
    @sandwich = Sandwich.new
    @ingredients = Ingredient.all
    @default_ingredients = [
      "pretzel bun",
      "ciabatta"
    ]

    @visible_ingredients = Ingredient.where(name: @default_ingredients)
      .sort_by { |ing| @default_ingredients.index(ing.name) }

    # Create an array of hashes containing the ingredient data
    @ingredients_data = @ingredients.map do |ingredient|
      {
        id: ingredient.id,
        name: ingredient.name,
        type: ingredient.ingr_type,
        traits: ingredient.traits.map(&:name).join(", ") # Short for: ingredient.traits.map {|trait| trait.name}.join(", ")
      }
    end
  end

  def create
    @sandwich = Sandwich.new(sandwich_params.slice(:name, :description, :photo))
    @sandwich.user = @user  # Ensure the sandwich is associated with the current user
    if @sandwich.save
      sandwich_params[:ingredient_ids].each_with_index do |ingredient_id, index|
        @ingredient = Ingredient.find(ingredient_id)
        @ingredient_quantities = sandwich_params[:ingredient_quantities]
        SandwichIngredient.create(sandwich: @sandwich, ingredient: @ingredient, ingredient_position: index, ingredient_qty: @ingredient_quantities[ingredient_id])
      end
      redirect_to @sandwich, notice: "Sandwich created successfully!"
    else
      @ingredients = Ingredient.all
      @visible_ingredients = Ingredient.where(name: @default_ingredients)
      .sort_by { |ing| @default_ingredients.index(ing.name) }
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @sandwich = Sandwich.find(params[:id])
    @reviews = @sandwich.reviews.includes(:user)

    @sandwich_ingredients = SandwichIngredient.where(sandwich_id: @sandwich.id).order(:ingredient_position)

    @flavors = @sandwich_ingredients.flat_map { |sandwich_ingredient| sandwich_ingredient.ingredient.traits.where(trait_type: "flavor").pluck(:name) }
    @textures = @sandwich_ingredients.flat_map { |sandwich_ingredient| sandwich_ingredient.ingredient.traits.where(trait_type: "texture").pluck(:name) }
    @cuisines = @sandwich_ingredients.flat_map { |sandwich_ingredient| sandwich_ingredient.ingredient.traits.where(trait_type: "cuisine").pluck(:name) }

    flavor_counts = @flavors.each_with_object(Hash.new(0)) { |flavor, counts| counts[flavor.capitalize] += 1 }

    @chart_data = {
      labels: flavor_counts.keys,
      datasets: [{
        label: 'My First dataset',
        backgroundColor: 'transparent',
        borderColor: '#3B82F6',
        data: flavor_counts.values.map{ |count| count/flavor_counts.values.sum.to_f*100 }
      }]
    }

    @chart_options = {
      scales: {
        r: {
            beginAtZero: true
        }
      }
    }
  end

  def generate_suggestion
    #debugger
    #puts "The quantity is #{params[:quantity]} and the keyword is #{params[:keyword]}."
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: [{role: "user", content: "This is an array of arrays containing an ingredient name and its ID:
         #{Ingredient.pluck(:name, :id)}" }, { role: "user", content: "Output an array of arrays containing an ingredient name and its ID that could be added to a sandwich to make it
        crazy but delicious. Please theme your selected ingredients around the keyphrase: #{params[:keyword]}. If a keyphrase was not
        provided or you do not understand it, then please choose a replacement keyphrase on your own. Your array must
        contain exactly #{params[:quantity]} ingredient(s). Return an array of arrays, in the form
        [[\"apple\", 3000], [\"pear\", 3001], [\"banana\", 3002]]. Do not return any other information or provide additional formatting."}]
    })
    @content = chatgpt_response["choices"][0]["message"]["content"]
    render json: { result: @content }
  end

  private

  # Set the current user
  def set_user
    @user = current_user
  end

  # Find a specific sandwich based on its ID
  def set_sandwich
    @sandwich = Sandwich.find(params[:id])
  end

  def suggestion_params
    params.permit(:quantity, :keyword)
  end

  # Define permitted parameters for the sandwich form
  def sandwich_params
    params.require(:sandwich).permit(:name, :description, :photo, ingredient_ids: [], ingredient_quantities: {})
  end
end
