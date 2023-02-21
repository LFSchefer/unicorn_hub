import { Controller } from "@hotwired/stimulus"

// TODO full JS vinalla Timer 

var output = $('h1');
var isPaused = false;
var time = new Date();
var offset = 0;
var t = window.setInterval(function() {
  if(!isPaused) {
    var milisec = offset + (new Date()).getTime() - time.getTime();
    output.text(parseInt(milisec / 1000) + "s " + (milisec % 1000));
  }
}, 10);

let player = document.querySelector(".toggle");


//with jquery
$('.toggle').on('click', function(e) {
  $('boutton.toggle').html('Pause')
  e.preventDefault();
  isPaused = !isPaused;
  if (isPaused) {
    offset += (new Date()).getTime() - time.getTime();
    player.innerHTML = "Pause"
  } else {
    time = new Date();
    player.innerHTML = "Play"
  }
});

export default class extends Controller {

  static targets = ['timer']
  static value = {
    clock: String
  }

  connect() {

  }

  startTimer(x) {
    console.log(this.clockValue)
    let time = this.timerTarget.innerText
    let timer = this.timerTarget

    function diminuerLeTemps() {

      let minutes = parseInt(time / 60, 10)
      let secondes = parseInt(time % 60, 10)

      minutes = minutes < 10 ? "0" + minutes : minutes
      secondes = secondes < 10 ? "0" + secondes : secondes

      timer.innerText = minutes + ":" + secondes
      time = time <= 0 ? 0 : time - 1
    }
    // setInterval(diminuerLeTemps,1000)

    setInterval( function() {if (x == 'play') {
      console.log("play")
      diminuerLeTemps;
    }
    },1000);

    // function stopTimer() {
    //   console.log(this.timerTarget.innerText)
    //   time -= 600
    // }

  }


}
