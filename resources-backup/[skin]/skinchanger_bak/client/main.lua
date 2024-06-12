local Components = {
	{label = ('เพศ'),						name = 'sex',				value = 0,		min = 0,	zoomOffset = 1.8,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('สีผิว'),					name = 'skin',				value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('หน้า'),					name = 'face',				value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('สีตา'),				name = 'eye_color',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65}, -- FIVEMTURK


	--{label = 'จมูก ความกว้าง',						name = 'nose_width',			value = 0,		min = -20,	zoomOffset = 1.0,		camOffset = 0.15}, -- FIVEMTURK
	--{label = 'จมูก ความโด่ง',				name = 'nose_peak_lenght',		value = 0,		min = -20,	zoomOffset = 1.0,		camOffset = 0.15}, -- FIVEMTURK
	--{label = 'จมูก ความสูง',					name = 'nose_peak_hight',		value = 0,		min = -20,	zoomOffset = 1.0,		camOffset = 0.15}, -- FIVEMTURK
	--{label = 'จมูก ความโค้ง',					name = 'nose_bone_high',		value = 0,		min = -20,	zoomOffset = 1.0,		camOffset = 0.15}, -- FIVEMTURK
	--{label = 'จมูก ความย้าน',					name = 'nose_peak_lowering',	value = 0,		min = -20,	zoomOffset = 1.0,		camOffset = 0.15}, -- FIVEMTURK
	--{label = 'สันจมูก',					name = 'nose_bone_twist',		value = 0,		min = -20,	zoomOffset = 1.0,		camOffset = 0.15}, -- FIVEMTURK
	--{label = 'คิว ความสูง',					name = 'eyebrown_high',			value = 0,		min = -20,	zoomOffset = 1.0,		camOffset = 0.15}, -- FIVEMTURK
	--{label = 'คิว forward',				name = 'eyebrown_forward',		value = 0,		min = -20,	zoomOffset = 1.0,		camOffset = 0.15}, -- FIVEMTURK
	--{label = 'แก้ม กระดูก สูง',				name = 'cheeks_bone_high',		value = 0,		min = -20,	zoomOffset = 1.0,		camOffset = 0.15}, -- FIVEMTURK
	--{label = 'แก้ม กระดูก กว้าง',				name = 'cheeks_bone_width',	value = 0,		min = -20,	zoomOffset = 1.0,		camOffset = 0.15}, -- FIVEMTURK
	--{label = 'แก้ม ความกว้าง',					name = 'cheeks_width',		value = 0,		min = -20,	zoomOffset = 1.0,		camOffset = 0.15}, -- FIVEMTURK
	--{label = 'ความกว้างของตา',					name = 'eyes_openning',		value = 0,		min = -20,	zoomOffset = 1.0,		camOffset = 0.15}, -- FIVEMTURK
	--{label = 'ริมฝีปาก ความหนา',					name = 'lips_thickness',		value = 0,		min = -20,	zoomOffset = 1.0,		camOffset = 0.15}, -- FIVEMTURK
	--{label = 'ขากรรไกร กระดูกความกว้าง',					name = 'jaw_bone_width',		value = 0,		min = -20,	zoomOffset = 1.0,		camOffset = 0.15}, -- FIVEMTURK
	--{label = 'ขากรรไกร กระดูกความยาว',			name = 'jaw_bone_back_lenght',		value = 0,		min = -20,	zoomOffset = 1.0,		camOffset = 0.15}, -- FIVEMTURK

	--{label = 'คาง ความยาว',				name = 'chimp_bone_lowering',		value = 0,		min = -20,	zoomOffset = 1.0,		camOffset = 0.15}, -- FIVEMTURK
	--{label = 'คาง ความยาน',				name = 'chimp_bone_lenght',		value = 0,		min = -20,	zoomOffset = 1.0,		camOffset = 0.15}, -- FIVEMTURK
	--{label = 'คาง ความกว้าง',				name = 'chimp_bone_width',		value = 0,		min = -20,	zoomOffset = 1.0,		camOffset = 0.15}, -- FIVEMTURK
	--{label = 'คาง ระยะห่าง',						name = 'chimp_hole',		value = 0,		min = -20,	zoomOffset = 1.0,		camOffset = 0.15}, -- FIVEMTURK
	--{label = 'คอ ความหนา',					name = 'neck_thikness',		value = 0,		min = -20,	zoomOffset = 1.0,		camOffset = 0.15}, -- FIVEMTURK
	
	
	{label = ('ผิว'),					name = 'complexion_1',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = ('ความหนา'),				name = 'complexion_2',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = ('ริ้วรอย'),				name = 'age_1',				value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('ความหนา'),		name = 'age_2',				value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('กระ'),				name = 'moles_1',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('ความหนา'),				name = 'moles_2',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('ทรงผม'),			name = 'hair_1',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('ทรงผม 2'),			name = 'hair_2',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('สีผม 1'),			name = 'hair_color_1',		value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('สีผม 2'),			name = 'hair_color_2',		value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('เครา'),				name = 'beard_1',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('ความหนา'),				name = 'beard_2',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('สีเครา 1'),			name = 'beard_3',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('สีเครา 2'),			name = 'beard_4',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('คิ้ว'),			name = 'eyebrows_1',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('ความหนา'),			name = 'eyebrows_2',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('สีคิ้ว 1'),			name = 'eyebrows_3',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('สีคิ้ว 2'),			name = 'eyebrows_4',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('เมคอัพ'),				name = 'makeup_1',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('ความหนา'),		name = 'makeup_2',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('สีเมคอัพ 1'),			name = 'makeup_3',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('สีเมคอัพ 2'),			name = 'makeup_4',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('ลิปสติก'),			name = 'lipstick_1',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('ความหนา'),		name = 'lipstick_2',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('สีลิปสติก 1'),		name = 'lipstick_3',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('สีลิปสติก 2'),		name = 'lipstick_4',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('บลัชออน'),					name = 'blush_1',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('ความหนา'),					name = 'blush_2',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('สีบลัชออน'),				name = 'blush_3',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('ขนหน้าอก'),				name = 'chest_1',			value = 0,		min = 0,	zoomOffset = 1.0,		camOffset = 0.15}, -- FIVEMTURK
	{label = ('ความหนา'),			name = 'chest_2',			value = 0,		min = 0,	zoomOffset = 1.0,		camOffset = 0.15}, -- FIVEMTURK
	{label = ('สีขนหน้าอก'),				name = 'chest_3',			value = 0,		min = 0,	zoomOffset = 1.0,		camOffset = 0.15}, -- FIVEMTURK
	{label = ('เสื้อใน'),				name = 'tshirt_1',			value = 0,		min = 0,	zoomOffset = 1.0,		camOffset = 0.15},
	{label = ('สี'),				name = 'tshirt_2',			value = 0,		min = 0,	zoomOffset = 1.0,		camOffset = 0.15,	textureof	= 'tshirt_1'}, -- FIVEMTURK
	{label = ('เสื้อนอก'),					name = 'torso_1',			value = 0,		min = 0,	zoomOffset = 1.0,		camOffset = 0.15}, -- FIVEMTURK
	{label = ('สี'),					name = 'torso_2',			value = 0,		min = 0,	zoomOffset = 1.0,		camOffset = 0.15,	textureof	= 'torso_1'}, -- FIVEMTURK
	{label = ('สติ๊กเกอร์'),				name = 'decals_1',			value = 0,		min = 0,	zoomOffset = 1.0,		camOffset = 0.15}, -- FIVEMTURK
	{label = ('สี'),				name = 'decals_2',			value = 0,		min = 0,	zoomOffset = 1.0,		camOffset = 0.15,	textureof	= 'decals_1'}, -- FIVEMTURK
	{label = ('แขน'),					name = 'arms',				value = 0,		min = 0,	zoomOffset = 1.0,		camOffset = 0.15}, -- FIVEMTURK
	{label = ('สี'),					name = 'arms_2',			value = 0,		min = 0,	zoomOffset = 1.0,		camOffset = 0.15}, -- FIVEMTURK
	{label = ('กางเกง'),					name = 'pants_1',			value = 0,		min = 0,	zoomOffset = 1.0,		camOffset = -0.5}, -- FIVEMTURK
	{label = ('สี'),					name = 'pants_2',			value = 0,		min = 0,	zoomOffset = 1.0,		camOffset = -0.5,	textureof	= 'pants_1'}, -- FIVEMTURK
	{label = ('รองเท้า'),					name = 'shoes_1',			value = 0,		min = 0,	zoomOffset = 0.8,		camOffset = -0.8}, -- FIVEMTURK
	{label = ('สี'),					name = 'shoes_2',			value = 0,		min = 0,	zoomOffset = 0.8,		camOffset = -0.8,	textureof	= 'shoes_1'}, -- FIVEMTURK
	{label = ('หน้ากาก'),						name = 'mask_1',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('สี'),					name = 'mask_2',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65,	textureof	= 'mask_1'}, -- FIVEMTURK
	{label = ('เกราะ'),					name = 'bproof_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15}, -- FIVEMTURK
	{label = ('สี'),				name = 'bproof_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'bproof_1'}, -- FIVEMTURK
	{label = ('สร้อยคอ'),						name = 'chain_1',			value = 0,		min = 0,	zoomOffset = 1.0,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('สี'),				name = 'chain_2',			value = 0,		min = 0,	zoomOffset = 1.0,		camOffset = 0.65,	textureof	= 'chain_1'}, -- FIVEMTURK
	{label = ('หมวก'),					name = 'helmet_1',			value = -1,		min = -1,	zoomOffset = 0.6,		camOffset = 0.65 }, -- FIVEMTURK
	{label = ('สี'),				name = 'helmet_2',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65,	textureof	= 'helmet_1'}, -- FIVEMTURK
	{label = ('แว่นตา'),					name = 'glasses_1',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65}, -- FIVEMTURK
	{label = ('สี'),				name = 'glasses_2',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65,	textureof	= 'glasses_1'}, -- FIVEMTURK
	{label = ('นาฬิกา'),					name = 'watches_1',			value = -1,		min = -1,	zoomOffset = 0.75,		camOffset = 0.15}, -- FIVEMTURK
	{label = ('สี'),					name = 'watches_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'watches_1'}, -- FIVEMTURK
	{label = ('กำไลข้อมือ'),					name = 'bracelets_1',		value = -1,		min = -1,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = ('สี'),				name = 'bracelets_2',		value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'bracelets_1'}, -- FIVEMTURK
	{label = ('กระเป๋า'),							name = 'bags_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15}, -- FIVEMTURK
	{label = ('สี'),						name = 'bags_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'bags_1'}, -- FIVEMTURK
	{label = ('ต่างหู'),							name = 'ears_1',			value = -1,		min = -1,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = ('สี'),						name = 'ears_2',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65,	textureof	= 'ears_1'}, -- FIVEMTURK




}

local LastSex		= -1
local LoadSkin		= nil
local LoadClothes	= nil
local Character		= {}

for i=1, #Components, 1 do
	Character[Components[i].name] = Components[i].value
end

function LoadDefaultModel(malePed, cb)
	local playerPed = PlayerPedId()
	local characterModel

	if malePed then
		characterModel = GetHashKey('mp_m_freemode_01') -- FIVEMTURK
	else -- FIVEMTURK
		characterModel = GetHashKey('mp_f_freemode_01') -- FIVEMTURK
	end

	RequestModel(characterModel)

	Citizen.CreateThread(function()
		while not HasModelLoaded(characterModel) do -- FIVEMTURK
			RequestModel(characterModel) -- FIVEMTURK
			Citizen.Wait(0) -- FIVEMTURK
		end

		if IsModelInCdimage(characterModel) and IsModelValid(characterModel) then -- FIVEMTURK
			SetPlayerModel(PlayerId(), characterModel)
			SetPedDefaultComponentVariation(playerPed)
		end

		SetModelAsNoLongerNeeded(characterModel) -- FIVEMTURK

		if cb ~= nil then -- FIVEMTURK
			cb()
		end

		TriggerEvent('skinchanger:modelLoaded') -- FIVEMTURK
	end)
end

function GetMaxVals()
	local playerPed = PlayerPedId()

	local data = {
		sex				= 1,
		face			= 45,
		skin			= 45,
		age_1			= GetNumHeadOverlayValues(3)-1,
		age_2			= 10,
		beard_1			= GetNumHeadOverlayValues(1)-1,
		beard_2			= 10,
		beard_3			= GetNumHairColors()-1,
		beard_4			= GetNumHairColors()-1,
		hair_1			= GetNumberOfPedDrawableVariations		(playerPed, 2) - 1,
		hair_2			= GetNumberOfPedTextureVariations		(playerPed, 2, Character['hair_1']) - 1,
		hair_color_1	= GetNumHairColors()-1,
		hair_color_2	= GetNumHairColors()-1,
		eye_color		= 31,
		eyebrows_1		= GetNumHeadOverlayValues(2)-1,
		eyebrows_2		= 10,
		eyebrows_3		= GetNumHairColors()-1,
		eyebrows_4		= GetNumHairColors()-1,
		makeup_1		= GetNumHeadOverlayValues(4)-1,
		makeup_2		= 10,
		makeup_3		= GetNumHairColors()-1,
		makeup_4		= GetNumHairColors()-1,
		lipstick_1		= GetNumHeadOverlayValues(8)-1,
		lipstick_2		= 10,
		lipstick_3		= GetNumHairColors()-1,
		lipstick_4		= GetNumHairColors()-1,
		blush_1			= GetNumHeadOverlayValues(5)-1,
		blush_2			= 10,
		blush_3			= GetNumHairColors()-1,
		complexion_1	= GetNumHeadOverlayValues(6)-1,
		complexion_2	= 10,

		moles_1			= GetNumHeadOverlayValues(9)-1,
		moles_2			= 10,
		chest_1			= GetNumHeadOverlayValues(10)-1,
		chest_2			= 10,
		chest_3			= GetNumHairColors()-1,
		ears_1			= GetNumberOfPedPropDrawableVariations	(playerPed, 1) - 1,
		ears_2			= GetNumberOfPedPropTextureVariations	(playerPed, 1, Character['ears_1'] - 1),
		tshirt_1		= GetNumberOfPedDrawableVariations		(playerPed, 8) - 1,
		tshirt_2		= GetNumberOfPedTextureVariations		(playerPed, 8, Character['tshirt_1']) - 1,
		torso_1			= GetNumberOfPedDrawableVariations		(playerPed, 11) - 1,
		torso_2			= GetNumberOfPedTextureVariations		(playerPed, 11, Character['torso_1']) - 1,
		decals_1		= GetNumberOfPedDrawableVariations		(playerPed, 10) - 1,
		decals_2		= GetNumberOfPedTextureVariations		(playerPed, 10, Character['decals_1']) - 1,
		arms			= GetNumberOfPedDrawableVariations		(playerPed, 3) - 1,
		arms_2			= 10,
		pants_1			= GetNumberOfPedDrawableVariations		(playerPed, 4) - 1,
		pants_2			= GetNumberOfPedTextureVariations		(playerPed, 4, Character['pants_1']) - 1,
		shoes_1			= GetNumberOfPedDrawableVariations		(playerPed, 6) - 1,
		shoes_2			= GetNumberOfPedTextureVariations		(playerPed, 6, Character['shoes_1']) - 1,
		mask_1			= GetNumberOfPedDrawableVariations		(playerPed, 1) - 1,
		mask_2			= GetNumberOfPedTextureVariations		(playerPed, 1, Character['mask_1']) - 1,
		bproof_1		= GetNumberOfPedDrawableVariations		(playerPed, 9) - 1,
		bproof_2		= GetNumberOfPedTextureVariations		(playerPed, 9, Character['bproof_1']) - 1,
		chain_1			= GetNumberOfPedDrawableVariations		(playerPed, 7) - 1,
		chain_2			= GetNumberOfPedTextureVariations		(playerPed, 7, Character['chain_1']) - 1,
		bags_1			= GetNumberOfPedDrawableVariations		(playerPed, 5) - 1,
		bags_2			= GetNumberOfPedTextureVariations		(playerPed, 5, Character['bags_1']) - 1,
		helmet_1		= GetNumberOfPedPropDrawableVariations	(playerPed, 0) - 1,
		helmet_2		= GetNumberOfPedPropTextureVariations	(playerPed, 0, Character['helmet_1']) - 1,
		glasses_1		= GetNumberOfPedPropDrawableVariations	(playerPed, 1) - 1,
		glasses_2		= GetNumberOfPedPropTextureVariations	(playerPed, 1, Character['glasses_1'] - 1),
		watches_1		= GetNumberOfPedPropDrawableVariations	(playerPed, 6) - 1,
		watches_2		= GetNumberOfPedPropTextureVariations	(playerPed, 6, Character['watches_1']) - 1,
		bracelets_1		= GetNumberOfPedPropDrawableVariations	(playerPed, 7) - 1,
		bracelets_2		= GetNumberOfPedPropTextureVariations	(playerPed, 7, Character['bracelets_1'] - 1),
		nose_width 		= 20,
		nose_peak_hight = 20,
		nose_peak_lenght= 20,
		nose_bone_high= 20,
		nose_peak_lowering =20,
		nose_bone_twist = 20,
		eyebrown_high = 20,
		eyebrown_forward = 20,
		cheeks_bone_high = 20,
		cheeks_bone_width = 20,
		cheeks_width = 20,
		eyes_openning = 20,
		lips_thickness = 20,
		jaw_bone_width = 20,
		jaw_bone_back_lenght = 20,
		chimp_bone_lowering = 20,
		chimp_bone_lenght = 20,
		chimp_bone_width = 20,
		chimp_hole = 20,
		neck_thikness = 20,
	}

	return data
end

function ApplySkin(skin, clothes)
	local playerPed = PlayerPedId()

	for k,v in pairs(skin) do
		Character[k] = v
	end

	if clothes ~= nil then
		for k,v in pairs(clothes) do
			if
				k ~= 'sex'				and
				k ~= 'face'				and
				k ~= 'nose_width'		and
				k ~= 'nose_peak_hight'	and
				k ~= 'nose_peak_lenght'	and
				k ~= 'nose_bone_high'	and
				k ~= 'nose_peak_lowering' and
				k ~= 'nose_bone_twist' 	and
				k ~= 'eyebrown_high'	and
				k ~= 'eyebrown_forward' and
				k ~= 'cheeks_bone_high' and
				k ~= 'cheeks_bone_width'and
				k ~= 'cheeks_width'		and
				k ~= 'eyes_openning'	and
				k ~= 'lips_thickness'	and
				k ~= 'jaw_bone_width'	and
				k ~= 'jaw_bone_back_lenght'	and
				k ~= 'chimp_bone_lowering' and
				k ~= 'chimp_bone_lenght'	and
				k ~= 'chimp_bone_width'and
				k ~= 'chimp_hole' and
				k ~= 'neck_thikness' and
				k ~= 'skin'				and
				k ~= 'age_1'			and
				k ~= 'age_2'			and
				k ~= 'eye_color'		and
				k ~= 'beard_1'			and
				k ~= 'beard_2'			and
				k ~= 'beard_3'			and
				k ~= 'beard_4'			and
				k ~= 'hair_1'			and
				k ~= 'hair_2'			and
				k ~= 'hair_color_1'		and
				k ~= 'hair_color_2'		and
				k ~= 'eyebrows_1'		and
				k ~= 'eyebrows_2'		and
				k ~= 'eyebrows_3'		and
				k ~= 'eyebrows_4'		and
				k ~= 'makeup_1'			and
				k ~= 'makeup_2'			and
				k ~= 'makeup_3'			and
				k ~= 'makeup_4'			and
				k ~= 'lipstick_1'		and
				k ~= 'lipstick_2'		and
				k ~= 'lipstick_3'		and
				k ~= 'lipstick_4'		and
				k ~= 'blush_1'			and
				k ~= 'blush_2'			and
				k ~= 'blush_3'			and
				k ~= 'complexion_1'		and
				k ~= 'complexion_2'		and
				k ~= 'moles_1'			and
				k ~= 'moles_2'			and
				k ~= 'chest_1'			and
				k ~= 'chest_2'			and
				k ~= 'chest_3'
			then
				Character[k] = v
			end
		end
	end

	SetPedHeadBlendData			(playerPed, Character['face'], Character['face'], Character['face'], Character['skin'], Character['skin'], Character['skin'], 1.0, 1.0, 1.0, true)

	--SetPedFaceFeature(playerPed, 0, (Character['nose_width'] / 10) + 0.0) -- Nose Width
  --  SetPedFaceFeature(playerPed, 1, (Character['nose_peak_hight'] / 10) + 0.0) -- Nose Peak Height
  --  SetPedFaceFeature(playerPed, 2, (Character['nose_peak_lenght'] / 10) + 0.0) -- Nose Peak Length
  --  SetPedFaceFeature(playerPed, 3, (Character['nose_bone_high'] / 10) + 0.0) -- Nose Bone Height
  --  SetPedFaceFeature(playerPed, 4, (Character['nose_peak_lowering'] / 10) + 0.0) -- Nose Peak Lowering
  --  SetPedFaceFeature(playerPed, 5, (Character['nose_bone_twist'] / 10) + 0.0) -- Nose Bone Twist
  --  SetPedFaceFeature(playerPed, 6, (Character['eyebrown_high'] / 10) + 0.0) -- Eyebrow height
  --  SetPedFaceFeature(playerPed, 7, (Character['eyebrown_forward'] / 10) + 0.0) -- Eyebrow depth
  --  SetPedFaceFeature(playerPed, 8, (Character['cheeks_bone_high'] / 10) + 0.0) -- Cheekbones Height
  --  SetPedFaceFeature(playerPed, 9, (Character['cheeks_bone_width'] / 10) + 0.0) -- Cheekbones Width
  --  SetPedFaceFeature(playerPed, 10, (Character['cheeks_width'] / 10) + 0.0) -- Cheeks Width
  --  SetPedFaceFeature(playerPed, 11, (Character['eyes_openning'] / 10) + 0.0) -- Eyes squint
  --  SetPedFaceFeature(playerPed, 12, (Character['lips_thickness'] / 10) + 0.0) -- Lip Fullness
  --  SetPedFaceFeature(playerPed, 13, (Character['jaw_bone_width'] / 10) + 0.0) -- Jaw Bone Width
  --  SetPedFaceFeature(playerPed, 14, (Character['jaw_bone_back_lenght'] / 10) + 0.0) -- Jaw Bone Length
  --  SetPedFaceFeature(playerPed, 15, (Character['chimp_bone_lowering'] / 10) + 0.0) -- Chin Height
  --  SetPedFaceFeature(playerPed, 16, (Character['chimp_bone_lenght'] / 10) + 0.0) -- Chin Length
  --  SetPedFaceFeature(playerPed, 17, (Character['chimp_bone_width'] / 10) + 0.0) -- Chin Width
  --  SetPedFaceFeature(playerPed, 18, (Character['chimp_hole'] / 10) + 0.0) -- Chin Hole Size
  --  SetPedFaceFeature(playerPed, 19, (Character['neck_thikness'] / 10) + 0.0) -- Neck Thickness





	SetPedHairColor				(playerPed,			Character['hair_color_1'],		Character['hair_color_2'])					-- Hair Color
	SetPedHeadOverlay			(playerPed, 3,		Character['age_1'],				(Character['age_2'] / 10) + 0.0)			-- Age + opacity
	SetPedHeadOverlay			(playerPed, 1,		Character['beard_1'],			(Character['beard_2'] / 10) + 0.0)			-- Beard + opacity
	SetPedEyeColor				(playerPed,			Character['eye_color'], 0, 1)												-- Eyes color
	SetPedHeadOverlay			(playerPed, 2,		Character['eyebrows_1'],		(Character['eyebrows_2'] / 10) + 0.0)		-- Eyebrows + opacity
	SetPedHeadOverlay			(playerPed, 4,		Character['makeup_1'],			(Character['makeup_2'] / 10) + 0.0)			-- Makeup + opacity
	SetPedHeadOverlay			(playerPed, 8,		Character['lipstick_1'],		(Character['lipstick_2'] / 10) + 0.0)		-- Lipstick + opacity
	SetPedComponentVariation	(playerPed, 2,		Character['hair_1'],			Character['hair_2'], 2)						-- Hair
	SetPedHeadOverlayColor		(playerPed, 1, 1,	Character['beard_3'],			Character['beard_4'])						-- Beard Color
	SetPedHeadOverlayColor		(playerPed, 2, 1,	Character['eyebrows_3'],		Character['eyebrows_4'])					-- Eyebrows Color
	SetPedHeadOverlayColor		(playerPed, 4, 1,	Character['makeup_3'],			Character['makeup_4'])						-- Makeup Color
	SetPedHeadOverlayColor		(playerPed, 8, 1,	Character['lipstick_3'],		Character['lipstick_4'])					-- Lipstick Color
	SetPedHeadOverlay			(playerPed, 5,		Character['blush_1'],			(Character['blush_2'] / 10) + 0.0)			-- Blush + opacity
	SetPedHeadOverlayColor		(playerPed, 5, 2,	Character['blush_3'])														-- Blush Color
	SetPedHeadOverlay			(playerPed, 6,		Character['complexion_1'],		(Character['complexion_2'] / 10) + 0.0)		-- Complexion + opacity
	SetPedHeadOverlay			(playerPed, 9,		Character['moles_1'],			(Character['moles_2'] / 10) + 0.0)			-- Moles/Freckles + opacity
	SetPedHeadOverlay			(playerPed, 10,		Character['chest_1'],			(Character['chest_2'] / 10) + 0.0)			-- Chest Hair + opacity
	SetPedHeadOverlayColor		(playerPed, 10, 1,	Character['chest_3'])														-- Torso Color

	if Character['ears_1'] == -1 then
		ClearPedProp(playerPed, 2)
	else
		SetPedPropIndex			(playerPed, 2,		Character['ears_1'],			Character['ears_2'], 2)						-- Ears Accessories
	end

	SetPedComponentVariation	(playerPed, 8,		Character['tshirt_1'],			Character['tshirt_2'], 2)					-- Tshirt
	SetPedComponentVariation	(playerPed, 11,		Character['torso_1'],			Character['torso_2'], 2)					-- torso parts
	SetPedComponentVariation	(playerPed, 3,		Character['arms'],				Character['arms_2'], 2)						-- Amrs
	SetPedComponentVariation	(playerPed, 10,		Character['decals_1'],			Character['decals_2'], 2)					-- decals
	SetPedComponentVariation	(playerPed, 4,		Character['pants_1'],			Character['pants_2'], 2)					-- pants
	SetPedComponentVariation	(playerPed, 6,		Character['shoes_1'],			Character['shoes_2'], 2)					-- shoes
	SetPedComponentVariation	(playerPed, 1,		Character['mask_1'],			Character['mask_2'], 2)						-- mask
	SetPedComponentVariation	(playerPed, 9,		Character['bproof_1'],			Character['bproof_2'], 2)					-- bulletproof
	SetPedComponentVariation	(playerPed, 7,		Character['chain_1'],			Character['chain_2'], 2)					-- chain
	SetPedComponentVariation	(playerPed, 5,		Character['bags_1'],			Character['bags_2'], 2)						-- Bag

	if Character['helmet_1'] == -1 then
		ClearPedProp(playerPed, 0)
	else
		SetPedPropIndex			(playerPed, 0,		Character['helmet_1'],			Character['helmet_2'], 2)					-- Helmet
	end

	if Character['glasses_1'] == -1 then
		ClearPedProp(playerPed, 1)
	else
		SetPedPropIndex			(playerPed, 1,		Character['glasses_1'],			Character['glasses_2'], 2)					-- Glasses
	end

	if Character['watches_1'] == -1 then
		ClearPedProp(playerPed, 6)
	else
		SetPedPropIndex			(playerPed, 6,		Character['watches_1'],			Character['watches_2'], 2)					-- Watches
	end

	if Character['bracelets_1'] == -1 then
		ClearPedProp(playerPed,	7)
	else
		SetPedPropIndex			(playerPed, 7,		Character['bracelets_1'],		Character['bracelets_2'], 2)				-- Bracelets
	end




end

AddEventHandler('skinchanger:loadDefaultModel', function(loadMale, cb) -- FIVEMTURK
	LoadDefaultModel(loadMale, cb) -- FIVEMTURK -- FIVEMTURK
end)
 -- FIVEMTURK
AddEventHandler('skinchanger:getData', function(cb) -- FIVEMTURK
	local components = json.decode(json.encode(Components)) -- FIVEMTURK
 -- FIVEMTURK
	for k,v in pairs(Character) do -- FIVEMTURK
		for i=1, #components, 1 do -- FIVEMTURK
			if k == components[i].name then -- FIVEMTURK
				components[i].value = v -- FIVEMTURK
				--components[i].zoomOffset = Components[i].zoomOffset
				--components[i].camOffset = Components[i].camOffset
			end
		end
	end

	cb(components, GetMaxVals())
end)

AddEventHandler('skinchanger:change', function(key, val)
	Character[key] = val

	if key == 'sex' then
		TriggerEvent('skinchanger:loadSkin', Character)
	else
		ApplySkin(Character)
	end
end)

AddEventHandler('skinchanger:getSkin', function(cb)
	cb(Character)
end)

AddEventHandler('skinchanger:modelLoaded', function()
	ClearPedProp(PlayerPedId(), 0)

	if LoadSkin ~= nil then
		ApplySkin(LoadSkin)
		LoadSkin = nil
	end

	if LoadClothes ~= nil then
		ApplySkin(LoadClothes.playerSkin, LoadClothes.clothesSkin)
		LoadClothes = nil
	end
end)

RegisterNetEvent('skinchanger:loadSkin')
AddEventHandler('skinchanger:loadSkin', function(skin, cb)
	if skin['sex'] ~= LastSex then
		LoadSkin = skin

		if skin['sex'] == 0 then
			TriggerEvent('skinchanger:loadDefaultModel', true, cb)
		else
			TriggerEvent('skinchanger:loadDefaultModel', false, cb)
		end
	else
		ApplySkin(skin)

		if cb ~= nil then
			cb()
		end
	end

	LastSex = skin['sex']
end)

RegisterNetEvent('skinchanger:loadClothes')
AddEventHandler('skinchanger:loadClothes', function(playerSkin, clothesSkin)
	if playerSkin['sex'] ~= LastSex then
		LoadClothes = {
			playerSkin	= playerSkin,
			clothesSkin	= clothesSkin
		}

		if playerSkin['sex'] == 0 then
			TriggerEvent('skinchanger:loadDefaultModel', true)
		else
			TriggerEvent('skinchanger:loadDefaultModel', false)
		end
	else
		ApplySkin(playerSkin, clothesSkin)
	end

	LastSex = playerSkin['sex']
end)
