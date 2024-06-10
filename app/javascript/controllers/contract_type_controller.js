import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["endDate"]

  connect() {
    this.toggleEndDate()
  }

  toggleEndDate() {
    const cdiRadio = document.getElementById("cdi")
    if (cdiRadio.checked) {
      this.endDateTarget.style.display = "none"
    } else {
      this.endDateTarget.style.display = "block"
    }
  }
}
