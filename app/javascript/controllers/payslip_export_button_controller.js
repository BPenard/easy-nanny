import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="payslip-export-button"
export default class extends Controller {
   static targets = ["button", "loader", "success"]

  connect() {
    this.hide(this.loaderTarget)
    this.hide(this.successTarget)
  }

  simulate(event) {
    event.preventDefault()
    console.log("click")

    this.show(this.loaderTarget)
    this.hide(this.successTarget)

    setTimeout(() => {
      this.hide(this.loaderTarget)
      this.show(this.successTarget)

    }, 2000)
  }

  show(element) {
    element.classList.remove("hidden")
  }

  hide(element) {
    element.classList.add("hidden")
  }

  saveDate() {
    // Remplace cette URL par celle de ton endpoint API
    const url = "/payslip/:id/save_pajeemploi_date" // Je ne sais pas comment construire cette URL

    fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify({ date: new Date() })
    })
    .then(response => response.json())
    .then(data => {
      console.log("Date saved:", data)
    })
    .catch(error => {
      console.error("Error saving date:", error)
    })
  }

}
