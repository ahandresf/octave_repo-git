function b=bit_rand(n)
n=100
k=0;
while k!=n
  if rand>0.5
    b=1;
  else
    b=-1;
  endif
  k=k+1;
  bin_input(k)=b;
endwhile
endfunction

my_test=feval("bit_rand",int(3))
