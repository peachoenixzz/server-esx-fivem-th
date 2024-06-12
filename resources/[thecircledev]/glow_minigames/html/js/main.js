const scriptName = "glow_minigames";
const startEndScreens = {
    path: {
        height: "63.5vh",
        width: "60vh",
        icon: "fa-laptop-code",
        start: "กำลังเรียกหา Mini Game",
        failTime: "คุณทำ Mini Game ไม่สำเร็จ",
        failError: "คุณทำ Mini Game ไม่สำเร็จ",
        success: "ทำ Mini Game สำเร็จ",
    },
    spot: {
        height: "63vh",
        width: "60vh",
        icon: "fa-file-shield",
        start: "กำลังเรียกหา Mini Game",
        failTime: "คุณทำ Mini Game ไม่สำเร็จ",
        success: "ทำ Mini Game สำเร็จ",
    },
    math: {
        height: "60vh",
        width: "60vh",
        icon: "fa-server",
        start: "Firewall active. Attempting to bypass..",
        failTime: "Bypass failed. Time Limit Reached",
        failError: "Bypass failed. Incorrect input.",
        success: "Firewall successfully bypassed.",
    }
}

let activeGame = null;
let startTimeout = null;
let endTimeout = null;

function startGame(game, settings) {
    switch(game) {
        case "path":
            startPathGame(settings);    
            break;
        case "spot":
            startSpotGame(settings);
            break;
        case "math":
            startMathGame(settings);
            break;
        }
}

function displayScreen(game, text) {
    const screenInfo = startEndScreens[game]
    $("#screen").css({
        "height": screenInfo.height,
        "width" : screenInfo.width,
    })

    $(".screen-icon").html(`<i class="fa-solid ${screenInfo.icon}"></i>`);
    $(".screen-text").text(screenInfo[text]);
    $("#screen").show();
}

function hideScreen() {
    $("#screen").hide();
}

function clearTimeouts() {
    clearTimeout(startTimeout);
    clearTimeout(endTimeout);
}

$(document).keyup(function(e) {
    if (e.key == "Escape" && activeGame) {
        $.post(`https://${scriptName}/endGame`, JSON.stringify({success: false}));

        if (activeGame == "path") {
            resetPath();
        }

        if (activeGame == "spot") {
            resetSpot();
        }

        if (activeGame == "math") {
            resetMath();
        }
        clearTimeouts();
        activeGame  = null;
    }
})

    
window.addEventListener("message", function(event) {
    const item = event.data;
    if (item.action == "startGame") {
        startGame(item.game, item.settings);
    }
})