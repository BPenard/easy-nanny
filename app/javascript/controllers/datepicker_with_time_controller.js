import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";
import { French } from "flatpickr/dist/l10n/fr.js"

export default class extends Controller {
  connect() {
    flatpickr(this.element, {
      enableTime: true,
      dateFormat: "Y-m-d H:i",
      locale: French
    });
  }
}
