Brick2 = Class{}

function Brick2:init(x, y, isMoving)
    self.image = love.graphics.newImage('assets/brick2.png')
    self.remove = 2
    self.x = x
    self.y = y
    self.width = self.image:getWidth()*0.12
    self.height = self.image:getHeight()*0.12
    self.isMoving = isMoving

    -- If ball is moving, set initial speeds to 0
    if self.isMoving then
        self.dx = 0
        self.dy = 0
    end
end

function Brick2:render()
    love.graphics.draw(self.image, self.x, self.y, 0, 0.12, 0.12)
end