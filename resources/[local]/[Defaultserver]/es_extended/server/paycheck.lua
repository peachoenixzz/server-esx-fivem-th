function StartPayCheck()
  CreateThread(function()
    while true do
      Wait(Config.PaycheckInterval)

		for _, xPlayer in pairs(ESX.Players) do
			local job = xPlayer.job.grade_name
			local salary = xPlayer.job.grade_salary
			local items = "exp"
			if xPlayer.job.name == "police" then
				items = "exp_gov"
			end
		  if xPlayer.job.name ~= "police" then
			  xPlayer.addInventoryItem("exp", 1)
		  end
        if salary > 0 then
          if xPlayer.job.name == 'police' then -- generic job
			  xPlayer.addAccountMoney('bank', salary, "Paycheck")
			  xPlayer.addInventoryItem(items, 5)
          end
        end
      end
    end
  end)
end
