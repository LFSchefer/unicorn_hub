import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="review-form"
export default class extends Controller {
  static targets = ["review", "bouton"]
  connect() {
    // console.log("connected to review form controller")
  }

  form() {
    this.reviewTarget.classList.remove("d-none")
    this.boutonTarget.classList.add("d-none")
  }
}
