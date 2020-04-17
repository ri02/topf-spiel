function timer_all () {

let countdown;
const timerDisplay = document.querySelector('.time-left');
const button = document.querySelector('[data-time]');
button.addEventListener('click', startTimer);

document.customForm.addEventListener('submit', function(e){
  e.preventDefault();
  const seconds = this.seconds.value;
  timer(seconds);
  this.reset();
})


function timer (seconds){
  clearInterval(countdown);
  const now = Date.now();
  const then = now + seconds *1000;
  displayTimeLeft(seconds)

  countdown = setInterval(() => {
    const secondsLeft = Math.round((then-Date.now())/1000)

    if (secondsLeft <0) {
      playAlarm();
      clearInterval(countdown);
      return;
    }

    displayTimeLeft(secondsLeft)
  }, 1000);

}

function displayTimeLeft(seconds) {
  const minutes = Math.floor(seconds / 60);
  const remainderSeconds = seconds % 60;
  const display = `${minutes < 10 ? '0' : '' }${minutes}:${remainderSeconds < 10 ? '0' : '' }${remainderSeconds}`;
  timerDisplay.textContent = display;

}

function playAlarm (){
  console.log('Alarm');
  const audio = document.querySelector(`audio`);
    if (!audio) return;
    audio.currentTime = 0;
    audio.play();
}


function startTimer (){
  const seconds = parseInt(this.dataset.time);
  timer(seconds)


}


}

export {timer_all}
