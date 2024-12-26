local node = require("node")
local graphModule = require("graph")

function getMinDistNode(vertexArray)
    -- start at node 1
    local minDistNode = vertexArray[1]
    local index = 1
    
    -- iterate from node 2 to end of vertexArray
    for i = 2, #vertexArray do
        -- if minDistNode is null, then autoset
        if minDistNode == nil then
            minDistNode = vertexArray[i]
            index = i
        -- if current node is null, move on
        elseif vertexArray[i] == nil then
            -- nothing
        -- if distance of currrent node is less than min node, then set minDistNode and index
        elseif vertexArray[i]:getDist() < minDistNode:getDist() then
            minDistNode = vertexArray[i]
            index = i
        end
    end

    -- return minDistNode and its index
    return minDistNode, index
end

function Dijkstra(graph, vertexCount, sourceVertexNum)
    local array = {}
    local result = {}

    -- create all vertex nodes and store in array
    for i = 1, vertexCount do
        local newNode = node.new()
        newNode:setDist(math.huge)
        table.insert(array, newNode)
    end

    -- sets source node distance to 0
    array[sourceVertexNum]:setDist(0)

    while true do
        -- gets min distance node in array, along with its index
        local minVertex, currentNodeIndex = getMinDistNode(array)
        
        -- if minVertex returned is null then break as we have cycled through all vertices!
        if minVertex == nil then
            break
        end

        -- remove from array and add to result
        array[currentNodeIndex] = nil
        result[currentNodeIndex] = minVertex

        -- go through vertices and check if neighbors, then compare/update distances
        for i = 1, vertexCount do
            if graph._adjacencyMatrix[currentNodeIndex][i] ~= 0 then
                local alternateDist = minVertex:getDist() + graph._adjacencyMatrix[currentNodeIndex][i]
                if alternateDist < array[i]:getDist() then
                    array[i]:setDist(alternateDist)
                    array[i]:setPrev(minVertex)
                end
            end
        end
    end

    -- return result
    return result
end

-- =======
-- TESTING
-- =======
local vertexCount = 5
local sourceVertex = 1

-- graph stuff
myGraph = graphModule.new({rows = vertexCount, columns = vertexCount, defaultValue = 0})
myGraph:addEdge(1, 2, 2)
myGraph:addEdge(1, 3, 6)
myGraph:addEdge(1, 4, 2)
myGraph:addEdge(1, 5, 8)
myGraph:addEdge(4, 5, 5)
myGraph:addEdge(3, 5, 1)
myGraph:addEdge(2, 3, 3)

print(myGraph)

-- result is returned as all vertices in order with updated distances from provided sourcevertex and their previous!

local initialTime = os.time()
local result = Dijkstra(myGraph, vertexCount, sourceVertex)
local benchmarkTime = os.time() - initialTime

for i = 1, #result do
    print("node number: " .. i .. ", distance from node " .. sourceVertex .. ": " .. result[i]:getDist())
end
print(benchmarkTime)