
Button = {}


function Button:new()
    local obj = {}
    -- чистая магия!
    setmetatable(obj, self)
    self.__index = self; return obj
end


function Button:onPress()
end

function Button:onAltPress()
end

