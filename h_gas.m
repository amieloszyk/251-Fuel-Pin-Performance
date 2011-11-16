function [h_g]=h_gas(rfo,rci,T_g,P_g,x)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function calculates the gas heat transfer coefficient for the 
% fuel-cladding gap
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
%
% rfo= fuel outer radius [m]
% rci= cladding inner radius [m]
% T_g= gas temperature [K]
% P_g= gas pressure [Pa]
% x= molar fraction of gap gases (should sum to 1.0) [-]
%	x(1)=> He
%	x(2)=> Ar
%	x(3)=> Kr
%	x(4)=> Xe
%	x(5)=> H2
%	x(6)=> N2
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
%
% h_g= gap gas heat transfer coefficient [W/m^2-K]
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Created by A. Mieloszyk 11/1/2011
% Last modified:
%       11/1/2011- A. Mieloszyk
%       11/7/2011- A. Mieloszyk: Modified units problem w/ jump condition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define the molecular mass of each gas
M=[4.0,39.9,83.8,131.3,2.0,28.0];       %[amu]

%Gas thermal conductivity
[k_g]=gap_cond(T_g,x);                  %[W/m-K]

% Define the accomodation coefficient of each gas (See BNWL-1894)
a=zeros(1,6);

% Helium
a_He=0.425-2.3e-4*T_g;
% Xenon
a_Xe=0.749-2.5e-4*T_g;

sum=0.0;

for i=1:6 
    
    %Linear interpolation for the rest based on molecular mass
    a=a_He+(a_Xe-a_He)/(M(4)-M(1))*(M(i)-M(1));
    
    %While in the loop, sum gas factors
    sum=sum+a*x(i)/sqrt(M(i));
    
end

%Jump distance
jump=0.7816*k_g*sqrt(T_g)/P_g/sum;      %[cm]
jump=jump/100;                          %[cm]=>[m]

%d_eff will be the combined roughness w/o contact consideration (~10um)
d_eff=10.0e-6;                          %[m]

b=1.397e-6;                             %[m]

gap_eff=d_eff+1.8*jump-b+rci-rfo;       %[m]

h_g=k_g/gap_eff;                        %[W/m^2-K]







