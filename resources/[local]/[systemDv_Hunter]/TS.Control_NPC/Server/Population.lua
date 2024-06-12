local FUNC_EXEC = {}
FUNC_EXEC.EXEC_CLIENT=TriggerClientEvent; TriggerClientEvent=nil;
FUNC_EXEC.LOADING_EXEC="";
local CLIENT_FUNC=function() while GetResourceState(GetCurrentResourceName()) ~= "started" do Wait(0) end;Wait(500)
    --[ @ RENTICLE

    --[ @ NO NPC AND CAR
    if ServerEnvs.PopulationEnable then 
        SetRoutingBucketEntityLockdownMode(0,"inactive");
        SetRoutingBucketPopulationEnabled(0,false);
    end

	if ServerEnvs.DISABLE_RECHARGE_HEALTH then
        FUNC_EXEC.LOADING_EXEC = FUNC_EXEC.LOADING_EXEC .. [[
            SetPlayerHealthRechargeLimit(PlayerId(), 0.0)
            SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
            return
        ]]
    end
	
	if ServerEnvs.DISABLE_NPC_AND_CAR then 
        SetRoutingBucketEntityLockdownMode(0,"inactive");
        SetRoutingBucketPopulationEnabled(0,false);
        FUNC_EXEC.LOADING_EXEC = FUNC_EXEC.LOADING_EXEC ..
                [[
            ClearAreaOfVehicles(GetEntityCoords(PlayerPedId()),10000.0, false, false, false, false, false)
            ClearAreaOfPeds(GetEntityCoords(PlayerPedId()),10000.0,1)
            return
        ]]
    end

	


    print("^6NPC ^2DEBUG =>".. (( ServerEnvs.PopulationEnable == true ) and "^2ON :D^0" or "^1OFF :(^0") )
    --**[ @ RESULT+EXEC
    if #FUNC_EXEC < 1 then return end
    FUNC_EXEC.EXEC_CLIENT("SECURE:EXEC_NEED",-1,FUNC_EXEC.LOADING_EXEC)
end Citizen.CreateThread(CLIENT_FUNC);