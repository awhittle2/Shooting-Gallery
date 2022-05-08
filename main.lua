function love.load() -- Before game code
    target = {} -- Creates an empty table
    target.x = 300 -- Adds an x key with 300 as the value to the table
    target.y = 300 -- Adds a y key with 300 as the value to the table
    target.radius = 50 -- Adds a radius key with 50 as the value to the table

    score = 0 -- Keeps track of the score
    timer = 0 -- Keeps track of the timer

    gameFont = love.graphics.newFont(40) -- Creates a new font that is 40px big
end

function love.update(dt) -- Update is game loop. Dt is delta time

end

function love.draw() -- Adds graphics to the screen
    love.graphics.setColor(1, 0, 0) -- Sets the graphics color to red
    love.graphics.circle("fill", target.x, target.y, target.radius) -- Creates a circle using the data from the target table initialized in love.load

    love.graphics.setColor(1, 1, 1) -- Sets graphics color to white
    love.graphics.setFont(gameFont) -- Sets the font to the font initialized in love.load
    love.graphics.print(score, 0, 0) -- Prints out the score at 0 0
end

function love.mousepressed(x, y, button, istouch, presses) -- Updating love's mouse pressed function
    if button == 1 then -- If the primary mouse button is pressed
        local distance = distanceBetween(x, y, target.x, target.y) -- Calls the distance function on the mouse and the circle center
        if distance < target.radius then  -- If the distance between the mouse and the center of the circle is less than the radius
            score = score + 1 -- Increase the score
        end
    end
end

function distanceBetween(x1, y1, x2, y2) -- Function to calculate the distance formula
    return ((x2-x1)^2+(y2-y1)^2)^(1/2) -- Distance formula
end