
-- Giant Dev 
-- https://discord.gg/AgutpzcVzv
-- Custom ui for your Server 


function DeleteCloth(_source)
	TriggerClientEvent("pNotify:SendNotification", _source, {
			text = '<strong class="green-text">ลบชุดเรียบร้อย</strong>',
			type = "success",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
end


function AddLimitCloth(_source,limit)
	TriggerClientEvent("pNotify:SendNotification", _source, {
		text = '<strong class="green-text">ตู้เสื้อผ้าเต็ม สามารถบันทึกได้สูงสุด </strong>'..limit.. ' ชุด',
		type = "error",
		timeout = 3000,
		layout = "bottomCenter",
		queue = "global"
	})
end


function DoneAddSlotSV(_source,price)
	TriggerClientEvent("pNotify:SendNotification", _source, {
				text = '<strong class="green-text">เพิ่ม SLOT เรียบร้อย จ่าย </strong>'..price,
				type = "success",
				timeout = 3000,
				layout = "bottomCenter",
				queue = "global"
			})
end



function DoneAddClothSV(_source,price)
	TriggerClientEvent("pNotify:SendNotification", _source, {
						text = '<strong class="green-text">บันทึกชุดเรียบร้อย จ่าย </strong>'..price,
						type = "success",
						timeout = 3000,
						layout = "bottomCenter",
						queue = "global"
					})

end


function PayAccessory(_source,accessory,price)

end

