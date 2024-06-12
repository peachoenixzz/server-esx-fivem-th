window.addEventListener('message', function(event) {
    if (event.data.action === "showIDCardGang") {
        $("body").fadeIn();
    }

    if (event.data.action === "hideIDCardGang") {
        $("body").fadeOut();
    }
})


