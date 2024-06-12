$(function() {
    window.addEventListener('message', async function(event) {
        switch(event.data.action) {
            case 'display_off':
                $.post('https://nc_inventory_bridge/NUIFocusOff', JSON.stringify({}));
                break;
            case 'setSecondInventoryItems':
                $.post('https://nc_inventory_bridge/setSecondInventoryItems', JSON.stringify(event.data.itemList));
                break;
            case 'setInfoText':
                $.post('https://nc_inventory_bridge/setInfoText', JSON.stringify(event.data));
                break;
            case 'display':
                $.post('https://nc_inventory_bridge/display', JSON.stringify(event.data.type));
                break;
            default:
        }
    });
});