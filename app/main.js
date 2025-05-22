let timerInterval;
let totalSeconds = 0;
let isRunning = false;

const display = document.getElementById("display");
const startButton = document.getElementById("start");
const stopButton = document.getElementById("stop");
const resetButton = document.getElementById("reset");

function formatTime(seconds) {
  const hrs = Math.floor(seconds / 3600);
  const mins = Math.floor((seconds % 3600) / 60);
  const secs = seconds % 60;

  const formattedHrs = String(hrs).padStart(2, "0");
  const formattedMins = String(mins).padStart(2, "0");
  const formattedSecs = String(secs).padStart(2, "0");

  return `${formattedHrs}:${formattedMins}:${formattedSecs}`;
}

function updateDisplay() {
  display.textContent = formatTime(totalSeconds);
}

function startTimer() {
  if (!isRunning) {
    isRunning = true;
    timerInterval = setInterval(() => {
      totalSeconds++;
      updateDisplay();
    }, 1000);
  }
}

function stopTimer() {
  if (isRunning) {
    isRunning = false;
    clearInterval(timerInterval);
  }
}

function resetTimer() {
  stopTimer();
  totalSeconds = 0;
  updateDisplay();
}

startButton.addEventListener("click", startTimer);
stopButton.addEventListener("click", stopTimer);
resetButton.addEventListener("click", resetTimer);

// Initial display update
updateDisplay();
