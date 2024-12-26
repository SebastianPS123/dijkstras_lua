-- node class to represent vertices used in graph for dijkstra's algorithm

--[[
node: {
    _dist,
    _prev
}
]]

node = {}
node.__index = node

function node.new()
    return setmetatable({
        _dist = nil,
        _prev = nil,
    }, node)
end

function node:setDist(newDist)
    self._dist = newDist
end

function node:getDist()
    return self._dist
end

function node:setPrev(newPrev)
    self._prev = newPrev
end

function node:getPrev()
    return self._prev
end

function node:destroy()
    self._dist = nil
    self._prev = nil
    self:destroy()
end

return node

-- the whole thing behind metatables is that __index will make is so we search the overarching table when we don't find something
-- in the object, making it so that all functions are stored in the class and not needlessly duplicated : )