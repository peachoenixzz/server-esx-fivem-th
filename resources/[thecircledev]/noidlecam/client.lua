Citizen.CreateThread(function()
  while true do
    InvalidateIdleCam()
    InvalidateVehicleIdleCam()
    Wait(1000)
  end
end)