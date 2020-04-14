function timer_all () {

let countdown
const timerDisplay = document.querySelector('.time-left')



timer(4);

function timer (seconds){
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


}

export {timer_all}
