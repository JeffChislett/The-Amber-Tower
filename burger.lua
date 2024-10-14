Burger = {}
Burger.__index = Burger
ActiveBurgers = {}

function Burger.new(x,y)
    local instance = setmetatable({}, Burger)
    instance.x = x
    instance.y = y
    --instance.img = love.graphics.newImage("assets/items/burger/1.png")
    instance.loadAssets()
    instance.width = instance.img:getWidth()
    instance.height = instance.img:getHeight()
    instance.toBeRemoved = false
    
    instance.physics = {}
    instance.physics.body = love.physics.newBody(World, instance.x, instance.y, "static")
    instance.physics.shape = love.physics.newRectangleShape(instance.width,instance.height)
    instance.physics.fixture = love.physics.newFixture(instance.physics.body, instance.physics.shape)
    instance.physics.fixture: setSensor(true)
    table.insert(ActiveBurgers,instance)
end

function Burger:loadAssets()
    self.animation = {timer = 0, rate = 0.1}
    self.animation.burger = {total = 4, current = 1, img = {}}
    for i=1,self.animation.burger.total do
        self.animation.burger.img[i] = love.graphics.newImage("assets/items/burger/"..i..".png")
    end


    self.animation.draw = self.animation.burger.img[1]
    self.animation.width = self.animation.draw:getWidth()
    self.animation.height = self.animation.draw:getHeight()

end

function Burger:remove()
    for i,instance in ipairs(ActiveBurgers) do
        if instance == self then
            Player:incrementBurgers()
            print(Player.burgers)
            self.physics.body:destroy()
            table.remove(ActiveBurgers, i)
        end
    end
end


function Burger:update(dt)
    self:animate(dt)
    self:checkRemove()

end

function Burger:setState()
    if not self.grounded then
        self.state = "jump"
    elseif self.xVel == 0 then
        self.state = "idle"
    else 
        self.state = "walk"        
    end
end

function Burger:checkRemove()
    if self.toBeRemoved() then
       self:remove()
    end
end

function Burger:animate(dt)
    self.animation.timer = self.animation.timer + dt
    if self.animation.timer > self.animation.rate then
        self.animation.timer = 0
        self:setNewFrame()
    end
end

function Burger:setNewFrame()
    local anim = self.animation[self.state]
    if anim.current < anim.total then
       anim.current = anim.current + 1
    else
       anim.current = 1
    end
    self.animation.draw = anim.img[anim.current]

end

function Burger:draw()
    love.graphics.draw(self.img, self.x, self.y,0,1,1,self.width / 2, self.height / 2)
end

function Burger:updateAll(dt)
    for i,instance in ipairs(ActiveBurgers) do
        instance:update(dt)
    end
end

function Burger:drawAll()
    for i,instance in ipairs(ActiveBurgers) do
        instance:draw() 
    end
end

function Burger:beginContact(a,b,collision)
    for i,instance in ipairs(ActiveBurgers) do
        if a == instance.physics.fixture or b == instance.physics.fixture then
           if a == Player.physics.fixture or b == Player.physics.fixture then
                instance.toBeRemoved = true
                return true
           end
        end
    end
end