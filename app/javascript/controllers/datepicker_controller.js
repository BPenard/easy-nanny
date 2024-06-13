import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";
import { French } from "flatpickr/dist/l10n/fr.js"


export default class extends Controller {
  connect() {
    flatpickr(this.element, {
      locale: French
    });
  }
}
