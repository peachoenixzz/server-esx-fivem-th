function showProcessDetail(countBase,itemDetail)
        local baseItemLabel = itemDetail.Items[1].ItemName
        local baseItemName = itemDetail.Items[1].Text
        local getItem = itemDetail.Items[1].Get
        SendNUIMessage({
            action = 'showProcessDetail',
            countBaseItem = countBase,
            baseItem = baseItemLabel,
            baseItemName = baseItemName,
            getItem = getItem
        })
end

function updateProcessDetail(itemName,count,totalBaseItemCount)
    SendNUIMessage({
        action = 'updateProcessDetail',
        itemName = itemName,
        count = count,
        totalBaseItemCount = totalBaseItemCount
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

