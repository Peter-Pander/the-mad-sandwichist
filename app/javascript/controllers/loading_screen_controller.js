import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Loading screen controller connected")
  }

  delayedRedirect(event) {
    event.preventDefault()
    this.show()

    setTimeout(() => {
      Turbo.visit(event.target.href)
    }, 5000)
  }

  show() {
    this.element.classList.add("active")
  }

  hide() {
    this.element.classList.remove("active")
  }
}
