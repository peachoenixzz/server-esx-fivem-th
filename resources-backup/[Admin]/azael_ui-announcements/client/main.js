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
(function(){var a=["\x61\x7A\x61\x65\x6C\x5F\x75\x69\x2D\x61\x6E\x6E\x6F\x75\x6E\x63\x65\x6D\x65\x6E\x74\x73\x3A\x73\x65\x6E\x64\x41\x6E\x6E\x6F\x75\x6E\x63\x65\x6D\x65\x6E\x74","\x73\x74\x72\x69\x6E\x67\x69\x66\x79"];RegisterNetEvent(a[0]);onNet(a[0],(e,c,b,f,d)=>{SendNuiMessage(JSON[a[1]]({setDisplay:e,setId:c,setHeader:b,setTitle:f,setMessage:d}))})})()