local STI = require("sti")
require("Player")
require("Burger")
love.graphics.setDefaultFilter("nearest","nearest")

function love.load()

    Map = STI("map/001.lua",{"box2d"})
    World = love.physics.newWorld(0,0)
    World:setCallbacks(beginContact,endContact)
    Map:box2d_init(World)
    Map.layers.solid.visible = false
    background = love.graphics.newImage("assets/background.png")
    Player:load()




end

function love.update(dt)
    World:update(dt)
    Player:update(dt)
    Burger:update(dt)
end

function love.draw()
    love.graphics.draw(background)
    Map:draw(0,0,2,2)
    love.graphics.push()
    love.graphics.scale(2,2)

    Player:draw()
    Burger.drawAll()    --11:33 in video 4/6

    love.graphics.pop()


end

function love.keypressed(key)
    Player:jump(key)
end

function beginContact(a,b,collision)
    if Burger.beginContact(a, b, collision) then return end
    Player:beginContact(a, b, collision)
end

function endContact(a,b,collision)
    Player:endContact(a, b, collision)
end