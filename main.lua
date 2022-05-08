function love.load() -- Before game code
    target = {} -- Creates a table to store target info
    target.radius = 50 -- Adds a radius key with 50 as the value to the table
    target.x = math.random(target.radius, love.graphics.getWidth() - target.radius) -- Random beginning x coord for target
    target.y = math.random(target.radius, love.graphics.getHeight() - target.radius) -- Random beginning y coord for target

    score = 0 -- Keeps track of the score
    timer = 0 -- Keeps track of the timer
    gameState = 1 -- Keeps track of game state

    gameFont = love.graphics.newFont(40) -- Creates a new font that is 40px big

    sprites = {} -- Create a new table to store sprites
    sprites.sky = love.graphics.newImage('sprites/sky.png') -- Adds sky sprite
    sprites.target = love.graphics.newImage('sprites/target.png') -- Ads target sprite
    sprites.crosshairs = love.graphics.newImage('sprites/crosshairs.png') -- Adds crosshair sprite

    love.mouse.setVisible(false) -- Make the mouse invisible
end

function love.update(dt) -- Update is game loop. Dt is delta time
    if gameState == 2 then -- If in game
        if timer > 0 then -- If timer is greater than 0
            timer = timer - dt -- Continue subtracting
        end
        
        if timer < 0 then -- If timer is less than 0
            timer = 0 -- Set it to 0 (so there are no negative numbers)
            gameState = 1 -- Sets to menu state
            score = 0 -- Resets the score
        end
    end
end

function love.draw() -- Adds graphics to the screen
    love.graphics.draw(sprites.sky, 0, 0) -- Prints the sky sprite to screen

    love.graphics.setColor(1, 1, 1) -- Sets color to white
    love.graphics.setFont(gameFont) -- Sets the font as initialized in love.load
    love.graphics.print("Score: " .. score, 5, 5) -- Prints out the score at 5, 5
    love.graphics.print("Timer: " .. math.ceil(timer), 250, 5) -- Prints out the timer and rounds down to the nearest int at 250, 5

    if gameState == 1 then -- If at the main menu
        love.graphics.printf("Click Anywhere to Begin!", 0, 250, love.graphics.getWidth(), "center") -- Print text telling the user to click
    end

    if gameState == 2 then -- If in game
        love.graphics.draw(sprites.target, target.x - target.radius, target.y - target.radius) -- Draw the target
    end

    love.graphics.draw(sprites.crosshairs, love.mouse.getX() - 20, love.mouse.getY() - 20) -- Draw the crosshairs and put it at the position of the mouse
end

function love.mousepressed(x, y, button, istouch, presses) -- Updated love's mouse pressed function to preform custom actions if clicked
    if button == 1 and gameState == 2 then -- Checks if in game and if it was the primary mouse button
        local distance = distanceBetween(x, y, target.x, target.y) -- Calls the distance function on the mouse and the circle center
        if distance < target.radius then  -- If the distance between the mouse and the center of the circle is less than the radius
            score = score + 1 -- Increase the score
            target.x = math.random(target.radius, love.graphics.getWidth() - target.radius) -- Set the target to a random x location
            target.y = math.random(target.radius, love.graphics.getHeight() - target.radius) -- Set the target to a random y location
        end
    elseif button == 1 and gameState == 1 then -- Checks if in main menu and if it was the primary mouse button
        gameState = 2 -- Set to in game
        timer = 10 -- Restart timer
    end
end

function distanceBetween(x1, y1, x2, y2) -- Function to calculate the distance formula
    return ((x2-x1)^2+(y2-y1)^2)^(1/2) -- Distance formula
end