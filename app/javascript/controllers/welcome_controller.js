import { Controller } from "@hotwired/stimulus";
const WEEK_DAYS = ["monday", "tuesday", "wednesday", "thursday", "friday"];

const today = new Date();
let TARGETWEEKDAY = new Date(today);

// Connects to data-controller="welcome"
export default class extends Controller {
  static targets = ["monday", "tuesday", "wednesday", "thursday", "friday","weekNum","calendar","monday-card", "tuesdayCard", "wednesdayCard", "thursdayCard", "fridayCard",];



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

    this.weekNumTarget.innerText = `${TARGETWEEKDAY}`;


    // On vérifie s'il y a des cards sur le jour, si oui on les affiche
    if (this[`has${dayName.charAt(0).toUpperCase() + dayName.slice(1)}CardTarget`]) {
      this[`${dayName}CardTarget`].classList.remove("d-none")
    }

    // pour chaque jour de la semaine s'il y à un event on retire la classe transparent
    // et on affiche la class day-light
    WEEK_DAYS.forEach((day) => {
      if (this[`has${day.charAt(0).toUpperCase() + day.slice(1)}CardTarget`]) {
        this[`${day}Target`].classList.remove("day-transparent")
        this[`${day}Target`].classList.add("day-light")
      }})


    // On mets en marron le jour courant (et on retire les autres classes)
    this[`${dayName}Target`].classList.remove("day-transparent")
    this[`${dayName}Target`].classList.remove("day-light")
    this[`${dayName}Target`].classList.add("day-strong")

  }

  events_of_day(event) {
    // gestion des jours du calendrier

    // pour chaque jour de la semaine
      // 1. on retire la classe strong
      // 2. s'il y à un event on met la classe day-light
      // 3. sinon on attribut la classe day-transparent
    WEEK_DAYS.forEach((day) => {
      this[`${day}Target`].classList.remove("day-strong")

      if (this[`has${day.charAt(0).toUpperCase() + day.slice(1)}CardTarget`]) {
        this[`${day}Target`].classList.add("day-light")
      } else {
        this[`${day}Target`].classList.add("day-transparent")
      }
    })

    // Puis on retire les classes non souhaités et on ajoute day-strong sur le jour choisi
    this[`${event.currentTarget.dataset.day}Target`].classList.remove("day-transparent")
    this[`${event.currentTarget.dataset.day}Target`].classList.remove("day-light")
    this[`${event.currentTarget.dataset.day}Target`].classList.add("day-strong")


    // gestion des cards
    // au click on masque tous les jours

    WEEK_DAYS.forEach((day) => {
      if (this[`has${day.charAt(0).toUpperCase() + day.slice(1)}CardTarget`]) {
        this[`${day}CardTarget`].classList.add("d-none")
      }
    })

    // puis on affiche les jours sur lequel on a cliqué
    if (this[`has${event.currentTarget.dataset.day.charAt(0).toUpperCase() + event.currentTarget.dataset.day.slice(1)}CardTarget`]) {
      this[`${event.currentTarget.dataset.day}CardTarget`].classList.remove("d-none")
    }
  }

  change_week(event) {

    // const today = new Date();
    // const targetWeekDate = new Date(today);

    // Reculer de 7 jours pour obtenir une date de la semaine précédente
    if (event.currentTarget.dataset.direction == "pastWeek"){
      TARGETWEEKDAY.setDate(TARGETWEEKDAY.getDate() - 7);
    } else if (event.currentTarget.dataset.direction == "futurWeek"){
      TARGETWEEKDAY.setDate(TARGETWEEKDAY.getDate() + 7);
    }
    this.weekNumTarget.innerText = `${TARGETWEEKDAY}`;


    const url = `/welcome?start_date=${TARGETWEEKDAY}`;

    fetch(url, {
      method: "GET",
      headers: {
        Accept: "application/json",
      },
    })
      .then((response) => response.json())
      .then((data) => {
        this.calendarTarget.innerHTML = data.content;
        const dayOfPreviousWeek = TARGETWEEKDAY.getDay();
        const days = [
          "sunday",
          "monday",
          "tuesday",
          "wednesday",
          "thursday",
          "friday",
          "saturday",
        ];
        const previousDayName = days[dayOfPreviousWeek];

         // On vérifie s'il y a des cards sur le jour, si oui on les affiche
        if (this[`has${previousDayName.charAt(0).toUpperCase() + previousDayName.slice(1)}CardTarget`]) {
          this[`${previousDayName}CardTarget`].classList.remove("d-none")
        }


        WEEK_DAYS.forEach((day) => {
          this[`${day}Target`].classList.remove("day-strong")
          this[`${day}Target`].classList.remove("day-transparent")
          this[`${day}Target`].classList.remove("day-light")

          if (this[`has${day.charAt(0).toUpperCase() + day.slice(1)}CardTarget`]) {
            this[`${day}Target`].classList.add("day-light")
          } else {
            this[`${day}Target`].classList.add("day-transparent")
          }
        })

        this[`${previousDayName}Target`].classList.remove("day-transparent")
        this[`${previousDayName}Target`].classList.remove("day-light")
        this[`${previousDayName}Target`].classList.add("day-strong")

      })
      .catch((error) => {
        console.error(error);
      });




  }
}
