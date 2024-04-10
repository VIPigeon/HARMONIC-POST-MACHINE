CommandButton = table.copy(Button)

function CommandButton:new(command, role)
    local obj = {
        command = command,
        role = role,  -- "type" "nextCommand" "altCommand"
    }
    -- чистая магия!
    setmetatable(obj, self)
    self.__index = self; return obj
end

function CommandButton:onPress()
    local role = self.role
    local i = self.command
    if role == "type" then
        program[i].type = (program[i].type) % 5 + 1
    else
        program[i][role] = program[i][role] % program.capacity + 1
    end
end

function CommandButton:onAltPress()
    local role = self.role
    local i = self.command
    if role == "type" then
        program[i].type = (program[i].type + 3) % 5 + 1
    else
        program[i][role] = (program[i][role] + program.capacity - 2) % program.capacity + 1
    end
end
