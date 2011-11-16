function [Tf,Tf_ave]=fuel_temp(Tfo,n,r,kf,Pow,q)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function calculates the fuel temperature profile
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
%
% Tfo= new fuel outer radius temperature [K]
% n= # of fuel rings [-]
% r= fuel ring radii [m]
%   r(1)= inner void radius
%   r(n+1)= fuel outer radius
% kf= conductivity of the fuel in each ring [W/m-K]
% Pow= radial power factors (normalized to average)
% q= average linear heat generation rate [W/m]
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
%
% Tf= temperature at each fuel ring boundary [K]
%   Tf(1)= centline temp 
%   Tf(n+1)= Tfo
% Tf_ave= average temperature in each fuel ring [K]
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Created by A. Mieloszyk 11/15/2011
% Last modified:
%       11/15/2011- A. Mieloszyk
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Average volumetric heat generation
q_tp=q/pi/r(n+1)^2;                                             %[W/m^3]

%Find heat flux at each boundary
q_dp=zeros(1,n+1);                                              %[W/m^2]

for i=2:n+1
    q_dp(i)=q_dp(i-1)*r(i-1)/r(i);
    q_dp(i)=q_dp(i)+q_tp*Pow(i-1)*(r(i)^2-r(i-1)^2)/(2.0*r(i)); %[W/m^2]
end

%Find fuel ring temperatures
Tf=zeros(1,n+1);                                                %[K]
Tf(n+1)=Tfo;                                                    %[K]
Tf_ave=zeros(1,n);                                              %[K]

for i=n:-1:1
    
    Tf(i)=q_tp*Pow(i)/2*(r(i)^2*log(r(i+1)/r(i))-(r(i+1)^2-r(i)^2)/2);
    Tf(i)=Tf(i)-q_dp(i)*r(i)*log(r(i+1)/r(i));
    Tf(i)=Tf(i+1)-Tf(i)/kf(i);                                  %[K]
    
    Tf_ave(i)=2*trapz(r(i:i+1),Tf(i:i+1).*r(i:i+1));
    Tf_ave(i)=Tf_ave(i)/(r(i+1)^2-r(i)^2);                      %[K]
    
end













