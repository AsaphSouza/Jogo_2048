tabuleiroFrontend = {}
local imagem
local larguraTela = display.actualContentWidth - 3
local lateral = larguraTela/4

function tabuleiroFrontend:desenharTela (tabuleiro)
	posicaoStartHeigth = 0
	for i = 1, 4 do 
		posicaoStartWidth = 0
        for z = 1, 4 do
        	
            img = display.newImageRect(tabuleiro[i][z].img,lateral,lateral)
            img.anchorX = 0
            img.anchorY = 0
            img:translate(posicaoStartWidth,posicaoStartHeigth)
			posicaoStartWidth = posicaoStartWidth + lateral + 1
		end
		posicaoStartHeigth = posicaoStartHeigth + lateral + 1
	end 
end

function tabuleiroFrontend:getButtonLeft ()
    return display.newRect((display.contentWidth/2)-30, 420,30,30)
end
function tabuleiroFrontend:getButtonRight ()
    return display.newRect((display.contentWidth/2)+30, 420,30,30)
end
function tabuleiroFrontend:getButtonTop ()
    return display.newRect((display.contentWidth/2), 390,30,30)
end
function tabuleiroFrontend:getButtonDown ()
    return display.newRect((display.contentWidth/2), 450,30,30)
end

return tabuleiroFrontend