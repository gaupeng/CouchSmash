Ball = Class{}

local MAX_SPEED = 220
local MAX_N_SPEED = -220

function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dx = 0
    self.dy = 0
end

function Ball:collides(paddle)
    if paddle.y > self.y + self.height then
        return false
    end
    if paddle.x > self.x + self.width or self.x > paddle.x + paddle.width then
        return false
    end
    return true
end

function Ball:breakBrick(brick)
    if self.y > brick.y + brick.height or self.y + self.height < brick.y then
        return false
    end
    if brick.x > self.x + self.width or self.x > brick.x + brick.width then
        return false
    end
    return true
end

function Ball:center()
    self.x = VIRTUAL_WIDTH/2 - 2
    self.y = VIRTUAL_HEIGHT/2 - 2
    self.dx = 0
    self.dy = 0
end

function Ball:update(dt)

    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    if self.x <= 0 then
        sounds['wallHit']:play()
        self.x = self.x + 6
        self.dx = math.min(-self.dx + 31, MAX_SPEED)
    end
    if self.x + self.width >= VIRTUAL_WIDTH then
        sounds['wallHit']:play()
        self.x = self.x - 6
        self.dx = math.max(-self.dx - 31, MAX_N_SPEED)  
    end
    if self.y <= 0 then
        sounds['wallHit']:play()
        self.y = self.y + 5
        self.dy = -self.dy
    end

    if self:collides(player) then
        sounds['paddleHit']:play()
        self.y = self.y - 6
        self.dy = -self.dy
        -- set speed limit
        -- we don't want the ball to hit speed of light :P
        self.dy = math.max(self.dy*1.03, MAX_N_SPEED)


        -- if ball on left half of paddle
        if self.x <= player.x + (player.width)/2 - 2*self.width then
            local diff = player.x + (player.width)/2 - self.x - (self.width)/2
            if self.dx < 0 then
                self.dx = math.max(self.dx*(diff/1.80 + 1.5), MAX_N_SPEED)
            else
                self.dx = -self.dx
                self.dx = math.max(self.dx*(diff/1.80 + 1.5), MAX_N_SPEED)
            end

        -- if ball on right half of paddle    
        elseif self.x >= player.x + (player.width)/2 + 2*self.width then
            local diff = self.x + (self.width)/2 - player.x - (player.width)/2
            if self.dx < 0 then
                self.dx = -self.dx
                self.dx = math.min(self.dx*(diff/1.80 + 1.5), MAX_SPEED)
            else
                self.dx = self.dx*(diff/1.80 + 1.5)
                self.dx = math.min(self.dx, MAX_SPEED)
            end

        -- lands in the middle
        else
            if self.x + self.width/2 < player.x + (player.width/2) then
                if self.dx > 0 then
                    self.dx = -self.dx
                end
            else
                if self.dx < 0 then
                    self.dx = -self.dx
                end
            end
            self.dx = self.dx/3
        end
    end
    
    if self.y + self.height >= VIRTUAL_HEIGHT - 10 then
        sounds['restart']:play()
        result = 'lost'
        gameState = 'done'
        ball:center()
    end
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end