-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local tabuleiro = require("tabuleiro")
local tabuleirofront = require ("tabuleiroFrontend")

tab = tabuleiro:criar_tabuleiro(4,4)

tab[1][1].valor = 1024
tab[1][3].valor = 1024
tab[1][4].valor = 64
tab[3][2].valor = 4
tab[4][4].valor = 8
tab[3][4].valor = 128

botao1 = tabuleirofront:getButtonLeft()
botao2 = tabuleirofront:getButtonRight()
botao3 = tabuleirofront:getButtonTop()
botao4 = tabuleirofront:getButtonDown()

tabuleiro:print_points()
tabuleiro:mudarCorQuadrado()
tabuleirofront:desenharTela(tab)

botao1:addEventListener("tap",move_left)
botao2:addEventListener("tap",move_right)
botao3:addEventListener("tap",move_up)
botao4:addEventListener("tap",move_down) 