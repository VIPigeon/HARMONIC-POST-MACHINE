
ShiftButton = table.copy(Button)

function ShiftButton:new(shift)
    local obj = {
        shift = shift,
    }
    -- чистая магия!
    setmetatable(obj, self)
    self.__index = self; return obj
end


function ShiftButton:onPress()
    program.pos.i = program.pos.i + self.shift
    if program.pos.i > program.capacity - program.commands_in_screen + 1 or program.pos.i < 1 then
        program.pos.i = program.pos.i - self.shift
    end
    -- trace(program.pos.i)
    program.update()
end
