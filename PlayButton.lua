
PlayButton = table.copy(Button)

-- function PlayButton:new()
--     local obj = {}
--     -- чистая магия!
--     setmetatable(obj, self)
--     self.__index = self; return obj
-- end
PlayButton.runTile = 130
PlayButton.stopTile = 131
function PlayButton:onPress()
    game.playing = not game.playing
    program.pos.i = 1
    mset(game.playbutton.x, game.playbutton.y, game.playing and PlayButton.stopTile or PlayButton.runTile)
end
