function [h_r]=h_rad(Tfo,Tci,rfo,rci)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function calculates the radiation heat transfer coefficient for the
% fuel-cladding gap
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
%
% Tfo= Fuel outer radius temperature [K]
% Tci= Cladding inner radius temperature [K]
% rfo= fuel outer radius [m]
% rci= cladding inner radius [m]
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
%
% h_r= gap radiative heat transfer coefficient [W/m^2-K]
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Created by A. Mieloszyk 11/1/2011
% Last modified:
%       11/1/2011- A. Mieloszyk
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Stefan-Boltzmann Constant (Royale is Boston's hottest club!)
sig=5.66978e-8;                     %[W/m^2-K^4]

%Fuel emissivity (Look this up!!!)
e_f=1.0;                            %[-]
%Cladding emissivity (Look this up!!!)
e_c=1.0;                            %[-]

F=(e_f+(rfo/rci)*(1/e_c-1))^-1;     %[-]

h_r=sig*F*(Tfo^2+Tci^2)*(Tfo+Tci);  %[W/m^2-K]
