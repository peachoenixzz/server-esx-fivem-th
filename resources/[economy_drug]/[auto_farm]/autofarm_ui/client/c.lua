function showProcessDetail(selectedItems)
    print("in area ui")
        SendNUIMessage({
            action = 'showProcessDetail',
            selectedItems = json.encode(selectedItems),
        })
end

function updateProcessDetail(selectedItems)
    SendNUIMessage({
        action = 'updateProcessDetail',
        selectedItems = json.encode(selectedItems),
    })
end

function cancelProcessItem()
    SendNUIMessage({
        action = 'cancelProcess',
    })
end

function hideProcessDetail()
        SendNUIMessage({
            action = 'hideProcessDetail'
        })
end

