-- ██████╗  █████╗ ██████╗ ██████╗ ██╗████████╗    ██████╗ ███████╗██╗   ██╗
-- ██╔══██╗██╔══██╗██╔══██╗██╔══██╗██║╚══██╔══╝    ██╔══██╗██╔════╝██║   ██║
-- ██████╔╝███████║██████╔╝██████╔╝██║   ██║       ██║  ██║█████╗  ██║   ██║
-- ██╔══██╗██╔══██║██╔══██╗██╔══██╗██║   ██║       ██║  ██║██╔══╝  ╚██╗ ██╔╝
-- ██║  ██║██║  ██║██████╔╝██████╔╝██║   ██║       ██████╔╝███████╗ ╚████╔╝ 
-- ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚═════╝ ╚═╝   ╚═╝       ╚═════╝ ╚══════╝  ╚═══╝  
-- https://discord.gg/GfvECJ4Z8q

function p(level, text)
    if Config.Debug then
        color = '^0'
        msgType = '^0[INFO] :'
        if level == 1 then
            color = '^2'
            msgType = '^2[DEBUG]: '
        end
        if level == 2 then
            color = '^3'
            msgType = '^3[WARN]: '
        end
        if level == 3 then
            color = '^1'
            msgType = '^1[ERROR]: '
        end
        print(msgType .. '^3(rabbit_emotes_ui) ' .. color .. text)
    end
end