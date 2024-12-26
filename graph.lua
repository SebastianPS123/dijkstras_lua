graph = {}
graph.__index = graph

function createMatrix(rows, columns, defaultValue)
    local matrix = {}

    for x = 1, rows do
        matrix[x] = {} -- create new row
        for y = 1, columns do
            matrix[x][y] = defaultValue
        end
    end

    return matrix
end

--[[
args structure:
{
    rows,
    columns,
    defaultValue
}
]]

function graph.new(args)
    return setmetatable({
        _adjacencyMatrix = createMatrix(args.rows, args.columns, args.defaultValue),
        _rows = args.rows,
        _columns = args.columns,
    }, graph)
end

function graph:addEdge(x, y, weight)
    self._adjacencyMatrix[x][y] = weight
end

graph.__tostring = function(self)
    local str = ""
    for x = 1, self._rows do
        for y = 1, self._columns do
            str = str .. self._adjacencyMatrix[x][y] .. " "
        end
        str = str .. "\n"
    end
    return str
end

--local myGraph = graph.new({rows = 3, columns = 3, defaultValue = 0})
--print(myGraph)

return graph