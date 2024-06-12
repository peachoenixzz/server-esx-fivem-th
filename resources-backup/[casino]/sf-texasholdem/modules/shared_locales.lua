Locales = {}

function _L(name, ...)
    if(not Locales[Language][name]) then
        return "INVALID_LOCALE"
    end
    return string.format(Locales[Language][name], ...)
end

function _LOCALE(name, ...)
    if(not Locales[Language][name]) then
        return "INVALID_LOCALE"
    end
    return string.format(Locales[Language][name], ...)
end