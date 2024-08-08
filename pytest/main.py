(x,y) = (32,25)
(a,b) = (x/64,y/64)

s = [0,1]


l = 0
for i in range(0,64):
    r_index = i%2
    rn = s[r_index]
    l += log(abs(rn * (1-xn)))

print(l/64)