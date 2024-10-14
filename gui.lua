GUI = {}

function GUI:load()
    self.burgers = {}
    self.burgers.img = love.graphics.newImage("assets/items/burger/1.png")
    self.burgers.width = self.burgers.img:getWidth()
    self.burgers.height = self.burgers.img:getHeight()
    self.burgers.scale = 3
    self.burgers.x = 50
    self.burgers.y = 50
    self.font = love.graphics.newFont("assets/breamcatcher.ttf", 36)
end

function GUI:update()

end

function GUI:draw()
    self:displayBurgers()
end

function GUI:displayBurgers()
    love.graphics.draw(self.burgers.img, self.burgers.x, self.burgers.y, 0, self.burgers.scale, self.burgers.scale)
    love.graphics.setFont(self.font)
    local x = self.burgers.x + self.burgers.width / 2 * self.burgers.scale
    local y = self.burgers.y + self.burgers.height / 2 * self.burgers.scale - self.font:getHeight() / 2
    love.graphics.print("  :  "..Player.burgers, self.burgers.x, self.burgers.y)
end