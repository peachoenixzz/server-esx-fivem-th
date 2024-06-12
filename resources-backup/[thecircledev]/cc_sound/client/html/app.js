
var audioPlayer = null;

$(function() {
    window.addEventListener('message', function(event) {
        if (event.data.Type === "playSound") {
            if (audioPlayer != null) {
                audioPlayer.pause();
            }

            audioPlayer = new Audio("./sounds/" + event.data.File);
            audioPlayer.volume = event.data.Volume;
            audioPlayer.play();

        }
    }, false);
});