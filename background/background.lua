

Background = {}

function Background:load()
  self.universe = love.graphics.newImage("assets/universe.png")
  self.planets = love.graphics.newImage("assets/planets.png")
  self.width = self.planets:getWidth()
  self.height = self.planets:getHeight()
  self.rotation = 0
  self.alien_space = love.audio.newSource("audio/alien-space.mp3", "stream")
end

function Background:update(dt)
  self.rotation = self.rotation + 0.05 * dt

  self.alien_space:setLooping(true)
  self.alien_space:setPitch(0.5)
  self.alien_space:setVolume(0.5)
  self.alien_space:play()
end

function Background:draw()
  love.graphics.draw(self.universe, 0, 0)
  love.graphics.draw(self.planets, self.width / 2, self.height / 2, self.rotation, 1, 1, self.width / 2, self.height / 2)
end
