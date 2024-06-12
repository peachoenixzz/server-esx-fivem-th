window.addEventListener('message', async function(e) {
    if (e.data.action == 'changemode'){
        $('.modename span').html('MODE : '+e.data.mode)  
    }else if (e.data.action == 'open'){
        $('.contents').show()
        $('.modename span').html('MODE : AUTO')
        $('#boxwater').width(e.data.amount +'%');
        $('#water span').html(e.data.amount+'%')
    }else if (e.data.action == 'close'){
        $('.contents').hide()
    }else if (e.data.action == 'water'){
        $('#boxwater').width(e.data.amount+'%');
        $('#water span').html(e.data.amount.toFixed()+'%')   
    }
})


