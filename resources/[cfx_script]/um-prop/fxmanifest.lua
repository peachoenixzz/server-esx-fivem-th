fx_version 'adamant'
game 'gta5'
author 'uyuyorum'
description 'um-prop'
version '2.0.0'

data_file 'DLC_ITYP_REQUEST' 'stream/box_machine.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/box_machine2.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/bm_uc.ytyp'

escrow_ignore {
    'stream/*.ydr',
    'stream/*.ytyp',
}

lua54 'yes'
dependency '/assetpacks'