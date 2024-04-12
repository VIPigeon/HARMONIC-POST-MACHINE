program = {}
program.capacity = 32
program.pos = {x = 5, y = 3, i = 1}

program.dx_in = 2
program.dx_out = 3
program.dx = program.dx_in + program.dx_out
program.dy = 3
--[[
dx_in
 v 
x x   x x
          < dy
x x   x x
    ^
    dx_out
--]]

PROGRAMMING = 4
program.commands_in_screen = PROGRAMMING

program.typetiles = {192, 193, 194, 195, 196}
program.btnK = 64
program.magicBtnN = program.btnK  -- legacy


for i = 1, program.capacity do
    program[i] = Command:new(i)
end

function program.display()
    local x = program.pos.x
    local y = program.pos.y

    -- mset(x, y - 2, )

    local lshift = {128, 128+16, 128+32, 128+48, 197, 197}
    for y0 = y, y + program.dy do
        mset(x - program.dx_out, y0, lshift[y0 - y + 1])
        game.buttons[x - program.dx_out][y0] = ShiftButton:new(-1)
    end

    for i = program.pos.i, program.pos.i + program.commands_in_screen - 1 do
        -- trace(i.." "..x.." "..y)
        program[i]:display(x, y)
        x = x + program.dx
    end
    local rshift = {129, 129+16, 129+32, 129+48, 197, 197}
    for y0 = y, y + program.dy do
        mset(x, y0, rshift[y0 - y + 1])
        game.buttons[x][y0] = ShiftButton:new(1)
    end
end

function program.hide()
    local x = program.pos.x
    local y = program.pos.y
    for y0 = y, y + program.dy do
        mset(x - program.dx_out, y0, 0)
        game.buttons[x - program.dx_out][y0] = false
    end
    for i = program.pos.i, program.pos.i + program.commands_in_screen - 1 do
        program[i]:hide()
        x = x + program.dx
    end
    local y = program.pos.y
    for y0 = y, y + program.dy do
        mset(x, y0, 0)
        game.buttons[x][y0] = false
    end
end

function program.update()
    program.hide()
    if game.playing then
        program.commands_in_screen = 1
    else
        program.commands_in_screen = PROGRAMMING
    end
    program.display()
end
