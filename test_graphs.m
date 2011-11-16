clear x;
clear k;
clear all;
clf;
i=0;
for T=301:1:3000
    i=i+1;
    x(i)=T;
    kf(i)=fuel_cond(T,0.95,0);
    dLU(i)=fuel_expan(T,0);
    dLPu(i)=fuel_expan(T,1);
    kc(i)=clad_cond(T);
    [ea(i),ed(i)]=clad_expan(T);
end
figure(1)
plot(x,kf)
title('Modified NFI model Fuel Conductivity')
xlabel('Temperature (K)')
ylabel('Fuel Conductivity (W/m-K)')
axis([0 3000 0 10])
figure(2)
plot(x,dLU)
hold on
plot(x,dLPu,'g')
title('Thermal Expansion of Fuel')
xlabel('Temperature (K)')
ylabel('Fractional Length Change')
axis([0 1600 0 0.012])
figure(3)
plot(x,kc)
title('Clad Conductivity (W/m-K)')
figure(4)
plot(x,ea)
hold on
plot(x,ed,'g')
axis([200 1800 0 1.0*10^-2])
title('Thermal Expansion of Clad')
xlabel('Temperature (K)')
ylabel('Thermal Expansion (m/m)')