while 1 do
    i=io.read("*n")
    if i==0 then os.exit() end
    local cnt=0
    local x=i*i
    for j=1,i do
        if x%j==0 then
            if (j+(x//j))%2==0 and (x//j)>j+2*i then
                cnt=cnt+1
            end
        end
    end
    io.write(cnt,"\n")
end
