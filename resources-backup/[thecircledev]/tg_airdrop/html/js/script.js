// This resource was scripted by TG DEVELOPER
// Discord : https://discord.gg/yT9ySxbM9Y

$('document').ready(function() {
    Command = {};

    Command.Start = function(data) {
        $("#airdropList").css("display", "block");
        $.each(data.data, function(index, data) {
            $('#airdropList').append(`
                <div data-class="${index}" class="animate__animated animate__fadeInDownBig animate__slower Airdrop">
                    <img data-airdrop="${index}" class="airdropImage" src="`+ data.image +`"></img>
                    <div class="airdropText">
                        <span data-airdroptime="${index}" class="timeText" ><span id="${index}">00:00</span></span>
                    </div>
                </div>
            `);
            $(`[data-class="${index}"]`).removeClass("animate__fadeOutRightBig animate__slower").removeClass("animate__fadeInDownBig animate__slower");
            $(`[data-class="${index}"]`).addClass("animate__fadeInDownBig animate__slower");
        });
    };

    Command.Update = function(text) {
        $.each(text.data, function(index, data) {
            let airdropNumber = index;
            $(`[data-airdroptime="${airdropNumber}"]`).text(text.time)
        });
    };

    Command.Delete = function(data) {
        $(`[data-class="${data.airdropEnd}"]`).empty();
    };

    Command.End = function() {
        $("#airdropList").css("display", "none");
        $('#airdropList').empty();
    };
    
    window.addEventListener('message', function(event) {
        switch(event.data.action) {
            case 'start':
                Command.Start(event.data);
                break;
            case 'update':
                Command.Update(event.data);
                break;
            case 'delete':
                Command.Delete(event.data);
                break;
            case 'end':
                Command.End(event.data);
                break;
        }
    })
});
