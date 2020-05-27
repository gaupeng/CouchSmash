Brick = Class{}

function Brick:init(x, y, isMoving)
    self.image = love.graphics.newImage('assets/brick.png')
    self.x = x
    self.y = y
    self.width = self.image:getWidth()*0.08
    self.height = self.image:getHeight()*0.08
    self.remove = 1
    self.isMoving = isMoving

    -- If ball is moving, set initial speeds to 0
    if self.isMoving then
        self.dx = 0
        self.dy = 0
    end
end

function Brick:render()
    love.graphics.draw(self.image, self.x, self.y, 0, 0.08, 0.08)
end