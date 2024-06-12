function showHelpNotification(frontKeyword,helpButton,backKeyword)
        SendNUIMessage({
            action = 'showHelpNotification',
            backKey = backKeyword,
            frontKey = frontKeyword,
            helpBtn = helpButton
        })
end

function hideHelpNotification()
        SendNUIMessage({
            action = 'hideHelpNotification'
        })
end

