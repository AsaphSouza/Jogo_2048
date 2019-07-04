--esp = require ("posix")
tabuleirofrontEnd = require("tabuleiroFrontend")

--[[O NÚMERO 2 DEVE SURGIR NA TELA MAIS VEZES QUE O NÚMERO 4
ENTÃO PARA CADA 7 JOGADAS SURGIRÁ O NÚMERO 4 E NAS DEMAIS O NÚMERO 2, PARA ISSO
USAREI UM CONTROLE COMO ATRIBUTO DO TABULEIRO]]
tabuleiro = {}
jogo = {pontuacao = 0, controle = 0}

function tabuleiro:criar_tabuleiro(linhas,colunas)
    
    --tabuleiro = {}
    for linha = 1, linhas do
        tabuleiro[linha] = {}
        for coluna = 1, colunas do 
            tabuleiro[linha][coluna] = {img = nil, valor = 0}
            --tabuleiro[linha][coluna] = quadrado
        end 
    end
    return tabuleiro
end
function tabuleiro:inserir(linha,coluna,valor,tabuleiro)
    tabuleiro[linha][coluna].valor = valor
end

function tabuleiro:get_points()
    return jogo.pontuacao
end

function tabuleiro:add_points(x)
  return jogo.pontuacao + x
end

function tabuleiro:print_points()
    display.newText(jogo.pontuacao,display.contentWidth-50,display.contentHeight-10)
end

function tabuleiro:set_controle(x)
  jogo.controle = x
end

function tabuleiro:get_controle()
  return jogo.controle
end

function tabuleiro:gerar_numero_tabuleiro()
  local numero = 0
  self:set_controle((self:get_controle() + 1))
  if (self:get_controle() < 8) then
    numero = 2
  else 
    numero = 4
    self:set_controle(0)
  end

  math.randomseed(os.time())
  local linha = math.random(1,#tabuleiro)
 -- esp.sleep(1)
  local coluna = math.random(1,#tabuleiro[1])
  if tabuleiro[linha][coluna].valor == 0 then 
    tabuleiro[linha][coluna].valor = numero
  else 
    self:gerar_numero_tabuleiro()
  end
  return tabuleiro
end

function move_right(event)
    local casa_somada = {{0,0}}
    local points = 0
    for i = 1, #tabuleiro do 
        alteracao = true
        while alteracao == true do
            alteracao = false
            cont = #tabuleiro[1] - 1
            while cont >= 1 do
                if tabuleiro[i][cont].valor ~= 0 then
                    if tabuleiro[i][cont + 1].valor == 0 then
                        tabuleiro[i][cont + 1].valor = tabuleiro[i][cont].valor
                        tabuleiro[i][cont].valor = 0
                        alteracao = true
                    elseif tabuleiro[i][cont  + 1].valor == tabuleiro[i][cont].valor then
                        if {i,(cont + 1)} ~= casa_somada[1] then 
                            tabuleiro[i][cont  + 1].valor = tabuleiro[i][cont + 1].valor + tabuleiro[i][cont].valor
                            casa_somada[1] = {i,cont + 1}
                            points = points + tabuleiro[i][cont + 1].valor
                            tabuleiro[i][cont].valor = 0
                            alteracao = true
                        else
                            alteracao = false
                        end
                    end
                    cont = cont - 1
                else 
                    cont = cont - 1
                end
            end
        end
    end
    tabuleiro:add_points(points)
    tabuleiro:print_points()
    tabuleiro:check_status(points)
    tabuleiro:mudarCorQuadrado()
    tabuleirofrontEnd:desenharTela(tabuleiro) 
end
function move_left(event)
    local casa_somada = {{0,0}}
    local points = 0
    for i = 1, #tabuleiro do 
        alteracao = true
        while alteracao == true do
            alteracao = false
            cont = 2
            while cont <= #tabuleiro[1] do
                if tabuleiro[i][cont].valor ~= 0 then
                    if tabuleiro[i][cont -1].valor == 0 then
                        tabuleiro[i][cont-1].valor = tabuleiro[i][cont].valor
                        tabuleiro[i][cont].valor = 0
                        alteracao = true
                    elseif tabuleiro[i][cont -1].valor == tabuleiro[i][cont].valor then
                        if {i,(cont - 1)} ~= casa_somada[1] then 
                            tabuleiro[i][cont -1].valor = tabuleiro[i][cont -1].valor + tabuleiro[i][cont].valor
                            casa_somada[1] = {i,cont - 1}
                            points = points + tabuleiro[i][cont -1].valor
                            tabuleiro[i][cont].valor = 0
                            alteracao = true
                        else
                            alteracao = false
                        end
                    end
                    cont = cont + 1
                else 
                    cont = cont + 1
                end
            end
        end
    end
    tabuleiro:add_points(points)
    tabuleiro:print_points()
    tabuleiro:check_status(points)
    tabuleiro:mudarCorQuadrado()
    tabuleirofrontEnd:desenharTela(tabuleiro)
end
function move_down(event)
    local casa_somada = {{0,0}}
    local points = 0
    for i = 1, #tabuleiro[1] do 
        alteracao = true
        while alteracao == true do
            alteracao = false
            cont = #tabuleiro - 1
            while cont >= 1 do
                if tabuleiro[cont][i].valor ~= 0 then
                    if tabuleiro[cont+1][i].valor == 0 then
                        tabuleiro[cont+1][i].valor = tabuleiro[cont][i].valor
                        tabuleiro[cont][i].valor = 0
                        alteracao = true
                    elseif tabuleiro[cont][i].valor == tabuleiro[cont+1][i].valor  then
                        if {cont,i} ~= casa_somada[1] then 
                            tabuleiro[cont+1][i].valor = tabuleiro[cont+1][i].valor + tabuleiro[cont][i].valor
                            casa_somada[1] = {cont,i}
                            points = points + tabuleiro[cont+1][i].valor
                            tabuleiro[cont][i].valor = 0
                            alteracao = true
                        else
                            alteracao = false
                        end
                    end
                    cont = cont - 1
                else 
                    cont = cont - 1
                end
            end
        end
    end
    tabuleiro:add_points(points)
    tabuleiro:print_points()
    tabuleiro:check_status(points)
    tabuleiro:mudarCorQuadrado()
    tabuleirofrontEnd:desenharTela(tabuleiro)
end
function move_up(event)
    local casa_somada = {{0,0}}
    local points = 0
    for i = 1, #tabuleiro[1] do 
        alteracao = true
        while alteracao == true do
            alteracao = false
            cont = 2
            while cont <= #tabuleiro do
                if tabuleiro[cont][i].valor ~= 0 then
                    if tabuleiro[cont-1][i].valor == 0 then
                        tabuleiro[cont-1][i].valor = tabuleiro[cont][i].valor
                        tabuleiro[cont][i].valor = 0
                        alteracao = true
                    elseif tabuleiro[cont][i].valor == tabuleiro[cont-1][i].valor then
                        if {cont,i} ~= casa_somada[1] then 
                            tabuleiro[cont-1][i].valor = tabuleiro[cont-1][i].valor + tabuleiro[cont][i].valor
                            points = points + tabuleiro[cont-1][i].valor
                            casa_somada[1] = {cont,i}
                            tabuleiro[cont][i].valor = 0
                            alteracao = true
                        else
                            alteracao = false
                        end
                    end
                    cont = cont + 1
                else 
                    cont = cont + 1
                end
            end
        end
    end
    tabuleiro:add_points(points)
    tabuleiro:print_points()
    tabuleiro:check_status(points)
    tabuleiro:mudarCorQuadrado()
    tabuleirofrontEnd:desenharTela(tabuleiro)
end
function tabuleiro:check_possible_points_left()
    for i = 1, #tabuleiro do 
        alteracao = true
        while alteracao == true do
            alteracao = false
            cont = 2
            while cont <= #tabuleiro[1] do
                if tabuleiro[i][cont].valor ~= 0 then
                    if tabuleiro[i][cont -1].valor == tabuleiro[i][cont].valor then
                        alteracao = true
                        return true
                    end
                    cont = cont + 1
                else 
                    cont = cont + 1
                end
            end
        end
    end
    return false
end
function tabuleiro:check_possible_points_right()
    for i = 1, #tabuleiro do 
        alteracao = true
        while alteracao == true do
            alteracao = false
            cont = #tabuleiro[1] - 1
            while cont >= 1 do
                if tabuleiro[i][cont].valor ~= 0 then
                    if tabuleiro[i][cont  + 1].valor == tabuleiro[i][cont].valor then
                        alteracao = true
                        return true
                    end
                    cont = cont - 1
                else 
                    cont = cont - 1
                end
            end
        end
    end
    return false
end
function tabuleiro:check_possible_points_up()
    for i = 1, #tabuleiro[1] do 
        alteracao = true
        while alteracao == true do
            alteracao = false
            cont = 2
            while cont <= #tabuleiro do
                if tabuleiro[cont][i].valor ~= 0 then
                    if tabuleiro[cont][i].valor == tabuleiro[cont-1][i].valor then
                        alteracao = true
                        return true
                    end
                    cont = cont + 1
                else 
                    cont = cont + 1
                end
            end
        end
    end
    return false
end
function tabuleiro:check_possible_points_down()
    for i = 1, #tabuleiro[1] do 
        alteracao = true
        while alteracao == true do
            alteracao = false
            cont = #tabuleiro - 1
            while cont >= 1 do
                if tabuleiro[cont][i].valor ~= 0 then
                    if tabuleiro[cont][i].valor == tabuleiro[cont+1][i].valor then
                        alteracao = true
                        return true
                    end
                    cont = cont - 1
                else 
                    cont = cont - 1
                end
            end
        end
    end
    return false
end
function tabuleiro:check_status(points)
  local ocuped = true
  for linha = 1, #tabuleiro do
        for coluna = 1, #tabuleiro[1] do
          if tabuleiro[linha][coluna].valor == 0 then 
            ocuped = false
          elseif tabuleiro[linha][coluna].valor == 2048 then 
            display.newText("You win!",display.contentWidth/2,360)
            return false
          end
        end
  end
  if ocuped == true then 
    if (self:check_possible_points_up() == false and self:check_possible_points_right() == false and self:check_possible_points_down() == false and self:check_possible_points_left() == false) then 
      display.newText("Game Over!",display.contentWidth/2,360)
      return false
    end
  end
  return true
end

--ESTÁ DANDO ERRO NESTE MÉTODO
function tabuleiro:mudarCorQuadrado () -- TODAS AS fUNÇÕES ESTÃO COM O TABULEIRO: NO INICÍO PORQUE UMA VEZ
    for i = 1, #tabuleiro do                    -- VOCÊ DISSE QUE ERA ASSIM, NÃO SEI SE ERA UM CASO ESPECÍfICO OU NÃO
        for j = 1, #tabuleiro[1] do

            if(tabuleiro[i][j].valor == 0) then
                tabuleiro[i][j].img = "resource/pictures/default.png" -- MAIS ESPECIfICAMENTE QUANDO VOU ACESSAR O .IMG DA VARIÁVEL

            elseif(tabuleiro[i][j].valor == 2) then
                tabuleiro[i][j].img = "resource/pictures/2.png"

            elseif(tabuleiro[i][j].valor == 4) then
                tabuleiro[i][j].img = "resource/pictures/4.png"

            elseif(tabuleiro[i][j].valor == 8) then
                tabuleiro[i][j].img = "resource/pictures/8.png"

            elseif(tabuleiro[i][j].valor == 16) then
                tabuleiro[i][j].img = "resource/pictures/16.png"

            elseif(tabuleiro[i][j].valor == 32) then
                tabuleiro[i][j].img = "resource/pictures/32.png"

            elseif(tabuleiro[i][j].valor == 64) then
                tabuleiro[i][j].img = "resource/pictures/64.png"

            elseif(tabuleiro[i][j].valor == 128) then
                tabuleiro[i][j].img = "resource/pictures/128.png"

            elseif(tabuleiro[i][j].valor == 256) then
                tabuleiro[i][j].img = "resource/pictures/256.png"

            elseif(tabuleiro[i][j].valor == 512) then
                tabuleiro[i][j].img = "resource/pictures/512.png"

            elseif(tabuleiro[i][j].valor == 1024) then
                tabuleiro[i][j].img = "resource/pictures/1024.png"

            elseif(tabuleiro[i][j].valor == 2048) then
                tabuleiro[i][j].img = "resource/pictures/2048.png"

            end
        end
    end
end
return tabuleiro