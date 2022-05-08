function love.load() -- Before game code
    target = {} -- Creates an empty table
    target.radius = 50 -- Adds a radius key with 50 as the value to the table
    target.x = math.random(target.radius, love.graphics.getWidth() - target.radius) -- Sets the location at random to begin
    target.y = math.random(target.radius, love.graphics.getHeight() - target.radius) -- Sets the location at random to begin

    score = 0 -- Keeps track of the score
    timer = 0 -- Keeps track of the timer
    gameState = 1

    gameFont = love.graphics.newFont(40) -- Creates a new font that is 40px big

    sprites = {}
    sprites.sky = love.graphics.newImage('sprites/sky.png')
    sprites.target = love.graphics.newImage('sprites/target.png')
    sprites.crosshairs = love.graphics.newImage('sprites/crosshairs.png')

    love.mouse.setVisible(false)
end

function love.update(dt) -- Update is game loop. Dt is delta time
    if gameState == 2 then
        if timer > 0 then -- If timer is greater than 0
            timer = timer - dt -- Continue subtracting
        end
        
        if timer < 0 then -- If timer is less than 0
            timer = 0 -- Set it to 0
            gameState = 1
            score = 0
        end
    end
end

function love.draw() -- Adds graphics to the screen
    love.graphics.draw(sprites.sky, 0, 0)

    love.graphics.setColor(1, 1, 1) -- Sets graphics color to white
    love.graphics.setFont(gameFont) -- Sets the font to the font initialized in love.load
    love.graphics.print("Score: " .. score, 5, 5) -- Prints out the score at 0 0
    love.graphics.print("Timer: " .. math.ceil(timer), 250, 5) -- Prints out the timer and rounds down to the nearest int

    if gameState == 1 then
        love.graphics.printf("Click Anywhere to Begin!", 0, 250, love.graphics.getWidth(), "center")
    end

    if gameState == 2 then
        love.graphics.draw(sprites.target, target.x - target.radius, target.y - target.radius)
    end

    love.graphics.draw(sprites.crosshairs, love.mouse.getX() - 20, love.mouse.getY() - 20)
end

function love.mousepressed(x, y, button, istouch, presses) -- Updating love's mouse pressed function
    if button == 1 and gameState == 2 then -- If the primary mouse button is pressed
        local distance = distanceBetween(x, y, target.x, target.y) -- Calls the distance function on the mouse and the circle center
        if distance < target.radius then  -- If the distance between the mouse and the center of the circle is less than the radius
            score = score + 1 -- Increase the score
            target.x = math.random(target.radius, love.graphics.getWidth() - target.radius) -- Oncce target is clicked move it to another random location
            target.y = math.random(target.radius, love.graphics.getHeight() - target.radius) -- Once target is clicked move it to another random location
        end
    elseif button == 1 and gameState == 1 then
        gameState = 2
        timer = 10
    end
end

function distanceBetween(x1, y1, x2, y2) -- Function to calculate the distance formula
    return ((x2-x1)^2+(y2-y1)^2)^(1/2) -- Distance formula
end