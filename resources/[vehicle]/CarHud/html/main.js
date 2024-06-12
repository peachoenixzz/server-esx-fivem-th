$(() => {
    window.addEventListener('message', (e) => {
        const data = e.data;
        if (!data.pauseMenuOn) {
            switch (data.action) {
                case 'ui':
                    if (data.ui) {
                        $('.display').css('animation', 'fadeIn 0.7s forwards');
                        $('.display').fadeIn();
                       
                        $('#speed').text(data.speed);
                        if (data.engineControl) {
                            $('.rpmLoad').css('width',data.rpmPercent+'%')
                            $('#xrpm').html('x'+data.rpm)
                            $('#engine').css('height',data.health+'%')
                            $('#fuel').css('height',data.fuel+'%')
                        
                        } else {
                            $('.rpmLoad').css('width',data.rpmPercent+'%')
                            $('#xrpm').html('x'+data.rpm)
                            $('#engine').css('height',data.health+'%')
                            $('#fuel').css('height',data.fuel+'%')
                        }
                        if (data.TyreBurst1 == '1' && data.TyreBurst3 != '1'){
                            $('.motorcycle').attr('src','img/motorcycle2.png')
                        }
                        else if (data.TyreBurst1 == '1' && data.TyreBurst3 == '1'){
                            $('.motorcycle').attr('src','img/motorcycle1.png')
                        }
                        else if (data.TyreBurst1 != '1' && data.TyreBurst3 == '1'){
                            $('.motorcycle').attr('src','img/motorcycle3.png')
                        }
                        else{
                            $('.motorcycle').attr('src','img/motorcycle.png')
                        }
                        if (data.health<=data.healthLimit){
                            $('#engine').addClass('active')
                        }
                        else{
                            $('#engine').removeClass('active')
                        }
                         if (data.fuel<=data.fuelLimit){
                            $('#fuel').addClass('active')
                        }
                        else{
                            $('#fuel').removeClass('active')
                        }
                        if(e.data.doorlock ==2){
                            $('.locked').addClass('active')
                        }
                        else{
                            $('.locked').removeClass('active')
                        }
                        if(e.data.light == 1){
                            $('.light').addClass('active')
                        }
                        else{
                            $('.light').removeClass('active')
                        }
                        if (data.TyreBurst1 == '1'){
                            $('.wheel4').addClass('broken')
                        }
                        else if(data.TyreBurst1 == false){
                            $('.wheel4').removeClass('broken')
        
                        }
                        if (data.TyreBurst2 == '1'){
                            $('.wheel3').addClass('broken')
                        }
                        else if(data.TyreBurst2 == false){
                            $('.wheel3').removeClass('broken')
                        }if (data.TyreBurst3 == '1'){
                            $('.wheel1').addClass('broken')
                        }
                        else if(data.TyreBurst3 == false){
                            $('.wheel1').removeClass('broken')
                            $('.wheel5').removeClass('broken')
                        }
                        if (data.TyreBurst4 == '1'){
                            $('.wheel2').addClass('broken')
                        }
                        else if(data.TyreBurst4 == false){
                            $('.wheel2').removeClass('broken')
                        }
                    }
                // }}
               
                if(data.ui==false) {
                    $('.display').css('animation', 'fadeOut 0.7s forwards');
                    setTimeout(function(){
                        $('.display').fadeOut(0);
                    },500)
                }
                        if( data.speed == 0 && data.gear >= 0 && data.engineControl == 1) {
                            $('#gear').text('N');
                 
                        } else if ( data.speed > 0 && data.gear == 0) {
                            $('#gear').text('R');

                        } else if ( data.speed > 0 && data.gear > 0) {
                            $('#gear').text(data.gear);

                        } else if ( data.speed == 0 && data.gear == 0 && data.engineControl == false) {
                            $('#gear').text('P');

                        }
                        if (data.car == "motorcycles") {
                            $('.carStat img').hide()
                            $('.motorcycle').show()
                            $('.wheel1').fadeOut()
                            $('.wheel2').fadeOut()
                            $('.wheel3').fadeOut()
                            $('.wheel4').fadeOut()
                            $('.wheel5').fadeIn()
                            $('.wheel6').fadeIn()
                    
                        } else if (data.car == "car") {
                            $('.carStat img').hide()
                            $('.car').show()
                            $('.wheel1').fadeIn()
                            $('.wheel2').fadeIn()
                            $('.wheel3').fadeIn()
                            $('.wheel4').fadeIn()
                            $('.wheel5').fadeOut()
                            $('.wheel6').fadeOut()
                          
                        } else if (data.car == "boat") {
                            $('.carStat img').hide()
                            $('.boat').show()
                            $('.wheel1').fadeOut()
                            $('.wheel2').fadeOut()
                            $('.wheel3').fadeOut()
                            $('.wheel4').fadeOut()
                            $('.wheel5').fadeOut()
                            $('.wheel6').fadeOut()
                           
                        } else if (data.car == "helicopters") {
                            $('.carStat img').hide()
                            $('.helicopter').show()
                            $('.wheel1').fadeOut()
                            $('.wheel2').fadeOut()
                            $('.wheel3').fadeOut()
                            $('.wheel4').fadeOut()
                            $('.wheel5').fadeOut()
                            $('.wheel6').fadeOut()
                         
                        } else if (data.car == "bike") {
                            $('.carStat img').hide()
                            $('.bike').show()
                            $('.wheel1').fadeOut()
                            $('.wheel2').fadeOut()
                            $('.wheel3').fadeOut()
                            $('.wheel4').fadeOut()
                            $('.wheel5').fadeOut()
                            $('.wheel6').fadeOut()
                        
                        } else if (data.car == "air") {
                            $('.carStat img').hide()
                            $('.plane').show()
                            $('.wheel1').fadeOut()
                            $('.wheel2').fadeOut()
                            $('.wheel3').fadeOut()
                            $('.wheel4').fadeOut()
                            $('.wheel5').fadeOut()
                            $('.wheel6').fadeOut()
                           
                        }
            }
        }
        if (data.action =='seatbelt'){
            if (data.SeatbeltON) {
                $('.belt').addClass('active')    
            }
            else{
                $('.belt').removeClass('active')      
          }
        }
        if (data.action =='menucar'){
            if (data.displayMenucar) {
                $('.consoleCar').css('animation', 'fadeIn1 0.7s forwards');
    
            }
            else{
                $('.consoleCar').css('animation', 'fadeOut1 0.7s forwards');
            }
        }
        if (data.transactionType == 'playSound'){
            const audio = new Audio();
            audio.src = "./sounds/"+data.transactionFile+".ogg";
            audio.play()
            audio.volume =  data.transactionVolume;
        }       
    });
});
function control(name,number){
    $.post('http://CarHud/menuget', JSON.stringify({
            name:name,
            num:number
    })); 
}