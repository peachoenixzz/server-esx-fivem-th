
--
-- งานนี้ได้รับใบอนุญาตภายใต้ใบอนุญาตระหว่างประเทศ Creative Commons Attribution-ShareAlike 4.0
--
-- https://github.com/iEns/RealisticVehicleFailure
--


-- การกำหนดค่า:

-- สำคัญ: ค่าเหล่านี้บางค่าต้องกำหนดเป็นหมายเลขจุดลอยตัว กล่าวคือ 10.0 แทน 10

cfg = {
	deformationMultiplier = -1.0,					-- รถยนต์ควรมองเห็นได้จากการชนกันมากน้อยแค่ไหน ช่วง 0.0 ถึง 10.0 โดยที่ 0.0 ไม่มีการเสียรูปและ 10.0 คือการเสียรูป 10 เท่า -1 = อย่าสัมผัส ความเสียหายจากภาพไม่ซิงค์กับผู้เล่นรายอื่น
	deformationExponent = 0.4,					-- ควรบีบอัดการจัดการการตั้งค่าการเปลี่ยนรูปของไฟล์เป็น 1.0 (ทำให้รถดูคล้ายกันมาก) ค่า 1 = ไม่มีการเปลี่ยนแปลง ค่าที่ต่ำกว่าจะบีบอัดค่ามากกว่า 1 จะขยาย อย่าตั้งค่าเป็นศูนย์หรือลบ
	collisionDamageExponent = 0.6,				-- ควรบีบอัดการจัดการการเปลี่ยนแปลงการจัดรูปแบบแฟ้มเป็น 1.0 อย่างไร (ทำให้รถดูคล้ายกันมาก) ค่า 1 = ไม่มีการเปลี่ยนแปลง ค่าที่ต่ำกว่าจะบีบอัดค่ามากกว่า 1 จะขยาย อย่าตั้งค่าเป็นศูนย์หรือลบ

	damageFactorEngine = 10.0,					-- ค่าที่เป็นกลางคือ 1 ถึง 100 ค่าที่สูงขึ้นหมายถึงความเสียหายมากขึ้นกับยานพาหนะ จุดเริ่มต้นที่ดีคือ 10
	damageFactorBody = 10.0,					-- ค่าที่เป็นกลางคือ 1 ถึง 100 ค่าที่สูงขึ้นหมายถึงความเสียหายมากขึ้นกับยานพาหนะ จุดเริ่มต้นที่ดีคือ 10
	damageFactorPetrolTank = 16.0,				-- ค่าที่เป็นกลางคือ 1 ถึง 200 ค่าที่สูงขึ้นหมายถึงความเสียหายมากขึ้นกับยานพาหนะ จุดเริ่มต้นที่ดีคือ 64
	engineDamageExponent = 0.6,					-- ควรบีบอัดการจัดการความเสียหายของเครื่องมือไฟล์เป็นจำนวน 1.0 เท่า (ทำให้รถดูคล้ายกันมาก) ค่า 1 = ไม่มีการเปลี่ยนแปลง ค่าที่ต่ำกว่าจะบีบอัดค่ามากกว่า 1 จะขยาย อย่าตั้งค่าเป็นศูนย์หรือลบ
	weaponsDamageMultiplier = 0.01,				-- ยานพาหนะได้รับความเสียหายเท่าใดจากการยิงอาวุธ ช่วง 0.0 ถึง 10.0 โดยที่ 0.0 ไม่มีความเสียหายและ 10.0 มีความเสียหาย 10 เท่า -1 = อย่าแตะต้อง
	degradingHealthSpeedFactor = 10,			-- ความเร็วของการย่อยสลายอย่างช้าๆต่อสุขภาพ แต่ไม่ใช่ความล้มเหลว ค่าของ 10 หมายความว่าจะใช้เวลาประมาณ 0.25 วินาทีต่อจุดสุขภาพดังนั้นการย่อยสลายตั้งแต่ 800 ถึง 305 จะใช้เวลาประมาณ 2 นาทีในการขับขี่ที่สะอาด ค่าที่สูงขึ้นหมายถึงการย่อยสลายได้เร็วขึ้น
	cascadingFailureSpeedFactor = 8.0,			-- ค่าที่เป็นอันตรายคือ 1 ถึง 100 เมื่อสุขภาพรถลดลงต่ำกว่าจุดหนึ่งความล้มเหลวของ cascading จะลดลงและสุขภาพจะลดลงอย่างรวดเร็วจนกว่ารถจะตาย ค่าที่สูงขึ้นหมายถึงความล้มเหลวได้เร็วขึ้น จุดเริ่มต้นที่ดีคือ 8

	degradingFailureThreshold = 800.0,			-- ด้านล่างค่านี้การย่อยสลายทางสุขภาพที่ช้าจะเกิดขึ้น
	cascadingFailureThreshold = 360.0,			-- ด้านล่างค่านี้ความล้มเหลวของ cascading สุขภาพจะตั้งค่าไว้
	engineSafeGuard = 100.0,					-- ค่าความล้มเหลวขั้นสุดท้าย ตั้งค่าให้สูงเกินไปและรถจะไม่สูบบุหรี่เมื่อปิดใช้งาน ตั้งค่าต่ำเกินไปและรถจะยิงจากกระสุนเดี่ยวไปยังเครื่องยนต์ ที่สุขภาพ 100 รถทั่วไปสามารถใช้กระสุน 3-4 เพื่อเครื่องยนต์ก่อนที่จะจับไฟ

	torqueMultiplierEnabled = true,				-- ลดแรงบิดของเครื่องยนต์เนื่องจากเครื่องยนต์ได้รับความเสียหายมากขึ้น

	limpMode = false,							-- ถ้าเป็นจริงเครื่องยนต์จะไม่ทำงานไม่สมบูรณ์ดังนั้นคุณจะสามารถหาช่างเครื่องได้เสมอไปเว้นแต่คุณจะพลิกรถของคุณและป้องกันไม่ให้ VehicleFlip ตั้งค่าเป็น true
	limpModeMultiplier = 0.15,					-- ตัวคูณแรงบิดที่ใช้เมื่อยานพาหนะกำลังขรุขระ

	preventVehicleFlip = true,					-- ถ้าเป็นจริงคุณจะไม่สามารถพลิกคว่ำลงได้

	sundayDriver = false,						-- ถ้าเป็นจริงการตอบสนองของเครื่องเร่งความเร็วจะถูกปรับขนาดเพื่อให้สามารถขับขี่ได้ช้า จะไม่ป้องกันไม่ให้คันเร่งเต็มรูปแบบ ไม่ทำงานกับเครื่องเร่งแบบไบนารีเช่นแป้นพิมพ์ ตั้งค่าเป็น false เพื่อปิดใช้งาน คุณสมบัติการหยุดโดยไม่มีการย้อนกลับและเบรคไลท์ยังใช้สำหรับคีย์บอร์ดได้
	sundayDriverAcceleratorCurve = 7.5,			-- เส้นโค้งการตอบสนองที่จะใช้กับเครื่องเร่งอนุภาค ช่วง 0.0 ถึง 10.0 ค่าที่สูงขึ้นจะช่วยให้การขับขี่ช้าลงได้ง่ายขึ้นซึ่งหมายความว่าจะต้องมีแรงกดบนคันเร่งมากขึ้นเพื่อเร่งไปข้างหน้า ไม่มีอะไรสำหรับโปรแกรมควบคุมแป้นพิมพ์
	sundayDriverBrakeCurve = 5.0,				-- เส้นตอบสนองที่จะใช้กับเบรค ช่วง 0.0 ถึง 10.0 ค่าที่สูงขึ้นช่วยให้สามารถเบรคได้ง่ายขึ้นซึ่งหมายความว่าแรงกดบนเค้นจะต้องเบรคมาก ไม่มีอะไรสำหรับโปรแกรมควบคุมแป้นพิมพ์

	displayBlips = false,						-- แสดง blips สำหรับตำแหน่งช่างซ่อม

	compatibilityMode = false,					-- ป้องกันไม่ให้สคริปต์อื่น ๆ ปรับเปลี่ยนสุขภาพของถังเชื้อเพลิงเพื่อหลีกเลี่ยงความล้มเหลวของเครื่องยนต์แบบสุ่มด้วย BVA 2.01 (ข้อเสียคือการป้องกันการระเบิด)

	randomTireBurstInterval = 0,				-- จำนวนนาที (อย่างมีนัยสำคัญทางสถิติ) เพื่อขับเกิน 22 ไมล์ต่อชั่วโมงก่อนที่คุณจะได้รับการเจาะยาง 0 = คุณลักษณะถูกปิดใช้งาน


	-- คูณตัวสร้างความเสียหายระดับชั้น
	-- ความเสียหายที่เกิดขึ้นจากเครื่องยนต์ส่วนลำตัวและ Petroltank จะถูกคูณด้วยค่านี้ขึ้นอยู่กับประเภทของยานพาหนะ
	-- ใช้มันเพื่อเพิ่มหรือลดความเสียหายสำหรับแต่ละชั้น

	classDamageMultiplier = {
		[0] = 	0.7,		--	0: Compacts
				0.7,		--	1: Sedans
				0.7,		--	2: SUVs
				0.7,		--	3: Coupes
				0.7,		--	4: Muscle
				0.7,		--	5: Sports Classics
				0.7,		--	6: Sports
				0.7,		--	7: Super
				0.25,		--	8: Motorcycles
				0.5,		--	9: Off-road
				0.25,		--	10: Industrial
				0.2,		--	11: Utility
				0.7,		--	12: Vans
				0.7,		--	13: Cycles
				0.01,		--	14: Boats
				0.7,		--	15: Helicopters
				0.7,		--	16: Planes
				0.1,		--	17: Service
				0.1,		--	18: Emergency
				0.1,		--	19: Military
				0.7,		--	20: Commercial
				0.7			--	21: Trains
	}
}



--[[

	-- Alternate configuration values provided by ImDylan93 - Vehicles can take more damage before failure, and the balance between vehicles has been tweaked.
	-- To use: comment out the settings above, and uncomment this section.

cfg = {

	deformationMultiplier = -1,					-- How much should the vehicle visually deform from a collision. Range 0.0 to 10.0 Where 0.0 is no deformation and 10.0 is 10x deformation. -1 = Don't touch
	deformationExponent = 1.0,					-- How much should the handling file deformation setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.
	collisionDamageExponent = 1.0,				-- How much should the handling file deformation setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.

	damageFactorEngine = 5.1,					-- Sane values are 1 to 100. Higher values means more damage to vehicle. A good starting point is 10
	damageFactorBody = 5.1,						-- Sane values are 1 to 100. Higher values means more damage to vehicle. A good starting point is 10
	damageFactorPetrolTank = 61.0,				-- Sane values are 1 to 100. Higher values means more damage to vehicle. A good starting point is 64
	engineDamageExponent = 1.0,					-- How much should the handling file engine damage setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.
	weaponsDamageMultiplier = 0.124,			-- How much damage should the vehicle get from weapons fire. Range 0.0 to 10.0, where 0.0 is no damage and 10.0 is 10x damage. -1 = don't touch
	degradingHealthSpeedFactor = 7.4,			-- Speed of slowly degrading health, but not failure. Value of 10 means that it will take about 0.25 second per health point, so degradation from 800 to 305 will take about 2 minutes of clean driving. Higher values means faster degradation
	cascadingFailureSpeedFactor = 1.5,			-- Sane values are 1 to 100. When vehicle health drops below a certain point, cascading failure sets in, and the health drops rapidly until the vehicle dies. Higher values means faster failure. A good starting point is 8

	degradingFailureThreshold = 677.0,			-- Below this value, slow health degradation will set in
	cascadingFailureThreshold = 310.0,			-- Below this value, health cascading failure will set in
	engineSafeGuard = 100.0,					-- Final failure value. Set it too high, and the vehicle won't smoke when disabled. Set too low, and the car will catch fire from a single bullet to the engine. At health 100 a typical car can take 3-4 bullets to the engine before catching fire.

	torqueMultiplierEnabled = true,				-- Decrease engine torge as engine gets more and more damaged

	limpMode = false,							-- If true, the engine never fails completely, so you will always be able to get to a mechanic unless you flip your vehicle and preventVehicleFlip is set to true
	limpModeMultiplier = 0.15,					-- The torque multiplier to use when vehicle is limping. Sane values are 0.05 to 0.25

	preventVehicleFlip = true,					-- If true, you can't turn over an upside down vehicle

	sundayDriver = true,						-- If true, the accelerator response is scaled to enable easy slow driving. Will not prevent full throttle. Does not work with binary accelerators like a keyboard. Set to false to disable. The included stop-without-reversing and brake-light-hold feature does also work for keyboards.
	sundayDriverAcceleratorCurve = 7.5,			-- The response curve to apply to the accelerator. Range 0.0 to 10.0. Higher values enables easier slow driving, meaning more pressure on the throttle is required to accelerate forward. Does nothing for keyboard drivers
	sundayDriverBrakeCurve = 5.0,				-- The response curve to apply to the Brake. Range 0.0 to 10.0. Higher values enables easier braking, meaning more pressure on the throttle is required to brake hard. Does nothing for keyboard drivers

	displayBlips = true,						-- Show blips for mechanics locations

	classDamageMultiplier = {
		[0] = 	1.0,		--	0: Compacts
				1.0,		--	1: Sedans
				1.0,		--	2: SUVs
				0.95,		--	3: Coupes
				1.0,		--	4: Muscle
				0.95,		--	5: Sports Classics
				0.95,		--	6: Sports
				0.95,		--	7: Super
				0.27,		--	8: Motorcycles
				0.7,		--	9: Off-road
				0.25,		--	10: Industrial
				0.35,		--	11: Utility
				0.85,		--	12: Vans
				1.0,		--	13: Cycles
				0.4,		--	14: Boats
				0.7,		--	15: Helicopters
				0.7,		--	16: Planes
				0.75,		--	17: Service
				0.85,		--	18: Emergency
				0.67,		--	19: Military
				0.43,		--	20: Commercial
				1.0			--	21: Trains
	}
}

]]--





-- End of Main Configuration

-- Configure Repair system

-- id=446 for wrench icon, id=72 for spraycan icon

repairCfg = {
	mechanics = {
		{name="Mechanic", id=446, r=25.0, x=-337.0,  y=-135.0,  z=39.0},	-- LSC Burton
		{name="Mechanic", id=446, r=25.0, x=-1155.0, y=-2007.0, z=13.0},	-- LSC by airport
		{name="Mechanic", id=446, r=25.0, x=734.0,   y=-1085.0, z=22.0},	-- LSC La Mesa
		{name="Mechanic", id=446, r=25.0, x=1177.0,  y=2640.0,  z=37.0},	-- LSC Harmony
		{name="Mechanic", id=446, r=25.0, x=108.0,   y=6624.0,  z=31.0},	-- LSC Paleto Bay
		{name="Mechanic", id=446, r=18.0, x=538.0,   y=-183.0,  z=54.0},	-- Mechanic Hawic
		{name="Mechanic", id=446, r=15.0, x=1774.0,  y=3333.0,  z=41.0},	-- Mechanic Sandy Shores Airfield
		{name="Mechanic", id=446, r=15.0, x=1143.0,  y=-776.0,  z=57.0},	-- Mechanic Mirror Park
		{name="Mechanic", id=446, r=30.0, x=2508.0,  y=4103.0,  z=38.0},	-- Mechanic East Joshua Rd.
		{name="Mechanic", id=446, r=16.0, x=2006.0,  y=3792.0,  z=32.0},	-- Mechanic Sandy Shores gas station
		{name="Mechanic", id=446, r=25.0, x=484.0,   y=-1316.0, z=29.0},	-- Hayes Auto, Little Bighorn Ave.
		{name="Mechanic", id=446, r=33.0, x=-1419.0, y=-450.0,  z=36.0},	-- Hayes Auto Body Shop, Del Perro
		{name="Mechanic", id=446, r=33.0, x=268.0,   y=-1810.0, z=27.0},	-- Hayes Auto Body Shop, Davis
	--	{name="Mechanic", id=446, r=24.0, x=288.0,   y=-1730.0, z=29.0},	-- Hayes Auto, Rancho (Disabled, looks like a warehouse for the Davis branch)
		{name="Mechanic", id=446, r=27.0, x=1915.0,  y=3729.0,  z=32.0},	-- Otto's Auto Parts, Sandy Shores
		{name="Mechanic", id=446, r=45.0, x=-29.0,   y=-1665.0, z=29.0},	-- Mosley Auto Service, Strawberry
		{name="Mechanic", id=446, r=44.0, x=-212.0,  y=-1378.0, z=31.0},	-- Glass Heroes, Strawberry
		{name="Mechanic", id=446, r=33.0, x=258.0,   y=2594.0,  z=44.0},	-- Mechanic Harmony
		{name="Mechanic", id=446, r=18.0, x=-32.0,   y=-1090.0, z=26.0},	-- Simeons
		{name="Mechanic", id=446, r=25.0, x=-211.0,  y=-1325.0, z=31.0},	-- Bennys
		{name="Mechanic", id=446, r=25.0, x=903.0,   y=3563.0,  z=34.0},	-- Auto Repair, Grand Senora Desert
		{name="Mechanic", id=446, r=25.0, x=437.0,   y=3568.0,  z=38.0}		-- Auto Shop, Grand Senora Desert
	},

	fixMessages = {
		"You put the oil plug back in",
		"You stopped the oil leak using chewing gum",
		"You repaired the oil tube with gaffer tape",
		"You tightened the oil pan screw and stopped the dripping",
		"You kicked the engine and it magically came back to life",
		"You removed some rust from the spark tube",
		"You yelled at your vehicle, and it somehow had an effect"
	},
	fixMessageCount = 7,

	noFixMessages = {
		"You checked the oil plug. It's still there",
		"You looked at your engine, it seemed fine",
		"You made sure that the gaffer tape was still holding the engine together",
		"You turned up the radio volume. It just drowned out the weird engine noises",
		"You added rust-preventer to the spark tube. It made no difference",
		"Never fix something that ain't broken they said. You didn't listen. At least it didn't get worse"
	},
	noFixMessageCount = 6
}

RepairEveryoneWhitelisted = true
RepairWhitelist =
{
	"steam:123456789012345",
	"steam:000000000000000",
	"ip:192.168.0.1"			-- not sure if ip whitelist works?
}
