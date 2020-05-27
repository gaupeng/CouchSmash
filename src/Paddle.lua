Paddle = Class{}

function Paddle:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    -- Our paddle can only move along the x-axis
    self.dx = 0
end

function Paddle:update(dt)
    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)
    else
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
    end

end

function Paddle:center()
    self.dx = 0
    self.x = VIRTUAL_WIDTH/2 - 30
end

function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end