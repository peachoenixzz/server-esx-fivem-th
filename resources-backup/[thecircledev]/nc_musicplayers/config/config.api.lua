-- ████╗   ██╗   ██████╗   ██████╗  ██████╗ ██╗  ██╗ ██████╗ ██╗     █████╗  ██████╗  ██████╗ ██████╗    ██╗ --
-- ██╔██╗  ██║ ██╔═════╝   ██╔══██╗ ██╔═══╝ ██║  ██║ ██╔═══╝ ██║    ██╔══██╗ ██╔══██╗ ██╔═══╝ ██╔══██╗   ██║ --
-- ██║╚██╗ ██║ ██║         ██║  ██║ █████╗  ██║  ██║ █████╗  ██║    ██║  ██║ ██████╔╝ █████╗  ██████╔╝   ██║ --
-- ██║ ╚██╗██║ ██║         ██║  ██║ ██╔══╝  ╚██╗██╔╝ ██╔══╝  ██║    ██║  ██║ ██╔═══╝  ██╔══╝  ██╔══██╗   ╚═╝ --
-- ██║  ╚████║ ╚═██████╗   ██████╔╝ ██████╗  ╚███╔╝  ██████╗ ██████╗╚█████╔╝ ██║      ██████╗ ██║  ██║   ██╗ --
-- ╚═╝   ╚═══╝   ╚═════╝   ╚═════╝  ╚═════╝   ╚══╝   ╚═════╝ ╚═════╝ ╚════╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝ --

Config.RefreshAttempt = 3				-- จำนวนครั้งสูงสุดที่จะดึงข้อมูลเพลงนั้นๆ
Config.RefreshInterval = 300			-- ระยะเวลา Delay ระหว่างการดึงข้อมูลแต่ละครั้ง

Config.YouTubeAPI = {
	-- 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
	-- 'YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY',
    'AIzaSyDSkhg6EIEwPO0b9gX7BcbJsYfFtiTq_u0',
    'AIzaSyBQin1sdHt7xdpLdIwbD99PnyZYSJT9fqQ',
    'AIzaSyBR5aIekTgDtKvDK863uqVVaPiUaf-x8pw',
    'AIzaSyBT8H-6aDTGy7ybJ3YUv0yr_K_UPn4piPE',
    'AIzaSyDwyAZeHo-4sGsOX_UrKkwsQZsrWfDoAhE',
    'AIzaSyBqKdlmuS1e1cNNUQS9lpvHrM-USJNQxZQ',
    'AIzaSyBOPL9FqgfUHEmNH5zRV25eMpZlUCoJogM',
    'AIzaSyApUo8Ldd4TuqrefPc9Jx6hKBPDVVRDRd0',
}

-- การหา API key
-- 1. ไปที่ https://console.cloud.google.com/cloud-resource-manager
-- 2. กด + CREATE PROJECT
-- 3. ตั้งชื่อ Project (เป็นอะไรก็ได้)
-- 4. กด CREATE
-- 5. ไปที่ https://console.cloud.google.com/apis/credentials
-- 6. เลือก Project ที่สร้างไว้
-- 7. กด + CREATE CREDENTIALS
-- 8. เลือก API key
-- 9. นำ API key ในช่อง Your API key มาใส่
-- * แนะนำให้ใส่ API key มากกว่า 1 key

-- การเปิดใช้งาน YouTube Data API v3
-- 1. ไปที่ https://console.cloud.google.com/apis/library/youtube.googleapis.com
-- 2. กดปุ่ม ENABLE