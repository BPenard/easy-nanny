import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="welcome"
export default class extends Controller {
  static targets = ["monday", "tuesday", "wednesday", "thursday", "friday"];
  // static values = { day: String }

  connect() {
    console.log("Hello from welcome controler");

    // on récupère le nom du jour
    const today = new Date();
    const dayOfWeek = today.getDay();
    const days = [
      "sunday",
      "monday",
      "tuesday",
      "wednesday",
      "thursday",
      "friday",
      "saturday",
    ];
    const dayName = days[dayOfWeek];

    // On affiche les jours du jour même
    const dayEvents = document.querySelectorAll(
      `.contract-card[data-infos=${dayName}]`
    );
    dayEvents.forEach((dayEvent) => {
      dayEvent.classList.remove("d-none");
    });
  }

  events_of_day(event) {
    // au click on masque tous les jours
    const allEvents = document.querySelectorAll(`.contract-card`);
    allEvents.forEach((event) => {
      event.classList.add("d-none");
    });

    // puis on affiche les jours sur lequel on a cliqué
    const dayEvents = document.querySelectorAll(
      `.contract-card[data-infos=${event.currentTarget.dataset.day}]`
    );
    dayEvents.forEach((dayEvent) => {
      dayEvent.classList.remove("d-none");
    });
  }

  change_week() {
    console.log("change week");

    const url = "/welcome?start_date=2024-06-05";

    // fetch(url,
    //   headers: {
    //     "Content-Type": "application/json",
    //   }
    // )
    //   .then((response) => response.json())
    //   .then((data) => console.log(data))
    //   .catch((error) => console.error("Error:", error));

    fetch(url, {
      method: "GET",
      headers: {
        Accept: "application/json",
        // "X-CSRF-Token": document
        //   .querySelector('meta[name="csrf-token"]')
        //   .getAttribute("content"),
      },
    })
      .then((response) => response.json())
      .then((data) => {
        document.querySelector(".toto").innerHTML = data.content;
      })
      .catch((error) => {
        console.error(error);
      });
  }
}
