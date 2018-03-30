clear all

### Data from your material
#GENERAL CONSTANS
mo=9.10956*1e-31 # For whatever material, mass of electron in rest Kg
h=6.62607*1e-34  #m2 kg / s  or J.s
q=1.6022*1e-19  #C
K=1.381*1e-23   #J/K
T=300 #Temeprature in Kelvin pre-set for room temperature


####################################################
##"Calculation for Ti-p-GaAs 5 1e17"
disp("#########################")
disp("Calculation for Ti-p-GaAs")
#FROM THE METAL
qm=4.33 #Work function

#FROM THE SEMICONDUCTOR
#For GaAs
qx=4.07 #Electron Affinity qx=Evacum-Ec
Eg=1.424 #Gap Energy
mh=0.34 #For holes in 
Na=5*1e17 #Doping type p
Nv=7.7*1e18 #from tables


#For a p dopped material 

#We calculate Nv p material
mp=mo*mh
#Nv=2*sqrt((2*pi*mp*K*T)^3)/(h^3)
Vp=-1*((K*T)/q)*log(Na/Nv)

#We obtain Bp
qVbip=qm-qx-Eg+Vp #this is for a p dopped material
Bp=qm-qx-Eg # Height of the contact


####################################################
##Al-p-Si 1e17

###copyfile

disp("#########################")
disp("Calculation Al-p-Sie17")
#FROM THE METAL
qm= 4.16 #Work function of Al, I found 4.16

#FROM THE SEMICONDUCTOR
#For Silicon
qx=4.05 #Electron Affinity qx=Evacum-Ec
Eg=1.1 #Gap Energy for Si
mh=0.49 #For holes in 
Na=1e17 #Doping type p
Nv=1*1e19 #from tables


#For a p dopped material 

#We calculate Nv p material
mp=mo*mh
#Nv=2*sqrt((2*pi*mp*K*T)^3)/(h^3)
Vp=-1*((K*T)/q)*log(Na/Nv)

#We obtain Bp
Bp=qm-qx-Eg # Height of the contact
qVbip=abs(Bp)-abs(Vp) #this is for a p dopped material
###paste




###############################################
#Calculation for Al-n-Si 1e17
disp("#########################")
disp("Calculation for Al-n-Si")

#FROM THE METAL
qm=4.16 #Work function Al

#FROM THE SEMICONDUCTOR
#For Si
qx=4.05 #Electron Affinity of Si qx=Evacum-Ec
Eg=1.1 #Gap Energy Si
me=0.26 #Effective mass for conductivity calculation in Silicon me*/mo 
Nd= 1e17#Doping type n
Nc=2.82*1e19 #Silicon effective density of states


#For a n dopped material 

#We calculate Nd p material
mn=mo*me
  #a=(2*pi*mn*K*T)^3
  #b=sqrt(a)
  #c=h^3
  #d=12*b/c
#Nc=12*sqrt((2*pi*mn*K*T)^3)/(h^3)
Vn=-1*((K*T)/q)*log(Nd/Nc)
#We obtain Bp and qVpi
qVbip=qm-qx-abs(Vn) #this is for a n dopped material with Vn is possitive
Bp=qm-qx # Height of the contact #donors close to the Ec

###############################################
#Calculation for Ti-n-GaAs 5*1e17
disp("#########################")
disp("Calculation for Ti-n-GaAs 5*1e17")

#FROM THE METAL
qm=4.33 #Work function Al

#FROM THE SEMICONDUCTOR
#For Si
qx=4.07 #Electron Affinity of GaAs qx=Evacum-Ec
Eg=1.42#Gap Energy Si
me=0.067 #Effective mass for conductivity calculation in Silicon me*/mo 
Nd= 5*1e17 #Doping type n
Nc= 4.4*1e17#Silicon effective density of states


#For a n dopped material 

#We calculate Nd p material
mn=mo*me
  #a=(2*pi*mn*K*T)^3
  #b=sqrt(a)
  #c=h^3
  #d=12*b/c
#Nc=12*sqrt((2*pi*mn*K*T)^3)/(h^3)
Vn=-1*((K*T)/q)*log(Nd/Nc)
disp("break point")
#We obtain Bp
qVbin=qm-qx-Vn #this is for a n dopped material with Vn is possitive
Bp=qm-qx # Height of the contact #donors close to the Ec

