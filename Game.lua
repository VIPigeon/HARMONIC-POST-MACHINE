game = {}

local function createMetronome()
    return Metronome4_4:new(GAME_BPM)
end


function game.draw()
end


function game.update()
    Time.update()
    game.draw()
end


return game
