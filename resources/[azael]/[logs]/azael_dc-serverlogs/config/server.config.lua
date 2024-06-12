--===== FiveM Script: ========================================
--= DC - Server Logs (Webhook)
--===== Developed By: ========================================
--= Azael Dev <contact@azael.dev>
--===== Website: =============================================
--= https://www.azael.dev/
--===== License: =============================================
--= You are not allowed to sell this script or edit
--============================================================

CONFIG.General = {                                          -- ทั่วไป
    Option = {                                              -- ตัวเลือกที่ต้องการใช้งาน
        Type = 'CUSTOM'                                    -- ประเภทตัวเลือกที่ต้องการใช้งาน DISCORD หรือ CUSTOM ("DISCORD" เท่ากับ ส่งคำขอไปยัง Discord API โดยใช้ Webhook URL | "CUSTOM" เท่ากับ ส่งคำขอไปยัง Server API ที่กำหนดเอง)
    },

    Crashes = {                                             -- บันทึกข้อมูลไปยังโฟลเดอร์ azael_data/azael_dc-serverlogs/crashes หากพบข้อผิดพลาดต่างๆ (ป้องกันข้อมูลสูญหาย)
        Enable = true                                       -- เปิดใช้งาน บันทึกข้อมูลไปยังโฟลเดอร์ crashes หากพบข้อผิดพลาดต่างๆ (true เท่ากับ เปิดใช้งาน | false เท่ากับ ปิดใช้งาน)
    },

    Hardware = {                                            -- แสดง Hardware Tokens ที่เหตุการณ์ Login ในรูปแบบ JSON Array
        Enable = true                                       -- เปิดใช้งานแสดง Hardware Tokens ของผู้เล่น (true เท่ากับ เปิดใช้งาน | false เท่ากับ ปิดใช้งาน)
    },

    Screenshot = {                                          -- บันทึกภาพหน้าจอตามเหตุการณ์ที่กำหนด
        Enable = false,                                      -- เปิดใช้งาน บันทึกภาพหน้าจอ ของผู้เล่นตามเหตุการณ์ที่กำหนด (หากเปิดใช้งาน จำเป็นที่จะต้องติดตั้งและใช้งานทรัพยากร screenshot-basic)

        Webhooks = {                                        -- เหตุการณ์ที่กำหนดให้บันทึกภาพหน้าจอ และ อัพโหลดไปยัง Discord (เหตุการณ์ Login และ Logout ไม่สามารถใช้งานได้)
            ['Dead'] = 'https://mongkol.dev/api/img/create'                        -- ฝากภาพ-สาเหตุการตาย
        }
    },

    Chat = {                                                -- ตรวจสอบข้อความที่ผู้เล่นดำเนินการ (chatMessage)
        Enable = true,                                     -- เปิดใช้งาน ตรวจสอบข้อความที่ผู้เล่นดำเนินการ (true เท่ากับ เปิดใช้งาน | false เท่ากับ ปิดใช้งาน)

        Remove = {                                          -- ลบข้อความ หากพบคําที่ไม่อนุญาต
            Enable = true                                   -- เปิดใช้งาน ลบข้อความ หากพบคําที่ไม่อนุญาต (true เท่ากับ เปิดใช้งาน | false เท่ากับ ปิดใช้งาน)
        },

        Kick = {                                            -- เตะผู้เล่นออกจากเซิร์ฟเวอร์ หากพบคําที่ไม่อนุญาต
            Enable = true,                                  -- เปิดใช้งาน เตะผู้เล่นออกจากเซิร์ฟเวอร์ หากพบคําที่ไม่อนุญาต (true เท่ากับ เปิดใช้งาน | false เท่ากับ ปิดใช้งาน)
            Reason = 'ตรวจพบคำที่ไม่ได้รับอนุญาต (%s)'           -- เหตุผลในการเตะผู้เล่นออกจากเซิร์ฟเวอร์
        },

        Word = {                                            -- คำที่ไม่ได้รับอนุญาตให้ใช้งาน
            'discord.gg',
            'discord.com/invite',
            'discordapp.com/invite',
            'lynxcollective.ltd',
            'eulencheats.com'
        }
    },

    Color = {                                               -- รหัสสี (รูปแบบ Hexadecimal)
        [1] = '#FF4444',                                    -- แดงอ่อน
        [2] = '#99CC00',                                    -- เขียวเข้ม
        [3] = '#FFBB33',                                    -- ส้มอ่อน
        [4] = '#0099CC',                                    -- ฟ้าเข้ม
        [5] = '#33B5E5',                                    -- ฟ้าอ่อน
        [6] = '#AA66CC',                                    -- ม่วงกลาง
        [7] = '#99AAB5',                                    -- น้ำเงินอมเทา
        [8] = '#CC0000',                                    -- แดงเข้ม
        [9] = '#CC0068',                                    -- ชมพูเข้ม
        [10] = '#FFFFFF'                                    -- ขาว
    }
}

CONFIG.Custom = {                                           -- Custom API (ส่งคำขอไปยัง Server API ที่กำหนดเองแบบเรียลไทม์)
    API = {                                                 -- API สำหรับ รับข้อมูลจากฟอร์มคำขอ (HTTP Requests)
        BaseURL = 'https://mongkol.dev/api/fivemlog',       -- Base URL สำหรับ API ที่ใช้งาน (ส่งคำขอโดยใช้ POST และ API จะต้องตอบกลับสถานะ 200, 201 หรือ 204 หากดำเนินการสำเร็จ)
        Authorization = {                                   -- Authorization จะถูกกำหนดภายในส่วนหัวของคำขอ HTTP (ตัวอย่าง Authorization: Log security_token)
            Method = 'Basic',                                 -- Method ที่ใช้งาน (กำหนดเอง)
            Token = 'dGhlY2lyY2xlZGV2OlRoZWNpcmNsZTExMiFAIw==',                       -- Token ความปลอดภัย (กำหนดเอง)
        }
    }
}

CONFIG.Discord = {                                          -- Discord API (ส่งคำขอตามขีดจำกัดอัตราการใช้งาน Discord API สำหรับ Webhooks)
    Rate = {                                                -- อัตราจำกัดการใช้งาน (ขีดจำกัดอัตราการใช้งานในปัจจุบันอยู่ที่ 30 คำขอ ต่อ 1 นาที ต่อ 1 ช่อง)
        Limit = 30                                          -- กำหนดการส่งคำขอภายใน 1 นาที ต่อ 1 ช่อง (ค่าเริ่มต้น 30)
    },

    Avatar = {                                              -- รูปภาพอวทาร์ สำหรับ Webhooks
        URL = 'https://i.imgur.com/GxQpZzJ.png'             -- ที่อยู่รูปภาพอวทาร์
    },

    Important = {                                           -- ข้อมูลสำคัญ (ระบบจะดำเนินการ Ping ไปยังบทบาทที่กำหนด หากรหัสส่งข้อมูลมีการกำหนดค่า "options = { important = true }")
        Content = '__**⚠️ IMPORTANT ― || @everyone || Please Read!! ⚠️**__'   -- เนื้อหาข้อความ (ค่าเริ่มต้นจะ Ping ไปยัง "@everyone" คุณสามารถ Ping ไปเฉพาะบทบาทได้โดยการแก้ไข "@everyone" เป็น "<@&RoleID>")
    },
    
    Command = {                                             -- คำสั่ง (สามารถใช้คำสั่งผ่าน Server Console หรือ Live Console ของระบบ txAdmin เท่านั้น)
        Save = 'logsave',                                   -- บันทึกข้อมูลทั้งหมดในรูปแบบไฟล์ JSON (ในกรณียังมีคิวส่งคำขออยู่ และผู้ดูแลต้องการรีสตาร์ทเซิร์ฟเวอร์ ระบบจะบันทึกข้อมูลทั้งหมดไปยังโฟลเดอร์ azael_data/azael_dc-serverlogs/logs)
        Queue = 'logqueue'                                  -- ตรวจสอบคิวที่ยังรอดำเนินการส่งคำขอไปยัง Discord API สำหรับ Webhooks
    },

    txAdmin = {                                             -- รองรับการใช้งาน txAdmin ในกรณียังมีคิวส่งคำขออยู่ ระบบจะบันทึกข้อมูลทั้งหมดไปยังโฟลเดอร์ azael_data/azael_dc-serverlogs/logs (ป้องกันข้อมูลสูญหาย)
        Enable = true,                                      -- เปิดใช้งาน บันทึกข้อมูลทั้งหมดในรูปแบบไฟล์ JSON สำหรับเหตุการณ์ กำลังปิดเซิร์ฟเวอร์ (true เท่ากับ เปิดใช้งาน | false เท่ากับ ปิดใช้งาน)

        Shutting = {                                        -- กำลังปิดเซิร์ฟเวอร์โดย ผู้ดูแลระบบ หรือ ตามกำหนดการรีสตาร์ท (รองรับ txAdmin เวอร์ชัน 4.15 ขึ้นไป)
            Event = 'txAdmin:events:serverShuttingDown'     -- ชื่อเหตุการณ์ (ค่าเริ่มต้นอยู่ที่ 5000 มิลลิวินาที ก่อนที่ txAdmin จะฆ่ากระบวนการของเซิร์ฟเวอร์)
        }
    }
}

CONFIG.Discord.Webhooks = {                                 -- กำหนด Webhooks สำหรับ เหตุการณ์ ทั้งหมด (ไม่ต้องกำหนดค่าในส่วนนี้ หากไม่ได้ใช้งาน "DISCORD" ในการตั้งค่า "CONFIG.General.Option.Type")
    ['Login'] = 'webhook_url',                              -- เข้าสู่เซิร์ฟเวอร์
    ['Logout'] = 'webhook_url',                             -- ออกจากเซิร์ฟเวอร์
    ['Chat'] = 'webhook_url',                               -- ข้อความแชท
    ['Dead'] = 'webhook_url'                                -- สาเหตุการตาย
}
