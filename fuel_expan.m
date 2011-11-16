function [dLf]=fuel_expan(T,f)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function calculates the thermal expansion of the fuel as a function
% of temperature, fraction of PuO2, and the fraction of the fuel which is
% molten as described in 2.5-1. 2.5-2, and 2.5-3 of PNNL19417
% (NUREG/CR-7024)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
%
% T = temperature of the fuel [K]
% f = fraction of PuO2
%
% Temperature must be inputed.  However, as a default the fraction of PuO2
% is zero (f=0) and the fraction of molten fuel is zero (fm=0) if no input
% is provided.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
%
% dLf= thermal expansion strain of fuel (i.e. fractional length change)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Created by R. Romatoski 10/18/2011
% Last modified:
%       10/18/2011- R. Romatoski
% Note:
% Still needs to incorporate limits on temperature and molten fuel
% correlations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Sets the default value for fraction of PuO2 and molten fuel.
if (nargin==1)
    f=0;
end

% Need to add code error if input values are not valid 

% Set Boltzmann's constant k
k=1.38*10^-23; % J/K

% Define the constants matrix for UO2 and PuO2
K1=[9.80*10^-6 9.0*10^-6];    % K^-1
K2=[2.61*10^-3 2.7*10^-3];   % unitless
K3=[3.16*10^-1 7.0*10^-2];    % unitless
Ed=[1.32*10^-19 7.0*10^-20];  % J

% Works only for T<T melting (1400K)
if (T>1400)
    dLf=NaN; 
else
% Calculate dL
dLf=(K1(1)*T-K2(1)+K3(1)*exp(-Ed(1)/(k*T)))*(1-f)+(K1(2)*T-K2(2)+K3(2)*exp(-Ed(2)/(k*T)))*f;
end