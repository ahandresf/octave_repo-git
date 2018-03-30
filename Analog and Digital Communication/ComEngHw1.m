##Communication engineering hw1
#Calculus of accumulated probability changing the limit C.
limit=0.99

###Solving for the number of channels necessary
#{
p=0.01
users=200
for(c=0:users) 
  c
  bc=binocdf(c,users,p)
  disp("--------------------------")
  if bc>=limit
    break
  endif
endfor
#}


###Fixing the number of channels 
c=10; #fixing
users=0; #Reseting users
p=0.2
while(true) 
  users=users+1
  bc=binocdf(c,users,p)
  disp("--------------------------")
  if bc<=limit
    break
  endif
endwhile
#}
