####Online Example
#{
b = [1, 1, 1];
a = [1, -5, 8, -4];
[r, p, k, e] = residue (b, a)
   ⇒ r = [-2; 7; 3]
   ⇒ p = [2; 2; 1]
   ⇒ k = [](0x0)
   ⇒ e = [1; 2; 1]
which represents the following partial fraction expansion

        s^2 + s + 1       -2        7        3
   ------------------- = ----- + ------- + -----
   s^3 - 5s^2 + 8s - 4   (s-2)   (s-2)^2   (s-1)
   
#}



#Just get the partial fraction
#b/a

b=[1,6,8,0]; #s^3+6s^2+8s
a=[-8];
[r, p, k, e] = residue(b,a)

#{
>> [r, p, k, e] = residue(b,a)

r = [](0x0)
p = [](0x0)
k =

  -0.12500  -0.75000  -1.00000  -0.00000
e = [](0x0)
#}


b=[1,6,8]; #s^2+6s+8
a=[1 6]; #s+6
[r, p, k, e] = residue(b,a)

#{
>> [r, p, k, e] = residue(b,a)
r =  8
p = -6
k =
   1   0
e =  1
#}

