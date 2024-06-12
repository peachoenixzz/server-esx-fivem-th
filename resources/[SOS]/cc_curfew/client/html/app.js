function play() {
  const bigContiner = document.getElementById("big-container");
  bigContiner.style.display = "block";
  const sound = document.getElementById("play-sound");
  sound.volume = 0.02;
  sound.play();
}

function closes() {
  $("#big-container").fadeOut();
  const sound = document.getElementById("play-sound");
  sound.pause();
  sound.currentTime = 0;
}

window.addEventListener("message", function (event) {
  if (event.data.action === "showMenu") {
    const text = document.getElementById("text");
    text.innerHTML = event.data.text.toUpperCase();
    play();
    return;
  }
  if (event.data.action === "hideMenu") {
    text.innerHTML = event.data.text;
    closes();
    return;
  }
});
