LevelThree = Class{}

local BRICK_WIDTH = 407*0.08 + 10
local MAX_SPEED = 220
local MAX_N_SPEED = -220

function LevelThree:init()
    self.startTime = love.timer.getTime()
    self.brickLayer1 = {}
    for i = 1, 8 do
        self.newBrick = Brick(i*BRICK_WIDTH, 5, false)
        table.insert(self.brickLayer1, self.newBrick)
    end 
    self.brickLayer2 = {}
    for i = 1, 5 do
        self.newBrick = Brick(i*BRICK_WIDTH + 66, 25, false)
        table.insert(self.brickLayer2, self.newBrick)
    end 
    self.brickLayer3 = {}
    for i = 1, 8 do
        self.newBrick = Brick2(i*BRICK_WIDTH + 15, 45, false)
        table.insert(self.brickLayer3, self.newBrick)
    end   
    self.brickLayer4 = {}
    for i = 1, 8 do
        self.newBrick = Brick2(i*BRICK_WIDTH + 15, 65, false)
        table.insert(self.brickLayer4, self.newBrick)
    end   
    self.brickLayer5 = {}
    for i = 1, 5 do
        self.newBrick = Brick(i*BRICK_WIDTH + 66, 85, false)
        table.insert(self.brickLayer5, self.newBrick)
    end   
    self.brickLayer6 = {}
    for i = 1, 8 do
        self.newBrick = Brick(i*BRICK_WIDTH, 105, false)
        table.insert(self.brickLayer6, self.newBrick)
    end   
end

function LevelThree:render()
    for key, brick in pairs(self.brickLayer1) do
        brick:render()
    end
    for key, brick in pairs(self.brickLayer2) do
        brick:render()
    end
    for key, brick in pairs(self.brickLayer3) do
        brick:render()
    end
    for key, brick in pairs(self.brickLayer4) do
        brick:render()
    end    
    for key, brick in pairs(self.brickLayer5) do
        brick:render()
    end    
    for key, brick in pairs(self.brickLayer6) do
        brick:render()
    end      
end

function LevelThree:update(dt)
    for key, brick in pairs(self.brickLayer1) do
        brick.remove = ball:breakBrick(brick)
        if brick.remove then
            sounds['wallHit']:play()
            ball.dy = -ball.dy
            if ball.dy > 0 then
                ball.y = ball.y + 5
                ball.dy = math.min(ball.dy*1.03, MAX_SPEED)
            else
                ball.y = ball.y - 5
                ball.dy = math.max(ball.dy*1.03, MAX_N_SPEED)
            end
            table.remove(self.brickLayer1, key)
        end
    end

    for key, brick in pairs(self.brickLayer2) do
        brick.remove = ball:breakBrick(brick)
        if brick.remove then
            sounds['wallHit']:play()
            ball.dy = -ball.dy
            if ball.dy > 0 then
                ball.y = ball.y + 5
                ball.dy = math.min(ball.dy*1.03, MAX_SPEED)
            else
                ball.y = ball.y - 5
                ball.dy = math.max(ball.dy*1.03, MAX_N_SPEED)
            end
            table.remove(self.brickLayer2, key)
        end
    end

    for key, brick in pairs(self.brickLayer3) do
        if ball:breakBrick(brick) then
            sounds['wallHit']:play()
            brick.remove = brick.remove - 1
            ball.dy = -ball.dy
            if ball.dy > 0 then
                ball.y = ball.y + 5
                ball.dy = math.min(ball.dy*1.03, MAX_SPEED)
            else
                ball.y = ball.y - 5
                ball.dy = math.max(ball.dy*1.03, MAX_N_SPEED)
            end
            if brick.remove == 1 then
                brick.image = love.graphics.newImage('assets/brick2break.png')
            elseif brick.remove == 0 then
                table.remove(self.brickLayer3, key)
            end
        end
    end

    for key, brick in pairs(self.brickLayer4) do
        if ball:breakBrick(brick) then
            sounds['wallHit']:play()
            brick.remove = brick.remove - 1
            ball.dy = -ball.dy
            if ball.dy > 0 then
                ball.y = ball.y + 5
                ball.dy = math.min(ball.dy*1.03, MAX_SPEED)
            else
                ball.y = ball.y - 5
                ball.dy = math.max(ball.dy*1.03, MAX_N_SPEED)
            end
            if brick.remove == 1 then
                brick.image = love.graphics.newImage('assets/brick2break.png')
            elseif brick.remove == 0 then
                table.remove(self.brickLayer4, key)
            end
        end
    end

    for key, brick in pairs(self.brickLayer5) do
        brick.remove = ball:breakBrick(brick)
        if brick.remove then
            sounds['wallHit']:play()
            ball.dy = -ball.dy
            if ball.dy > 0 then
                ball.y = ball.y + 5
                ball.dy = math.min(ball.dy*1.03, MAX_SPEED)
            else
                ball.y = ball.y - 5
                ball.dy = math.max(ball.dy*1.03, MAX_N_SPEED)
            end
            table.remove(self.brickLayer5, key)
        end
    end
    for key, brick in pairs(self.brickLayer6) do
        brick.remove = ball:breakBrick(brick)
        if brick.remove then
            sounds['wallHit']:play()
            ball.dy = -ball.dy
            if ball.dy > 0 then
                ball.y = ball.y + 5
                ball.dy = math.min(ball.dy*1.03, MAX_SPEED)
            else
                ball.y = ball.y - 5
                ball.dy = math.max(ball.dy*1.03, MAX_N_SPEED)
            end
            table.remove(self.brickLayer6, key)
        end
    end

    if not next(self.brickLayer1) and not next(self.brickLayer2) and not next(self.brickLayer3)
    and not next(self.brickLayer4) and not next(self.brickLayer5) and not next(self.brickLayer6) then
        totalTime = totalTime + levelTime
        sounds['restart']:play()
        currentLevel = 4
        result = 'won'
        gameState = 'done'
    end
end