local MFGraph = {}
MFGraph.__index = MFGraph

function MFGraph.new()
    local g = { tbl = {}, parent = {} }
    -- parent 테이블은 augPATH 내에서 매번 초기화되므로 여기서 설정할 필요가 없습니다.
    return setmetatable(g, MFGraph)
end

function MFGraph:addEdge(u, v, c)
    local forward_edge = { to = v, cap = c, flow = 0}
    -- 역방향 간선의 flow는 0으로 초기화하는 것이 일반적입니다.
    -- 유량의 대칭성을 위해 -flow를 사용하므로 초기값은 0이 맞습니다.
    local backward_edge = { to = u, cap = 0, flow = 0}
    
    forward_edge.reverse = backward_edge
    backward_edge.reverse = forward_edge
    
    if self.tbl[u]==nil then self.tbl[u]={} end
    if self.tbl[v]==nil then self.tbl[v]={} end
    table.insert(self.tbl[u], forward_edge)
    table.insert(self.tbl[v], backward_edge)
end

local maxflow = 0

function MFGraph:augPATH(src, dst)
    -- parent[노드] = 해당 노드로 들어온 간선
    -- 경로를 찾기 전에 매번 초기화합니다.
    self.parent = {}
    
    local visited = {}
    
    -- DFS를 통해 src에서 dst까지의 경로를 찾습니다.
    -- 경로를 찾았는지 여부를 반환합니다.
    local function DFS(node)
        if node == dst then
            return true -- 목적지에 도달하면 경로 찾기 성공
        end
        
        visited[node] = true
        
        if self.tbl[node] then -- 해당 노드에서 출발하는 간선이 있는지 확인
            for _, next_edge in ipairs(self.tbl[node]) do
                -- 잔여 용량이 있고, 아직 방문하지 않은 노드라면
                if (next_edge.cap - next_edge.flow > 0) and (not visited[next_edge.to]) then
                    -- 어떤 간선을 통해 다음 노드로 갔는지 기록합니다.
                    self.parent[next_edge.to] = next_edge 
                    
                    -- 재귀 호출로 경로를 계속 탐색
                    if DFS(next_edge.to) then
                        return true -- 경로를 찾았으면 더 이상 탐색하지 않고 즉시 반환
                    end
                end
            end
        end
        
        return false -- 이 노드에서는 경로를 찾지 못함
    end

    -- 1. DFS를 시작하여 증가 경로가 있는지 확인
    local path_found = DFS(src)
    
    -- 증가 경로가 없으면 최대 유량을 출력하고 종료
    if not path_found then
        io.write(maxflow .. "\n")
        os.exit()
    end

    -- 2. 경로를 역추적하여 보낼 유량(bottle) 계산
    local bottle = math.huge
    local current_node = dst
    while current_node ~= src do
        local edge = self.parent[current_node]
        bottle = math.min(bottle, edge.cap - edge.flow)
        current_node = edge.reverse.to -- 이전 노드로 이동
    end

    -- 3. 계산된 유량(bottle)만큼 경로에 흘려보냄
    current_node = dst
    while current_node ~= src do
        local edge = self.parent[current_node]
        edge.flow = edge.flow + bottle
        edge.reverse.flow = edge.reverse.flow - bottle
        current_node = edge.reverse.to -- 이전 노드로 이동
    end

    maxflow = maxflow + bottle
end


-- ================ 실행 부분 ================
local n = io.read("*n")
io.read() -- 사용하지 않는 줄(o) 읽어서 버리기

local mygraph = MFGraph.new()

for i=1,n do
    local str=io.read()
    local dep,dst=string.sub(str,1,1),string.sub(str,3,3)
    local flow = tonumber(string.sub(str,5,-1))
    mygraph:addEdge(dep, dst, flow)
end

while true do
    mygraph:augPATH("A", "Z")
end

