ESX=nil
local a={}
local b={}
local c={}
TriggerEvent('esx:getSharedObject',function(d)ESX=d end)

RegisterServerEvent('esx:onRemoveInventoryItem')
AddEventHandler('esx:onRemoveInventoryItem',function(source,e,f)
    local g=source;SetTimeout(100,function()
        if not a[g]and not b[g]then 
            TriggerClientEvent('_esx:removeInventoryItem',g,e,f)
        end 
    end)
end)

RegisterServerEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem',function(h,i,j)
    local g = source
    local k = i
    local l = ESX.GetPlayerFromId(g)
    local e
    if h=='item_account'then 
        e={name=k,label=j,useCount=''}
    elseif h=='item_money'then 
        e={name=k,label=j,useCount=''}
    elseif h=='item_standard'then 
        e=l.getInventoryItem(k)e['useCount']=j..' ชิ้น'
    elseif h=='item_weapon'then 
        e={name=k,label=ESX.GetWeaponLabel(k)}
        TriggerClientEvent('_esx:dropWeapon',g,k)
    end
    b[g]={}b[g][k]=true
    TriggerClientEvent('_esx:dropItem',g,e)
    SetTimeout(500,function()b[g]=nil end)
end)

RegisterServerEvent('esx:useItem')
AddEventHandler('esx:useItem',function(i)
    local g = source
    local k = i
    local l = ESX.GetPlayerFromId(g)
    local e = l.getInventoryItem(k)a[g]={}a[g][k]=true
    TriggerClientEvent('_esx:useItem',g,e)
    SetTimeout(500,function()a[g]=nil 
    end)
end)