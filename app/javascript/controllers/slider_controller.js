import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["slider", "output"]

  connect() {
    this.updateOutput()
  }

  updateOutput() {
    this.outputTarget.value = this.sliderTarget.value
  }

  change() {
    this.updateOutput()
  }
}
