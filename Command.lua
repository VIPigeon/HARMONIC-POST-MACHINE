
Command = {}


function Command:new(i)
    local obj = {
        i = i,
        type = 1,
        nextCommand = i % program.capacity + 1,
        altCommand = i % program.capacity + 1,
        x = false,
        y = false,
    }
    -- чистая магия!
    setmetatable(obj, self)
    self.__index = self; return obj
end


function Command:display(x, y)
    self.x = x
    self.y = y
    local dx = program.dx_in
    local dy = program.dy
    mset(x, y, self.i)
    mset(x + dx, y, program.typetiles[self.type])
    game.buttons[x + dx][y] = CommandButton:new(self.i, "type")
    if self.type > 1 then
        mset(x + dx, y + dy, self.nextCommand + program.btnK)
        game.buttons[x + dx][y + dy] = CommandButton:new(self.i, "nextCommand")
    end
    if self.type == 5 then
        mset(x, y + dy, self.altCommand + program.btnK)
        game.buttons[x][y + dy] = CommandButton:new(self.i, "altCommand")
    end
end


function Command:draw_lines()
    local x = self.x
    local y = self.y
    local dx = program.dx_in * 8
    local dy = program.dy * 8 - 1
    if not x or not y or self.type == 1 then
        return
    end
    x = x*8 + 4
    y = y*8
    line(x + dx, y + 8, x + dx, y + dy, 2)
    if self.type == 5 then
        line(x + dx, y + 8, x + 1, y + dy, Tape.cell0)
        line(x + dx, y + 8, x + dx, y + dy, Tape.cell1)
    end
end


function Command:hide()
    local dx = program.dx_in
    local dy = program.dy
    local x = self.x
    local y = self.y
    if not x or not y then
        return
    end
    mset(x, y, 0)
    mset(x + dx, y, 0)
    game.buttons[x + dx][y] = false
    mset(x + dx, y + dy, 0)
    game.buttons[x + dx][y + dy] = false
    mset(x, y + dy, 0)
    game.buttons[x][y + dy] = false
    self.x = false
    self.y = false
end
