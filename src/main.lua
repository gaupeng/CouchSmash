-- push library
push = require 'push'

-- class library
Class = require 'class'
require 'Ball'
require 'Paddle'
require 'Brick'
require 'Brick2'
require 'LevelOne'
require 'LevelTwo'
require 'LevelThree'

-- size of our actual window
WINDOW_WIDTH = 1920
WINDOW_HEIGHT = 1080

-- size we're trying to emulate with push
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 244

PADDLE_MAX_SPEED = 350


function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Couch Smash')
    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true,
        canvas = false
    })
    totalTime = 0
    gameState = 'start'
    currentLevel = 1
    result = 'lost'
    player = Paddle(VIRTUAL_WIDTH/2 - 30, VIRTUAL_HEIGHT - 20, 60, 5)
    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    sounds = {
        ['paddleHit'] = love.audio.newSource('assets/paddlehit.wav', 'static'),
        ['restart'] = love.audio.newSource('assets/restart.wav', 'static'),
        ['wallHit'] = love.audio.newSource('assets/wallhit.wav', 'static')
    }

    smallFont = love.graphics.newFont('assets/font.ttf', 8)
    largeFont = love.graphics.newFont('assets/font.ttf', 16)
    scoreFont = love.graphics.newFont('assets/font.ttf', 32)
    levels = {}
    levels[1] = 'LevelOne'
    levels[2] = 'LevelTwo'
    levels[3] = 'LevelThree'

    level = _G[levels[currentLevel]]()
    love.graphics.setFont(smallFont)
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    if gameState == 'start' then
        ball.dx = 10
        ball.dy = 120
    end
    if love.keyboard.isDown('d') or love.keyboard.isDown('right') then
        if player.dx <= 0 then
            player.dx = 20
        end
        player.dx = math.min(player.dx*1.3, PADDLE_MAX_SPEED)
    elseif love.keyboard.isDown('a') or love.keyboard.isDown('left') then
        if player.dx >=0 then
            player.dx = -20
        end
        player.dx = math.max(player.dx*1.3, -PADDLE_MAX_SPEED)
    else
        player.dx = 0
    end

    if gameState == 'play' then
        ball:update(dt)
        level:update(dt)
        player:update(dt)
    end
end

function love.keypressed(key)
    if key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        elseif gameState == 'done' then
            player.x = VIRTUAL_WIDTH/2 - 20
            ball:center()
            ball.dx = -10
            ball.dy = 120
            gameState = 'play'
        elseif gameState == 'finish' then
            ball:center()
            player:center()
            gameState = 'start'
        end
    end
end

function love.draw()
    push:start()
    if gameState == 'start' then
        love.graphics.clear(0/255, 0/255, 0/255, 0/255)
        love.graphics.setFont(smallFont)
        love.graphics.printf('Welcome to Couch Smash!', 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to begin!', 0, 20, VIRTUAL_WIDTH, 'center')
        
    elseif gameState == 'play' then
        endTime = love.timer.getTime()
        levelTime = endTime - level.startTime
        i, j = string.find(levelTime, ".")
        formTime = string.sub(levelTime, 1, j + 3)
        love.graphics.printf('Time: ' .. tostring(formTime), 0, VIRTUAL_HEIGHT - 10, VIRTUAL_WIDTH, 'right')
        player:render()
        ball:render()
        level:render()

    elseif gameState == 'done' then
            if result == 'won' then
                if currentLevel < 4 then
                    love.graphics.setFont(smallFont)
                    love.graphics.printf('Amazing!', 0, 10, VIRTUAL_WIDTH, 'center')
                    love.graphics.printf('Press Enter to continue!', 0, 20, VIRTUAL_WIDTH, 'center')
                    love.graphics.printf('Level completion time: ' .. tostring(levelTime), 0, 30, VIRTUAL_WIDTH, 'center')
                    level = _G[levels[currentLevel]]()
                else
                    currentLevel = 1
                    gameState = 'finish'
                    level = _G[levels[currentLevel]]()
                end
            else
                love.graphics.setFont(smallFont)
                love.graphics.printf('Better luck next time!', 0, 10, VIRTUAL_WIDTH, 'center')
                love.graphics.printf('Press Enter to start over!', 0, 20, VIRTUAL_WIDTH, 'center')
                level = _G[levels[currentLevel]]()
            end
    
    elseif gameState == 'finish' then
        love.graphics.setFont(smallFont)
        love.graphics.printf('Amazing! You completed the game!', 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Level completion time: ' .. tostring(formTime), 0, 20, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Total Time: ' .. tostring(totalTime), 0, 30, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to restart!', 0, VIRTUAL_HEIGHT - 10, VIRTUAL_WIDTH, 'center')
    end
    push:finish()
end

function love.conf(t)
	t.console = true
end