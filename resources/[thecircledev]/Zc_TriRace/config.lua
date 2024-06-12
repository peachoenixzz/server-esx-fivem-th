Config2 = {}
Config2.Command = 'startgame'
Config2.StopCommand = 'stopgame'
Config2.Effect = false --- เปิดปิด  Effect
Config2.Sound = true -- เปิด ปิดเสียง ตอนเริ่ม
Config2.Song = 'Dm_sounds' -- ชื่อ เพลง ฟาย MP3
Config2.Soundlevel = 0.08 -- ระดับเสียง
Config2.loserItem = {
    [1] = {Itemname = 'test1', Itemcount = 1},
    [2] = {Itemname = 'test1', Itemcount = 1}
}
Config2['Bonus'] =
    { -------------------คนที่ 1 ได้เท่านั้น
        {itemname = "test1", count = 1, percent = 100},
        {itemname = "test1", count = 1, percent = 100},
        {itemname = "test1", count = 1, percent = 100},
        {itemname = "test1", count = 1, percent = 100}
    }

-----------------------------   สำหรับใช้คู่้กับสคริป ปีกบิน  Zc_FlyingWing --------------------
Config2.Wingname = 'Punchzc89'



-----------------------  update ---------

Config2.PassiveOnGame = true ------------- ตัวใส
Config2.TimeBeforeEnd = 100 ------------- เวลารอหลังที่ 1 เข้าเส้นชัย
Config2.reviveOnEndGame = function()
    if IsPedDeadOrDying(PlayerPedId(), true) then
         TriggerEvent('esx_ambulancejob:revive', false)
    end
end

function SVLOG(source,item,count)
    --print(source,item,count)
    --- เชื่อม log
end