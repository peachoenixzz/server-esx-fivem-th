
local alreadyCheckNPC = false
local models = {
        "s_f_y_stripper_02", "csb_stripper_01","csb_bogdan","mp_m_bogdangoon"
}

AddRelationshipGroup("MAGE_MONSTER") --creates a new relationship group for submarine crew
SetRelationshipBetweenGroups(5, "MAGE_MONSTER", "PLAYER") --sets submarine crew to hate player peds
SetRelationshipBetweenGroups(0, "MAGE_MONSTER", "MAGE_MONSTER") --sets submarine crew to be companions with each other


totalNPC = 10
npcs = {}


Citizen.CreateThread(function()
        for _, model in ipairs(models) do
                RequestModel(model)
                while not HasModelLoaded(model) do
                        Citizen.Wait(0)
                end
        end
end)

function settingNPC()
        local coords = GetPlayerCoordsAsync()
        for _,v in ipairs(npcs) do
                                --print(v.positionNPC)
                if GetDistanceBetweenCoords(coords, v.positionNPC, true) < 300 then
                        local convertNetIDtoPed =  NetToPed(v.npcNetworkId)
                                        --print(v.sessionNPC , v.npcNetworkId,convertNetIDtoPed)
                        if convertNetIDtoPed ~= 0 then
                                --SetEntityAsMissionEntity(convertNetIDtoPed, true, true)
                                --SetNetworkIdExistsOnAllMachines(v.npcNetworkId, true)
                                SetPedRelationshipGroupHash(convertNetIDtoPed, GetHashKey(v.group))
                                SetPedMaxHealth(convertNetIDtoPed, 200)
                                SetEntityHealth(convertNetIDtoPed, 150)
                                SetPedSeeingRange(convertNetIDtoPed, 300.0)
                                SetPedHearingRange(convertNetIDtoPed, 300.0)
                                SetPedCombatAbility(convertNetIDtoPed, 2)
                                SetPedCombatAttributes(convertNetIDtoPed, 46, 1)
                                SetPedFleeAttributes(convertNetIDtoPed, 0, true)
                                SetPedCombatRange(convertNetIDtoPed,2)
                                --SetPedArmour(convertNetIDtoPed, 100)
                                SetPedAccuracy(convertNetIDtoPed, 100)
                                GiveWeaponToPed(convertNetIDtoPed, GetHashKey('WEAPON_WRENCH'), 1, false, true)
                                --SetEntityProofs(convertNetIDtoPed, true, true, true, false, false, true, true, true)
                                --SET_ENTITY_PROOFS(Entity entity, BOOL bulletProof, BOOL fireProof, BOOL explosionProof, BOOL collisionProof, BOOL meleeProof, BOOL steamProof, BOOL p7, BOOL drownProof);
                                TaskCombatPed(convertNetIDtoPed, GetPlayerPed(-1), 0, 16)
                        end
                end
        end
end

RegisterNetEvent("pedenemy:collectNPC")
AddEventHandler("pedenemy:collectNPC", function(detailNPC)
        npcs = detailNPC
        settingNPC()
end)


function GetPlayerCoordsAsync()
        return Citizen.InvokeNative(0x3FEF770D40960D5A, PlayerPedId(), Citizen.ReturnResultAnyway(),
                Citizen.ResultAsVector())
end

function deleteAllNPC()
        for _,v in ipairs(npcs) do
                DeleteEntity(v.sessionNPC)
        end
end

function deleteNPC()
        local key = npcKey
        TriggerServerEvent('cc_selldrug:deleteDrugSeller',key)
end

RegisterNetEvent("pedenemy:updateDataNPCtoUser")
AddEventHandler("pedenemy:updateDataNPCtoUser", function(detailNPC)
        npcs = detailNPC
end)


AddEventHandler("esx:playerDropped", function(playerId)
        firstSendData[playerId] = nil
end)


AddEventHandler("onResourceStop", function(resource)
        if resource == GetCurrentResourceName() then
                npcs = {}
        end
end)


