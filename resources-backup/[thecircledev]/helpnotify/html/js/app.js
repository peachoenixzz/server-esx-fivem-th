window.addEventListener('message', function(event) {
    let res = event.data;
    if (event.data.action === "showHelpNotification") {
        showNotification(res);
    }

    if (event.data.action === "hideHelpNotification") {
        hideNotification();
    }
})

const notify = document.getElementById('helpNotify');

// Function to show the notification
function showNotification(res) {
    $("#back-word").empty();
    $("#front-word").empty();
    $("#key").empty();
    $("#back-word").append(res.backKey);
    $("#front-word").append(res.frontKey);
    $("#key").append(res.helpBtn);
    notify.classList.remove('hidden', 'animate-out');
    notify.classList.add('animate-in');
}

// Function to hide the notification
function hideNotification() {
    notify.classList.add('animate-out');
    // Use an event listener to set display none after animation ends
    notify.addEventListener('animationend', () => {
        // Check if the animation-out class is still there
        if(notify.classList.contains('animate-out')){
            notify.classList.add('hidden');
            $("#back-word").empty();
            $("#front-word").empty();
            $("#key").empty();
        }
    }, { once: true });
}
