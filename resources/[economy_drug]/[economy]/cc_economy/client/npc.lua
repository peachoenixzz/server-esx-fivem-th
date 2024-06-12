RegisterFontFile('SanamDeklen')
fontId = RegisterFontId('SanamDeklen')

Citizen.CreateThread(function()
   
      --RequestModel(GetHashKey("u_m_y_rsranger_01"))
      --while not HasModelLoaded(GetHashKey("u_m_y_rsranger_01")) do
      --  Wait(1)
      --end
      for k,v in pairs(Config.zones) do
          RequestModel(GetHashKey(v.NPC))
          while not HasModelLoaded(GetHashKey(v.NPC)) do
          Wait(1)
          end
      end	

      for k,v in pairs(Config.zones) do
      ped =  CreatePed(4, v.NPC,v.coords.x,v.coords.y, v.coords.z-1, v.Pos.h, false, true)
      --SetEntityHeading(ped, v.Pos.h)
      FreezeEntityPosition(ped, true)
      SetEntityInvincible(ped, true)
      SetBlockingOfNonTemporaryEvents(ped, true)
      TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
      end   
end)
