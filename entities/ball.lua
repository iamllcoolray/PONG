

Ball = {}

function Ball:load()
  self.x = love.graphics.getWidth() / 2
  self.y = love.graphics.getHeight() / 2
  self.img = love.graphics.newImage("assets/ball.png")
  self.width = 20
  self.height = 20
  self.speed = 200
  self.xVel = -self.speed
  self.yVel = 0
  self.blop = love.audio.newSource("audio/blop.mp3", "static")
end

function Ball:update(dt)
  self:movement(dt)
  self:collision()
end

function Ball:movement(dt)
  self.x = self.x + self.xVel * dt
  self.y = self.y + self.yVel * dt
end

function Ball:collision()
  self:paddleCollisionPlayer()
  self:paddleCollisionAI()
  self:windowCollision()
  self:score()
end

function Ball:paddleCollisionPlayer()
  if checkCollision(self, Player) then
    self.xVel = self.speed
    local middleBall = self.y + self.height / 2
    local middlePlayer = Player.y + Player.height / 2
    local collisionPosition = middleBall - middlePlayer
    self.yVel = collisionPosition * 5
    self.blop:play()
  end
end

function Ball:paddleCollisionAI()
  if checkCollision(self, AI) then
    self.xVel = -self.speed
    local middleBall = self.y + self.height / 2
    local middleAI = AI.y + AI.height / 2
    local collisionPosition = middleBall - middleAI
    self.yVel = collisionPosition * 5
    self.blop:play()
  end
end

function Ball:windowCollision()
  if self.y < 0 then
    self.y = 0
    self.yVel = -self.yVel
    self.blop:play()
  elseif self.y + self.height > love.graphics.getHeight() then
    self.y = love.graphics.getHeight() - self.height
    self.yVel = -self.yVel
    self.blop:play()
  end
end

function Ball:score()
  if self.x < 0 then
    self:resetPositon(1)
    Score.ai = Score.ai + 1
  end

  if self.x + self.width > love.graphics.getWidth() then
    self:resetPositon(-1)
    Score.player = Score.player + 1
  end
end

function Ball:resetPositon(modifier)
  self.x = love.graphics.getWidth() / 2 - self.width / 2
  self.y = love.graphics.getHeight() / 2 - self.height / 2
  self.yVel = 0
  self.xVel = self.speed * modifier
end

function Ball:draw()
  love.graphics.draw(self.img, self.x, self.y)
end
