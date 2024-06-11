import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="welcome"
export default class extends Controller {
  static targets = ["monday", "tuesday", "wednesday", "thursday", "friday","calendar"];
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
    const today = new Date();

    // Reculer de 7 jours pour obtenir une date de la semaine précédente
    const lastWeekDate = new Date(today);
    lastWeekDate.setDate(today.getDate() - 7);

    const url = `/welcome?start_date=${lastWeekDate}`;

    fetch(url, {
      method: "GET",
      headers: {
        Accept: "application/json",
      },
    })
      .then((response) => response.json())
      .then((data) => {
        this.calendarTarget.innerHTML = data.content;
        const dayOfPreviousWeek = lastWeekDate.getDay();
        const days = [
          "sunday",
          "monday",
          "tuesday",
          "wednesday",
          "thursday",
          "friday",
          "saturday",
        ];
        // const contract_card = document.querySelectorAll('.contract-card');
        const previousDayName = days[dayOfPreviousWeek];
        console.log(previousDayName)
        const dayEvents = document.querySelectorAll(`.contract-card[data-infos=${previousDayName}]`);
        console.log(dayEvents)
        dayEvents.forEach((dayEvent) => {
          dayEvent.classList.remove("d-none");
        });
      })
      .catch((error) => {
        console.error(error);
      });




  }
}
