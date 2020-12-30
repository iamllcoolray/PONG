require("background/background")
require("entities/player")
require("entities/ball")
require("entities/ai")

function love.load()
  Background:load()
  Player:load()
  Ball:load()
  AI:load()

  Score = {player = 0, ai = 0}
  font = love.graphics.newFont("assets/audiowide.ttf", 30)
  gameOver = false
end

function love.update(dt)
  Background:update(dt)
  Player:update(dt)
  Ball:update(dt)
  AI:update(dt)

  gameStart()
end

function love.draw()
  Background:draw()
  AI:draw()
  Player:draw()
  if Score.player > 9 or Score.ai > 9 then
    love.graphics.print("Press \'r\' to restart", (love.graphics.getWidth() / 2) - 150, love.graphics.getHeight() / 2)
    gameOver = true
  else
    Ball:draw()
  end
  drawScore()
end

function drawScore()
  love.graphics.setFont(font)
  love.graphics.print("Player: "..Score.player, 50, 50)
  love.graphics.print("AI: "..Score.ai, 1000, 50)
end

function checkCollision(a, b)
  if a.x + a.width > b.x and a.x < b.x + b. width and a.y + a.height > b.y and a.y < b.y + b.height then
    return true
  else
    return false
  end
end

function gameStart()
  if gameOver == true and love.keyboard.isDown("r") then
    Score.player = 0
    Score.ai = 0
    gameOver = false
  end
end
