import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["slider", "display"]

  connect() {
    this.sliderTargets.forEach(slider => {
      this.updateDisplay(slider);
    });
  }

  update(event) {
    this.updateDisplay(event.target);
  }

  updateDisplay(slider) {
    const display = slider.closest('div').querySelector('.ingredient-quantity-display');
    if (display) {
      display.textContent = `${slider.value} ${slider.dataset.unit}`;
    }
  }
}
