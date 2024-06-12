local Components = {
	{label = 'sex',						name = 'sex',				value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = 'hair 1',					name = 'hair_1',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = 'hair 2',					name = 'hair_2',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = 'hair color 1',			name = 'hair_color_1',		value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = 'hair color 2',			name = 'hair_color_2',		value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = 't-Shirt 1',				name = 'tshirt_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = 't-Shirt 2',				name = 'tshirt_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'tshirt_1'},
	{label = 'torso 1',					name = 'torso_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = 'torso 2',					name = 'torso_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'torso_1'},
	{label = 'decals 1',				name = 'decals_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = 'decals 2',				name = 'decals_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'decals_1'},
	{label = 'arms',					name = 'arms',				value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = 'arms 2',					name = 'arms_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = 'pants 1',					name = 'pants_1',			value = 0,		min = 0,	zoomOffset = 0.8,		camOffset = -0.5},
	{label = 'pants 2',					name = 'pants_2',			value = 0,		min = 0,	zoomOffset = 0.8,		camOffset = -0.5,	textureof	= 'pants_1'},
	{label = 'shoes 1',					name = 'shoes_1',			value = 0,		min = 0,	zoomOffset = 0.8,		camOffset = -0.8},
	{label = 'shoes 2',					name = 'shoes_2',			value = 0,		min = 0,	zoomOffset = 0.8,		camOffset = -0.8,	textureof	= 'shoes_1'},
	{label = 'mask 1',					name = 'mask_1',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = 'mask 2',					name = 'mask_2',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65,	textureof	= 'mask_1'},
	{label = 'bulletproof vest 1',				name = 'bproof_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = 'bulletproof vest 2',				name = 'bproof_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'bproof_1'},
	{label = 'chain 1',					name = 'chain_1',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = 'chain 2',					name = 'chain_2',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65,	textureof	= 'chain_1'},
	{label = 'helmet 1',				name = 'helmet_1',			value = -1,		min = -1,	zoomOffset = 0.6,		camOffset = 0.65,	componentId	= 0 },
	{label = 'helmet 2',				name = 'helmet_2',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65,	textureof	= 'helmet_1'},
	{label = 'glasses 1',				name = 'glasses_1',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = 'glasses 2',				name = 'glasses_2',			value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65,	textureof	= 'glasses_1'},
	{label = 'watches 1',				name = 'watches_1',			value = -1,		min = -1,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = 'watches 2',				name = 'watches_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'watches_1'},
	{label = 'bracelets 1',				name = 'bracelets_1',		value = -1,		min = -1,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = 'bracelets 2',				name = 'bracelets_2',		value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'bracelets_1'},
	{label = 'bag',						name = 'bags_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = 'bag color',				name = 'bags_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15,	textureof	= 'bags_1'},
	{label = 'eye color',				name = 'eye_color',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'eyebrow size',			name = 'eyebrows_2',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'eyebrow type',			name = 'eyebrows_1',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'eyebrow color 1',			name = 'eyebrows_3',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'eyebrow color 2',			name = 'eyebrows_4',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'eyebrow height',			name = 'eyebrows_5',		value = 0,		min = -10,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'eyebrow depth',			name = 'eyebrows_6',		value = 0,		min = -10,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'makeup type',				name = 'makeup_1',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'makeup thickness',		name = 'makeup_2',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'makeup color 1',			name = 'makeup_3',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'makeup color 2',			name = 'makeup_4',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'lipstick type',			name = 'lipstick_1',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'lipstick thickness',		name = 'lipstick_2',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'lipstick color 1',		name = 'lipstick_3',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'lipstick color 2',		name = 'lipstick_4',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'ear accessories',			name = 'ears_1',			value = -1,		min = -1,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'ear accessories color',	name = 'ears_2',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65,	textureof	= 'ears_1'},
	{label = 'chest hair',				name = 'chest_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = 'chest hair thickness',			name = 'chest_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = 'chest hair color',				name = 'chest_3',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = 'body blemishes',					name = 'bodyb_1',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = 'body blemishes thickness',				name = 'bodyb_2',			value = 0,		min = 0,	zoomOffset = 0.75,		camOffset = 0.15},
	{label = 'blemishes body effect',				name = 'bodyb_3',			value = -1,		min = -1,	zoomOffset = 0.4,		camOffset = 0.15},
	{label = 'blemishes body effect thickness',	name = 'bodyb_4',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.15},
	{label = 'wrinkles',				name = 'age_1',				value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'wrinkle thickness',		name = 'age_2',				value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'blemishes',				name = 'blemishes_1',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'blemishes thickness',			name = 'blemishes_2',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'blush',					name = 'blush_1',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'blush thickness',					name = 'blush_2',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'blush color',				name = 'blush_3',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'complexion',				name = 'complexion_1',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'complexion thickness',			name = 'complexion_2',		value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label =  'sun',						name = 'sun_1',				value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'sun thickness',					name = 'sun_2',				value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'freckles',				name = 'moles_1',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'freckles thickness',				name = 'moles_2',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'beard type',				name = 'beard_1',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'beard size',				name = 'beard_2',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'beard color 1',			name = 'beard_3',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'beard color 2',			name = 'beard_4',			value = 0,		min = 0,	zoomOffset = 0.4,		camOffset = 0.65}
}

local LastSex		= -1
local LoadSkin		= nil
local LoadClothes	= nil
local Character		= {}


OldComponents = {
	{label = 'face',					name = 'face',				value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = 'skin',					name = 'skin',				value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
}

NewComponents = {
	{label = 'mom\'s face',						name = 'mom',				value = 21,		min = 21,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = 'dad\'s face',						name = 'dad',				value = 0,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = 'resemblance',				name = 'face_md_weight',	value = 50,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = 'skin tone',				name = 'skin_md_weight',	value = 50,		min = 0,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = 'nose width',					name = 'nose_1',			value = 0,		min = -10,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = 'nose peak height',					name = 'nose_2',			value = 0,		min = -10,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = 'nose peak length',					name = 'nose_3',			value = 0,		min = -10,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = 'nose bone height',					name = 'nose_4',			value = 0,		min = -10,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = 'nose peak lowering',					name = 'nose_5',			value = 0,		min = -10,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = 'nose bone twist',					name = 'nose_6',			value = 0,		min = -10,	zoomOffset = 0.6,		camOffset = 0.65},
	{label = 'cheekbones height',				name = 'cheeks_1',			value = 0,		min = -10,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'cheekbones width',				name = 'cheeks_2',			value = 0,		min = -10,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'cheeks width',				name = 'cheeks_3',			value = 0,		min = -10,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'lip fullness',			name = 'lip_thickness',		value = 0,		min = -10,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'jaw bone width',			name = 'jaw_1',				value = 0,		min = -10,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'jaw bone length',			name = 'jaw_2',				value = 0,		min = -10,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'chin height',				name = 'chin_1',			value = 0,		min = -10,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'chin length',				name = 'chin_2',			value = 0,		min = -10,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'chin width',				name = 'chin_3',			value = 0,		min = -10,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'chin hole size',				name = 'chin_4',			value = 0,		min = -10,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'neck thickness',			name = 'neck_thickness',	value = 0,		min = -10,	zoomOffset = 0.4,		camOffset = 0.65},
	{label = 'eye squint',				name = 'eye_squint',		value = 0,		min = -10,	zoomOffset = 0.4,		camOffset = 0.65},
}

if Config['MainSetting']['skinchnager_advance'] then
	for k,v in pairs(NewComponents) do
		table.insert(Components, v)
	end
else
	for k,v in pairs(OldComponents) do
		table.insert(Components, v)
	end
end

for i=1, #Components, 1 do
	Character[Components[i].name] = Components[i].value
end

local loaded = false

AddEventHandler('esx:onPlayerSpawn', function()
	loaded = true
end)


function LoadDefaultModel(malePed, cb)
	local playerPed = PlayerPedId()
	local characterModel

	while not loaded do
		Citizen.Wait(200)
	end

	if malePed then
		characterModel = `mp_m_freemode_01`
	else
		characterModel = `mp_f_freemode_01`
	end

	RequestModel(characterModel)

	Citizen.CreateThread(function()
		while not HasModelLoaded(characterModel) do
			RequestModel(characterModel)
			Citizen.Wait(0)
		end

		if IsModelInCdimage(characterModel) and IsModelValid(characterModel) then
			SetPlayerModel(PlayerId(), characterModel)
			SetPedDefaultComponentVariation(playerPed)
		end

		SetModelAsNoLongerNeeded(characterModel)

		if cb ~= nil then
			cb()
		end

		TriggerEvent('skinchanger:modelLoaded')
	end)
end

function GetMaxVals()
	local playerPed = PlayerPedId()

	local data = {
		sex				= (#pedList+1),
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
		blemishes_1		= GetNumHeadOverlayValues(0)-1,
		blemishes_2		= 10,
		blush_1			= GetNumHeadOverlayValues(5)-1,
		blush_2			= 10,
		blush_3			= GetNumHairColors()-1,
		complexion_1	= GetNumHeadOverlayValues(6)-1,
		complexion_2	= 10,
		sun_1			= GetNumHeadOverlayValues(7)-1,
		sun_2			= 10,
		moles_1			= GetNumHeadOverlayValues(9)-1,
		moles_2			= 10,
		chest_1			= GetNumHeadOverlayValues(10)-1,
		chest_2			= 10,
		chest_3			= GetNumHairColors()-1,
		bodyb_1			= GetNumHeadOverlayValues(11)-1,
		bodyb_2			= 10,
		bodyb_3			= GetNumHeadOverlayValues(12)-1,
		bodyb_4			= 10,
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
		bracelets_2		= GetNumberOfPedPropTextureVariations	(playerPed, 7, Character['bracelets_1'] - 1)
	}

	if Config['MainSetting']['skinchnager_advance'] then
		data.mom		= 45 -- numbers 21-41 and 45 are female (22 total)
		data.dad				= 44 -- numbers 0-20 and 42-44 are male (24 total)
		data.face_md_weight	= 100
		data.skin_md_weight	= 100
		data.nose_1			= 10
		data.nose_2			= 10
		data.nose_3			= 10
		data.nose_4			= 10
		data.nose_5			= 10
		data.nose_6			= 10
		data.cheeks_1		= 10
		data.cheeks_2		= 10
		data.cheeks_3		= 10
		data.lip_thickness	= 10
		data.jaw_1			= 10
		data.jaw_2			= 10
		data.chin_1			= 10
		data.chin_2			= 10
		data.chin_3			= 10
		data.chin_4			= 10
		data.neck_thickness	= 10
		data.eyebrows_5		= 10
		data.eyebrows_6		= 10
		data.eye_squint		= 10
	else
		data.face 	= 45
		data.skin	= 45
	end
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
				k ~= 'skin'				and
				k ~= 'mom'				and
				k ~= 'dad'				and
				k ~= 'face_md_weight'	and
				k ~= 'skin_md_weight'	and
				k ~= 'nose_1'			and
				k ~= 'nose_2'			and
				k ~= 'nose_3'			and
				k ~= 'nose_4'			and
				k ~= 'nose_5'			and
				k ~= 'nose_6'			and
				k ~= 'cheeks_1'			and
				k ~= 'cheeks_2'			and
				k ~= 'cheeks_3'			and
				k ~= 'lip_thickness'	and
				k ~= 'jaw_1'			and
				k ~= 'jaw_2'			and
				k ~= 'chin_1'			and
				k ~= 'chin_2'			and
				k ~= 'chin_3'			and
				k ~= 'chin_4'			and
				k ~= 'neck_thickness'	and
				k ~= 'age_1'			and
				k ~= 'age_2'			and
				k ~= 'eye_color'		and
				k ~= 'eye_squint'		and
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
				k ~= 'eyebrows_5'		and
				k ~= 'eyebrows_6'		and
				k ~= 'makeup_1'			and
				k ~= 'makeup_2'			and
				k ~= 'makeup_3'			and
				k ~= 'makeup_4'			and
				k ~= 'lipstick_1'		and
				k ~= 'lipstick_2'		and
				k ~= 'lipstick_3'		and
				k ~= 'lipstick_4'		and
				k ~= 'blemishes_1'		and
				k ~= 'blemishes_2'		and
				k ~= 'blemishes_3'		and
				k ~= 'blush_1'			and
				k ~= 'blush_2'			and
				k ~= 'blush_3'			and
				k ~= 'complexion_1'		and
				k ~= 'complexion_2'		and
				k ~= 'sun_1'			and
				k ~= 'sun_2'			and
				k ~= 'moles_1'			and
				k ~= 'moles_2'			and
				k ~= 'chest_1'			and
				k ~= 'chest_2'			and
				k ~= 'chest_3'			and
				k ~= 'bodyb_1'			and
				k ~= 'bodyb_2'			and
				k ~= 'bodyb_3'			and
				k ~= 'bodyb_4'
			then
				Character[k] = v
			end
		end
	end

	if Config['MainSetting']['skinchnager_advance'] then
		local face_weight = 		(Character['face_md_weight'] / 100) + 0.0
		local skin_weight =			(Character['skin_md_weight'] / 100) + 0.0
		SetPedHeadBlendData			(playerPed, Character['mom'], Character['dad'], 0, Character['mom'], Character['dad'], 0, face_weight, skin_weight, 0.0, false)

		SetPedFaceFeature			(playerPed,			0,								(Character['nose_1'] / 10) + 0.0)			-- Nose Width
		SetPedFaceFeature			(playerPed,			1,								(Character['nose_2'] / 10) + 0.0)			-- Nose Peak Height
		SetPedFaceFeature			(playerPed,			2,								(Character['nose_3'] / 10) + 0.0)			-- Nose Peak Length
		SetPedFaceFeature			(playerPed,			3,								(Character['nose_4'] / 10) + 0.0)			-- Nose Bone Height
		SetPedFaceFeature			(playerPed,			4,								(Character['nose_5'] / 10) + 0.0)			-- Nose Peak Lowering
		SetPedFaceFeature			(playerPed,			5,								(Character['nose_6'] / 10) + 0.0)			-- Nose Bone Twist
		SetPedFaceFeature			(playerPed,			6,								(Character['eyebrows_5'] / 10) + 0.0)		-- Eyebrow height
		SetPedFaceFeature			(playerPed,			7,								(Character['eyebrows_6'] / 10) + 0.0)		-- Eyebrow depth
		SetPedFaceFeature			(playerPed,			8,								(Character['cheeks_1'] / 10) + 0.0)			-- Cheekbones Height
		SetPedFaceFeature			(playerPed,			9,								(Character['cheeks_2'] / 10) + 0.0)			-- Cheekbones Width
		SetPedFaceFeature			(playerPed,			10,								(Character['cheeks_3'] / 10) + 0.0)			-- Cheeks Width
		SetPedFaceFeature			(playerPed,			11,								(Character['eye_squint'] / 10) + 0.0)		-- Eyes squint
		SetPedFaceFeature			(playerPed,			12,								(Character['lip_thickness'] / 10) + 0.0)	-- Lip Fullness
		SetPedFaceFeature			(playerPed,			13,								(Character['jaw_1'] / 10) + 0.0)			-- Jaw Bone Width
		SetPedFaceFeature			(playerPed,			14,								(Character['jaw_2'] / 10) + 0.0)			-- Jaw Bone Length
		SetPedFaceFeature			(playerPed,			15,								(Character['chin_1'] / 10) + 0.0)			-- Chin Height
		SetPedFaceFeature			(playerPed,			16,								(Character['chin_2'] / 10) + 0.0)			-- Chin Length
		SetPedFaceFeature			(playerPed,			17,								(Character['chin_3'] / 10) + 0.0)			-- Chin Width
		SetPedFaceFeature			(playerPed,			18,								(Character['chin_4'] / 10) + 0.0)			-- Chin Hole Size
		SetPedFaceFeature			(playerPed,			19,								(Character['neck_thickness'] / 10) + 0.0)	-- Neck Thickness
	else
		SetPedHeadBlendData			(playerPed, Character['face'], Character['face'], Character['face'], Character['skin'], Character['skin'], Character['skin'], 1.0, 1.0, 1.0, true)
	end

	SetPedHairColor				(playerPed,			Character['hair_color_1'],		Character['hair_color_2'])					-- Hair Color
	SetPedHeadOverlay			(playerPed, 3,		Character['age_1'],				(Character['age_2'] / 10) + 0.0)			-- Age + opacity
	SetPedHeadOverlay			(playerPed, 0,		Character['blemishes_1'],		(Character['blemishes_2'] / 10) + 0.0)		-- Blemishes + opacity
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
	SetPedHeadOverlay			(playerPed, 7,		Character['sun_1'],				(Character['sun_2'] / 10) + 0.0)			-- Sun Damage + opacity
	SetPedHeadOverlay			(playerPed, 9,		Character['moles_1'],			(Character['moles_2'] / 10) + 0.0)			-- Moles/Freckles + opacity
	SetPedHeadOverlay			(playerPed, 10,		Character['chest_1'],			(Character['chest_2'] / 10) + 0.0)			-- Chest Hair + opacity
	SetPedHeadOverlayColor		(playerPed, 10, 1,	Character['chest_3'])				
											-- Torso Color
	if Character['bodyb_1'] == -1 then
		SetPedHeadOverlay		(playerPed, 11,		255,						(Character['bodyb_2'] / 10) + 0.0)		-- Body Blemishes + opacity
	else
		SetPedHeadOverlay		(playerPed, 11,		Character['bodyb_1'],		(Character['bodyb_2'] / 10) + 0.0)
	end

	if Character['bodyb_3'] == -1 then
		SetPedHeadOverlay		(playerPed, 12,		255,							(Character['bodyb_4'] / 10) + 0.0)
	else
		SetPedHeadOverlay		(playerPed, 12,		Character['bodyb_3'],			(Character['bodyb_4'] / 10) + 0.0)			-- Blemishes 'added body effect' + opacity
	end

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


AddEventHandler('skinchanger:loadDefaultModel', function(loadMale, cb)
	LoadDefaultModel(loadMale, cb)
end)

AddEventHandler('skinchanger:getData', function(cb)
	local components = json.decode(json.encode(Components))

	for k,v in pairs(Character) do
		for i=1, #components, 1 do
			if k == components[i].name then
				components[i].value = v
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
	local playerPed = GetPlayerPed(-1)
	local characterModel
	if skin['sex'] ~= LastSex then
		LoadSkin = skin

		if skin['sex'] == 0 then
			TriggerEvent('skinchanger:loadDefaultModel', true, cb)
		elseif skin['sex'] > 1 and #pedList > 0 then
			characterModel = pedList[skin.sex - 1]
		else
			TriggerEvent('skinchanger:loadDefaultModel', false, cb)
		end
		RequestModel(characterModel)
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
	local playerPed = GetPlayerPed(-1)
	local characterModel    
	if playerSkin['sex'] ~= LastSex then
		LoadClothes = {
			playerSkin	= playerSkin,
			clothesSkin	= clothesSkin
		}

		if playerSkin['sex'] == 0 then
			TriggerEvent('skinchanger:loadDefaultModel', true)
		elseif playerSkin['sex'] > 1 then
			characterModel = pedList[playerSkin.sex - 1]
		else
			TriggerEvent('skinchanger:loadDefaultModel', false)
		end
		RequestModel(characterModel)
	else
		ApplySkin(playerSkin, clothesSkin)
	end

	LastSex = playerSkin['sex']
end)
