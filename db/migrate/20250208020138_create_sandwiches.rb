class CreateSandwiches < ActiveRecord::Migration[7.1]
  def change
    create_table :sandwiches do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
