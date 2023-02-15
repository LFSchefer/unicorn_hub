import { Controller } from "@hotwired/stimulus"


export default class extends Controller {

  static targets = ['timer']

  connect() {


  }

  startTimer() {
    let time = 300
    let timer = this.timerTarget
    timer.innerText = time

    function diminuerLeTemps() {

      let minutes = parseInt(time / 60, 10)
      let secondes = parseInt(time % 60, 10)

      minutes = minutes < 10 ? "0" + minutes : minutes
      secondes = secondes < 10 ? "0" + secondes : secondes

      timer.innerText = minutes + ":" + secondes
      time = time <= 0 ? 0 : time - 1
    }
    setInterval(diminuerLeTemps, 1000)
  }

  stopTimer() {
    console.log(this.timerTarget)
  }



}
