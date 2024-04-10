game = {}

game.player = {
    x = program.pos.x + program.dx_in,
    y = program.pos.y,
}

game.playing = false
game.playbutton = {x = 2, y = 1}

function game.player.draw()
    local x1 = game.player.x
    local y1 = game.player.y
    local x2 = game.player.x
    local y2 = game.player.y
    pix(x1*8, y1*8, 15)
    pix(x1*8+7, y1*8, 15)
    pix(x1*8, y1*8+7, 15)
    pix(x1*8+7, y1*8+7, 15)
    while y1 >= 1 and game.buttons[x1][y1] do
        y1 = y1 - 1
    end
    y1 = y1 + 1
    while x1 >= 1 and game.buttons[x1][y1] do
        x1 = x1 - 1
    end
    x1 = x1 + 1
    while y2 <= 17 and game.buttons[x2][y2] do
        y2 = y2 + 1
    end
    y2 = y2 - 1
    while x2 <= 30 and game.buttons[x2][y2] do
        x2 = x2 + 1
    end
    x2 = x2 - 1
    x2 = x2 - x1
    y2 = y2 - y1
    rectb(x1*8 - 1, y1*8 - 1, x2*8 + 10, y2*8 + 10, 2)
end

function game.init()
    game.buttons = {}
    for x = 1,30 do
        game.buttons[x] = {}
        for y = 1,17 do
            game.buttons[x][y] = false
        end
    end
    program.display()
    mset(game.playbutton.x, game.playbutton.y, PlayButton.runTile)
    game.buttons[game.playbutton.x][game.playbutton.y] = PlayButton:new()

    game.tape = Tape:new(2, 15, math.pow(2, 25))
end
game.init()


local function createMetronome()
    return Metronome4_4:new(GAME_BPM)
end


function game.draw()
    cls(C0)
    map(0, 0)
    for i = program.pos.i, program.pos.i + program.commands_in_screen - 1 do
        program[i]:draw_lines()
    end
    local px = game.player.x
    local py = game.player.y
    game.player.draw()
end


function game.control()
    local x = game.player.x
    local y = game.player.y

    if btnp(0) then
        y = y - 1
        while not game.buttons[x][y] do
            y = y - 1
            if y < 1 then
                return
            end
        end
    elseif btnp(1) then
        y = y + 1
        while not game.buttons[x][y] do
            y = y + 1
            if y > 17 then
                return
            end
        end
    elseif btnp(2) then
        x = x - 1
        while not game.buttons[x][y] do
            x = x - 1
            if x < 1 then
                return
            end
        end
    elseif btnp(3) then
        x = x + 1
        while not game.buttons[x][y] do
            x = x + 1
            if x > 30 then
                return
            end
        end
    elseif btnp(5) then
        game.current_button():onPress()
    elseif btnp(7) then
        game.current_button():onAltPress()
    else
        return
    end
    game.player.x = x
    game.player.y = y
    program.update()
end


function game.current_button()
    return game.buttons[game.player.x][game.player.y]
end


function game.update()
    if game.playing then
        game.tape:update()
        program.update()
    end
    game.tape:display()
    game.control()
    Time.update()
    game.draw()
end


function print_matrix(m)
    for i = 1, 30 do
        local s = ""
        for j = 1, 17 do
            if m[i][j] then
                s = s.."*"
            else
                s = s.." "
            end
        end
        trace(s)
    end
end


return game
