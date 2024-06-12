window.addEventListener('message', function(event) {
    let res = event.data;
    if (event.data.action == "showIDCard") {
        document.getElementById('image').src = `img/${res.sex}.png`
        document.getElementById('name-signature').innerHTML = res.name
        document.getElementById('name').innerHTML = res.name.toUpperCase()
        document.getElementById('dob').innerHTML = res.dateOfBirth
        document.getElementById('height').innerHTML = res.height
        document.getElementById('sex').innerHTML = res.sex
        document.getElementById('job').innerHTML = res.job
        document.getElementById('position').innerHTML = res.position
        $("body").fadeIn();
    }

    if (event.data.action == "hideIDCard") {
        $("body").fadeOut();
    }
})


