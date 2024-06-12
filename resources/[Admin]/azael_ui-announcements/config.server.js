//===== FiveM Script =========================================
//= UI - Server Announcements
//===== Developed By: ========================================
//= Azael Dev
//===== Website: =============================================
//= https://www.azael.dev
//===== License: =============================================
//= Copyright (C) Azael Dev - All Rights Reserved
//= You are not allowed to sell this script or edit
//============================================================

const command = "ad"; // คำสั่งที่ใช้ในการประกาศสำหรับผู้ดูแลระบบ ใช้คำสั่งได้ผ่าน Chat, F8 หรือ Server Console ใช้ ACE Permissions ในการตรวจสอบสิทธิ์การใช้งานคำสั่ง
const display = 10; // เวลาในการเเสดงข้อความที่ประกาศ (วินาที)
const announceAdmin = "ทีมงาน"; // หัวข้อประกาศข้อความจากผู้ดูแลระบบ
const announceAutomate = "ประกาศ"; // หัวข้อประกาศข้อความอัตโนมัติ
const enableAutomate = true; // เปิดใช้งาน ประกาศข้อความโดยอัตโนมัติหรือไม่? (true เท่ากับเปิดใช้งาน | false เท่ากับ ปิดใช้งาน)
const automateDelay = 5; // ดีเลย์ในการประกาศข้อความโดยอัตโนมัติ (นาที)
const automateLists = [
  // ข้อความที่ต้องการประกาศโดยอัตโนมัติ
  "ยินดีต้อนรับสู่ Mongkol Town ขอให้ผู้เล่นทุกท่านสนุกกับการสวมบทบาท",
  "กำหนดรีสตาร์ทเซิฟเวอร์ทุกวัน เวลา 12.00, 18.00 และ 00.00น.",
  "กรุณาเปลี่ยนชื่อ Steam ให้ตรงกับชื่อในบัตรประชาชน [IC]",
  "รบกวนผู้เล่นที่เป็นแก๊งและหน่วยงานอย่าลืมใส่ Tag แก๊งหน้าชื่อ เช่น [PD] Mongkol Rama",
  "หากพบผู้กระทำผิด สามารถติดต่อทีมงานในห้องแจ้งปัญหาได้ทันที",
  "ผู้เล่นจะต้องมี Overlay หรือภาพหลักฐานทุกครั้งในการแจ้งปัญหากับทางทีมงาน",
  "หากตรวจพบผู้เล่นที่จงใจใช้บัคหรือใช้ช่องโหว่ของระบบ ทางทีมงานจะไม่ทำการตักเตือนใด ๆ",
  "ผู้เล่นสามารถเปิด Cash Shop (F10) เพื่อเลือกซื้อของต่าง ๆ",
  "หลังจากซื้อของที่ Cash Shop กรุณารอ 1-3 นาที",
  "การเติมแต้ม Gold สามารถเติมตลอดเวลา ทีมงานจะเริ่มแอดให้ตั้งแต่เวลา 17.00 - 02.00น. เท่านั้น",
  "Tips : /autopilot เพื่อไปยังจุดหมายที่ Marker ไว้บนแผนที่ได้",
  "Tips : สามารถพิมพ์ /selectmap เพื่อเปลี่ยนแผนที่ได้",
  "Tips : การโอนสิทธิยานพาหนะ ผู้เล่นจะต้องมีบัตรโอนรถตั้งสองคน",
  "Tips : อุปกรณ์การทำงานทั้งหมดมีโอกาสแตก และทุกครั้งที่แตกมีโอกาสเลือดลดลงเล็กน้อย",
  "Tips : ผู้เล่นสามารถกด F12 ถ่ายภาพขณะยังมีชีวิต เพื่อใช้เป็นหลักฐานดำเนินคดีได้",
];