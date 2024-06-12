local ESX = nil
local b=false
local c={}
local d=false
local e=false
local f=false
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject",function(obj)ESX = obj end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().accounts==nil do 
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
    c = PlayerData.accounts 
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded',function(h)b=true
    c = h.accounts 
end)

RegisterNetEvent("taeratto_invnotify:SendNotify")
AddEventHandler("taeratto_invnotify:SendNotify",function(i,j,k)
    SendNotify(i,j,k)
end)

function SendNotify(i,j,l)
    local k={}
    if l~=nil then 
        k=l 
    end
    k.inventory = Config.InventoryPath
    k.timeout = Config.DisplayTimeout*1000
    k.type=i
    if j.name~=nil and j.label~=nil then 
        SendNUIMessage({type='notify',item=j,options=k})
    end 
end

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney',function(m)
    for n=1,#c,1 do 
        if c[n].name=='black_money'and not e then 
            if c[n].money>m.money then 
                local o=c[n].money-m.money
                TriggerEvent("taeratto_invnotify:SendNotify",'remove',{name='black_money	',label=Config.BlackMoneyLabel:format(a.Math.GroupDigits(a.Math.Round(o))),useCount=''})
            else 
                local o=m.money-c[n].money
                TriggerEvent("taeratto_invnotify:SendNotify",'add',{name='black_money	',label=Config.BlackMoneyLabel:format(a.Math.GroupDigits(a.Math.Round(o))),useCount=''})
            end 
        end
        if c[n].name==m.name then 
            c[n]=m
            break 
        end
    end
    e=false 
end)

RegisterNetEvent("es:addedMoney")
AddEventHandler("es:addedMoney",function(p,q,r)
    TriggerEvent("taeratto_invnotify:SendNotify",'add',{name='cash',label=Config.CashLabel:format(p),useCount=''})
end)

RegisterNetEvent("es:removedMoney")
AddEventHandler("es:removedMoney",function(p,q,r)
    if not d then 
        TriggerEvent("taeratto_invnotify:SendNotify",'remove',{name='cash',label=Config.CashLabel:format(p),useCount=''})
    end
    d=false 
end)

RegisterNetEvent('_esx:useItem')
AddEventHandler('_esx:useItem',function(j)
    if j.name~=nil and j.label~=nil then 
        j['useCount']='1 ชิ้น'TriggerEvent("taeratto_invnotify:SendNotify",'use',j)
    end 
end)

RegisterNetEvent('_esx:dropItem')
AddEventHandler('_esx:dropItem',function(j)
    if j.name=='black_money'then 
        e=true;j.label=Config.BlackMoneyLabel:format(j.label)j['useCount']=''
    end
    if j.name=='cash'then 
        d=true;j.label=Config.CashLabel:format(j.label)j['useCount']=''
    end
    if j.name~=nil and j.label~=nil then 
        TriggerEvent("taeratto_invnotify:SendNotify",'remove',j,{action='ทิ้ง'})
    end 
end)

RegisterNetEvent('esx:addInventoryItem')
AddEventHandler('esx:addInventoryItem',function(j,s)
    if j.name~=nil and j.label~=nil then 
        j['useCount']=s..' ชิ้น'TriggerEvent("taeratto_invnotify:SendNotify",'add',j)
    end 
end)

RegisterNetEvent('_esx:removeInventoryItem')
AddEventHandler('_esx:removeInventoryItem',function(j,s)
    if j.name~=nil and j.label~=nil then 
        j['useCount']=s..' ชิ้น'TriggerEvent("taeratto_invnotify:SendNotify",'remove',j)
    end 
end)

RegisterNetEvent('esx:addWeapon')
AddEventHandler('esx:addWeapon',function(t,u)
    local v=a.GetWeaponLabel(t)
    local j={name=t,label=v}
    TriggerEvent("taeratto_invnotify:SendNotify",'add',j)
end)

RegisterNetEvent('_esx:dropWeapon')
AddEventHandler('_esx:dropWeapon',function(t)
    f=true 
end)

RegisterNetEvent('esx:removeWeapon')
AddEventHandler('esx:removeWeapon',function(t,u)
    if not f then 
        local v=a.GetWeaponLabel(t)
        local j={name=t,label=v}
        TriggerEvent("taeratto_invnotify:SendNotify",'remove',j)
    end
    f=false 
end)

Citizen.CreateThread(function()
    local w
    while true do 
        if a~=nil then 
            if Config.NotifyUseWeapon then 
                local x=GetPlayerPed(-1)
                if w~=GetSelectedPedWeapon(x)then 
                    w=GetSelectedPedWeapon(x)
                    local y,z=GetWeapon(w)
                    if z~=nil then 
                        local j={name=z.name,label=z.label,useCount='1 ชิ้น'}
                        TriggerEvent("taeratto_invnotify:SendNotify",'use',j)
                    end 
                end 
            end 
        end
        Wait(500)
    end 
end)

function GetWeapon(A)
    local B=a.GetWeaponList()
    for n=1,#B,1 do 
        if GetHashKey(B[n].name)==A then 
            return n,B[n]
        end 
    end 
end
