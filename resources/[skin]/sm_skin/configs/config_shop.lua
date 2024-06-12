--[[ 
    script: Skin System & Clothe Shop
    author: SM Developer
    discord: https://discord.gg/ZbJP9wptwB
    ทางเราขอบคุณเป็นอย่างยิ่งที่ท่านได้สนับสนุนสินค้าของเรา
]]

Config = Config or {}

Config['Shop-Setting'] = {  -- การตั้งค่าทั่วไปเกี่ยวกับโหมดร้านค้า
    ['ClotheShop'] = {
        Blips = {
            sprite = 1,
            scale = 1.0,
            color = 1,
            text = 'Clothe Shop'
        },
    },
    ['BarberShop'] = {
        Blips = {
            sprite = 1,
            scale = 1.0,
            color = 2,
            text = 'Barber Shop'
        },
    },
    ['MaskShop'] = {
        Blips = {
            sprite = 1,
            scale = 1.0,
            color = 3,
            text = 'Mask Shop'
        },
    },
    ['Locker'] = {
        Blips = {
            sprite = 1,
            scale = 1.0,
            color = 4,
            text = 'Locker'
        },
    }
}


Config['ShopPosition'] = {  
    ['ClotheShop'] = {
        --Shop1 = {   -- ชื่อ index ห้ามซื้อกัน
        --    type = 'normal',  -- ห้ามเปลี่ยน
        --    zone = vector3(124.2137, -219.8547, 54.55783), --  ตำแหน่งของ Blips และ Marker
        --    rad = 10.0, -- ระยะที่สามารถกด E ได้
        --    blip = {
        --        enable = false, --  (เปิด/ปิด) Blips
        --    },
        --    marker = {
        --        type = 1,
        --        size = {10.0, 10.0, 1.0},
        --        color = {255, 0, 0, 100}
        --    }
        --},
        Shop8 = {
            type = 'normal',
            zone = vector3(72.254, -1399.102, 28.376),
            rad = 10.0,
            blip = {
                enable = false,
            },
            marker = {
                type = 1,
                size = {10.0, 10.0, 1.0},
                color = {255, 0, 0, 100}
            }
        },

        Shop9 = {
            type = 'normal',
            zone = vector3(-703.776, -152.258, 36.415),
            rad = 10.0,
            blip = {
                enable = false,
            },
            marker = {
                type = 1,
                size = {10.0, 10.0, 1.0},
                color = {255, 0, 0, 100}
            }
        },

        Shop10 = {
            type = 'normal',
            zone = vector3(-167.863, -298.969, 38.733),
            rad = 10.0,
            blip = {
                enable = false,
            },
            marker = {
                type = 1,
                size = {10.0, 10.0, 1.0},
                color = {255, 0, 0, 100}
            }
        },

        Shop11 = {
            type = 'normal',
            zone = vector3(428.694, -800.106, 28.491),
            rad = 10.0,
            blip = {
                enable = false,
            },
            marker = {
                type = 1,
                size = {10.0, 10.0, 1.0},
                color = {255, 0, 0, 100}
            }
        },

        Shop12 = {
            type = 'normal',
            zone = vector3(-829.413, -1073.710, 10.328),
            rad = 10.0,
            blip = {
                enable = false,
            },
            marker = {
                type = 1,
                size = {10.0, 10.0, 1.0},
                color = {255, 0, 0, 100}
            }
        },

        Shop13 = {
            type = 'normal',
            zone = vector3(-1447.797, -242.461, 48.820),
            rad = 10.0,
            blip = {
                enable = false,
            },
            marker = {
                type = 1,
                size = {10.0, 10.0, 1.0},
                color = {255, 0, 0, 100}
            }
        },

        Shop14 = {
            type = 'normal',
            zone = vector3(123.646, -219.440, 53.557),
            rad = 10.0,
            blip = {
                enable = false,
            },
            marker = {
                type = 1,
                size = {10.0, 10.0, 1.0},
                color = {255, 0, 0, 100}
            }
        },

        Shop15 = {
            type = 'normal',
            zone = vector3(-1193.429, -772.262, 16.324),
            rad = 10.0,
            blip = {
                enable = false,
            },
            marker = {
                type = 1,
                size = {10.0, 10.0, 1.0},
                color = {255, 0, 0, 100}
            }
        },

        -- Continue this pattern for as many shops as needed

     },
     
    ['BarberShop'] = {
        Shop1 = {
            type = 'normal',
            zone = vector3(-814.308, -183.823, 36.568),
            rad = 10.0,
            blip = {
                enable = false,
            },
            marker = {
                type = 1,
                size = {10.0, 10.0, 1.0},
                color = {255, 0, 0, 100}
            }
        },

        Shop2 = {
            type = 'normal',
            zone = vector3(136.826, -1708.373, 28.291),
            rad = 5.0,
            blip = {
                enable = false,
            },
            marker = {
                type = 1,
                size = {10.0, 10.0, 1.0},
                color = {255, 0, 0, 100}
            }
        },

        Shop3 = {
            type = 'normal',
            zone = vector3(-1282.604, -1116.757, 5.990),
            rad = 5.0,
            blip = {
                enable = false,
            },
            marker = {
                type = 1,
                size = {10.0, 10.0, 1.0},
                color = {255, 0, 0, 100}
            }
        },

        Shop4 = {
            type = 'normal',
            zone = vector3(1931.513, 3729.671, 31.844),
            rad = 5.0,
            blip = {
                enable = false,
            },
            marker = {
                type = 1,
                size = {10.0, 10.0, 1.0},
                color = {255, 0, 0, 100}
            }
        },

        Shop5 = {
            type = 'normal',
            zone = vector3(1212.840, -472.921, 65.208),
            rad = 5.0,
            blip = {
                enable = false,
            },
            marker = {
                type = 1,
                size = {10.0, 10.0, 1.0},
                color = {255, 0, 0, 100}
            }
        },

        Shop6 = {
            type = 'normal',
            zone = vector3(-32.885, -152.319, 56.076),
            rad = 5.0,
            blip = {
                enable = false,
            },
            marker = {
                type = 1,
                size = {10.0, 10.0, 1.0},
                color = {255, 0, 0, 100}
            }
        },

        Shop7 = {
            type = 'normal',
            zone = vector3(-278.077, 6228.463, 30.695),
            rad = 5.0,
            blip = {
                enable = false,
            },
            marker = {
                type = 1,
                size = {10.0, 10.0, 1.0},
                color = {255, 0, 0, 100}
            }
        }
        -- Continue this pattern for as many shops as needed
    },
     
    ['MaskShop'] = {
        Shop1 = {
            type = 'normal',
            zone = vector3(-1337.4, -1278.151, 4.870889),
            rad = 5.0,
            marker = {
                type = 1,
                size = {5.0, 5.0, 1.0},
                color = {255, 0, 0, 100}
            },
            blip = {
                enable = false,
            },
        } 
    },

    ['Locker'] = {
        --Shop1 = {
        --    type = 'normal',
        --    zone = vector3(-267.6085, -958.377, 31.22411),
        --    rad = 10.0,
        --    blip = {
        --        enable = true,
        --    },
        --    marker = {
        --        type = 1,
        --        size = {10.0, 10.0, 1.0},
        --        color = {255, 0, 0, 100}
        --    }
        --}
    },
     

}
