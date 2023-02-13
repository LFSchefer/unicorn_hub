import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-unicorns"
export default class extends Controller {
  static targets = ["input", "form", "unicorn"]
  connect() {
    console.log("connected to search")
    console.log(this.inputTarget)
    console.log(this.formTarget)
    console.log(this.unicornTarget)
  }

  update() {

    const url = `${this.formTarget.action}?query=${this.inputTarget.value}`
    fetch(url, {headers: {"Accept": "text/plain"}})
      .then(response => response.text())
      .then((data) => {
        this.unicornTarget.outerHTML = data
      })
  }
}
