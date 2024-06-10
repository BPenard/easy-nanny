import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="payslip-update"
export default class extends Controller {
   static targets = ["button", "pajeEmploiLoader", "pajeEmploisuccess", "bankLoader", "bankSuccess"]
   static values = {
    id: String
   }

  connect() {
    console.log("Hello from payslip update contrôler")

  }

  pajeEmploiUpdate(event) {
    event.preventDefault()
    console.log("click")

    this.show(this.pajeEmploiLoaderTarget)
    this.hide(this.pajeEmploisuccessTarget)

    setTimeout(() => {
      this.hide(this.pajeEmploiLoaderTarget)
      this.show(this.pajeEmploisuccessTarget)

    }, 2000)

    const url = `/payslip/${this.idValue}/save_pajeemploi_date`


    fetch(url, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        }
      })
      .then(response => response.json())
      .then(data => {
        console.log(data)
      })
      .catch(error => {
        console.error(error)
      })
  }

  bankUpdate(event) {
    event.preventDefault()
    console.log("click")

    this.show(this.bankLoaderTarget)
    this.hide(this.bankSuccessTarget)

    setTimeout(() => {
      this.hide(this.bankLoaderTarget)
      this.show(this.bankSuccessTarget)

    }, 2000)

    const url = `/payslip/${this.idValue}/save_pajeemploi_date`


    fetch(url, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        }
      })
      .then(response => response.json())
      .then(data => {
        console.log(data)
      })
      .catch(error => {
        console.error(error)
      })
  }


  show(element) {
    element.classList.remove("hidden")
  }

  hide(element) {
    element.classList.add("hidden")
  }


}
