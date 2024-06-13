// app/javascript/controllers/navbar_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["navbar"];

  connect() {
    this.handleScroll = this.handleScroll.bind(this);
    window.addEventListener("scroll", this.handleScroll);
    console.log("Navbar controller connected");
  }

  disconnect() {
    window.removeEventListener("scroll", this.handleScroll);
    console.log("Navbar controller disconnected");
  }

  handleScroll() {
    const navbarHeight = this.navbarTarget.offsetHeight;
    console.log("Scroll position:", window.scrollY);
    console.log("Navbar height:", navbarHeight);
    if (window.scrollY > navbarHeight) {
      this.navbarTarget.classList.add("scrolled");
      console.log("Navbar scrolled");
    } else {
      this.navbarTarget.classList.remove("scrolled");
      console.log("Navbar not scrolled");
    }
  }
}
