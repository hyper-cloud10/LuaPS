q={}
track={}
q.first,q.last=1,2
local MAX=100001
function pushFirst(value)
    q.first=q.first-1
    q[q.first]=value
end
function popFirst()
    local value=q[q.first]
    q[q.first]=nil
    q.first=q.first+1
    return value
end
n,k=io.read("*n","*n")
q[1]=n
check,dist={},{}
for i=0,MAX,1 do check[i]=0 dist[i]=0 end
dist[n]=0
while q.first~=q.last do
    now=tonumber(popFirst())
    if not now then
        break
    end
    if 2*now<=MAX and check[now+now]==0 then
        q[q.last]=2*now
        q.last=q.last+1
        check[2*now]=1
        dist[2*now]=dist[now]+1
        if track[2*now]==nil then track[2*now]=now end
    end
    if now>=1 and check[now-1]==0 then
        q[q.last]=now-1
        q.last=q.last+1
        check[now-1]=1
        dist[now-1]=dist[now]+1
        if track[now-1]==nil then track[now-1]=now end
    end
    if now+1<=MAX and check[now+1]==0 then
        q[q.last]=now+1
        q.last=q.last+1
        check[now+1]=1
        dist[now+1]=dist[now]+1
        if track[now+1]==nil then track[now+1]=now end
    end
    if now==k then break end
end
if n==k then dist[k]=0 end
tracker=k
backtbl={}
for i=1,dist[k] do backtbl[dist[k]+1-i]=tracker tracker=track[tracker] end
if n~=0 then
    print(dist[k])
    io.write(n," ")
    for i=1,dist[k] do io.write(backtbl[i]," ") end
elseif k~=0 then
    print(dist[k]-1)
    io.write(n," ")
    for i=2,dist[k] do io.write(backtbl[i]," ") end
else
    print(0)
    print(0)
end
