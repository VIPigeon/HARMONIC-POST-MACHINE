Tape = {}
Tape.cell0 = 7
Tape.cell1 = 10
Tape.tile = 112

local Node = {}
function Node:new(word)
    local obj = {
        word = word,
        next = false,
        prev = false,
    }
    -- чистая магия!
    setmetatable(obj, self)
    self.__index = self; return obj
end

Tape.start_player_pos = 20

function Tape:new(x, y, start_word)
    local obj = {
        x = x, y = y,
        node = Node:new(start_word),
        start_word = start_word,
        player = Tape.start_player_pos,
        direction = 1,
    }
    -- чистая магия!
    setmetatable(obj, self)
    self.__index = self; return obj
end


function Tape:init()
    self.node = Node:new(self.start_word)
    mset(self.x + 24 - self.player, self.y - 1, 0)
    self.player = Tape.start_player_pos
end


function Tape:display()
    local n = self.node.word
    -- trace(n)
    local cnt = self.player
    for i = self.x + 23, self.x, -1 do
        mset(i, self.y, Tape.tile + n % 2)
        n = n >> 1
        cnt = cnt - 1
        if cnt == 0 then
            mset(i, self.y - 1, 114 + self.direction)
        end
    end
end


function Tape:_execute(command)
    -- trace(program.pos.i)
    local type = command.type
    if type == 4 then
        self.node.word = self.node.word ~ math.pow(2, self.player - 1)
    elseif type == 2 then
        self.direction = 0
        mset(self.x + 24 - self.player, self.y - 1, 0)
        self.player = self.player + 1
        if self.player == 25 then
            self.player = 1
            if self.node.next then
                self.node = self.node.next
            else
                local nn = Node:new(0)
                nn.prev = self.node
                self.node.next = nn
                self.node = nn
            end
        end
    elseif type == 3 then
        self.direction = 1
        mset(self.x + 24 - self.player, self.y - 1, 0)
        self.player = self.player - 1
        if self.player == 0 then
            self.player = 24
            if self.node.prev then
                self.node = self.node.prev
            else
                local nn = Node:new(0)
                nn.next = self.node
                self.node.prev = nn
                self.node = nn
            end
        end
    end
end


function Tape:isMarked()
    -- What's hapenning? I don't care
    return self.node.word & math.pow(2, self.player - 1) > 0
end

function Tape:update()
    if not game.metronome.onBeat then
        return
    end
    local i = program.pos.i
    self:_execute(program[i])
    if program[i].type == 1 then
        game.buttons[game.playbutton.x][game.playbutton.y]:onPress()
        return
    end
    if program[i].type == 5 and not self:isMarked() then
        -- trace(i.." "..program[i].altCommand.." "..program[i].nextCommand)
        program.pos.i = program[i].altCommand
    else
        program.pos.i = program[i].nextCommand
    end
    self:sfx()
end

function Tape:sfx()
    if self:isMarked() then
        harmonic(self.player, "draw")
    else
        harmonic(self.player, "blow")
    end
end
