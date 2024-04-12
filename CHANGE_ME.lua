
notes = {
    blow = {
        'C-4','E-4','G-4','C-5','E-5','G-5',
        'C-6','E-6','G-6','C-7','E-7','G-7',
    },
    draw = {
        'D-4','G-4','B-4','D-5','F-5','A-5',
        'B-5','D-6','F-6','A-6','B-6','D-7',
    },
}
sfxArgs = {
    type = {blow = 1, draw = 1},
}

for i = 12, 1, -1 do
    table.insert(notes.blow, notes.blow[i])
    table.insert(notes.draw, notes.draw[i])
end

function harmonic(i, type)
    sfx(sfxArgs.type[type], notes[type][i])
end
