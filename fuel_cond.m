function [kf]=fuel_cond(Tf,d,Bu)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function calculates the thermal conductivity of the fuel as 
% presented in Eq. 2.3-9 and 2.3-11 of PNNL-19417 (NUREG/CR-7024)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
%
% Tf= temperature of the fuel [K]
% d=  as-fabricated density of the fuel as a fraction (i.e. 88% dense fuel 
%     would be inputed as 0.88)
% Bu= burnup [GWd/MTU]
%
% Temperature must be inputed.  However, as a default as-fabricated fuel 
% density is 100% (d=1) and no burnup (Bu=0) if no input is provided.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
%
% k= fuel thermal conductivity [W/m-K]
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Created by R. Romatoski 10/18/2011
% Last modified:
%       10/18/2011- R. Romatoski
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Sets the default value for density and burnup if none is provided.
if (nargin==1)
    d=1;
    Bu=0;
end
% Sets the default value for burnup if none is provided.
if (nargin==2)
    Bu=0;
end

% Need to add code error if input values are not valide (i.e. d > 1 and
% burnup > 0


% Define the fuel conductivity constants
A=0.0452;      % m-K/W
B=2.46*10^-4;  % m-K/W/K
C=5.47*10^-9;  % W/m-K^3
D=2.29*10^-14; % W/m-K^5
E=3.5*10^9;    % W-K/m
F=16361;       % K

% Calculate the effect of fission products in crystal matrix (solution)
f=0.00187*Bu;  % GWd/MTU

% Calculate the effect of irradiation defects
g=0.038*Bu^0.28;

% Calculate temperature dependence of annealing  on irradiation defects
Q=6380;        % K
h=1/(1+396*exp(-Q/Tf));

% Calculate fuel conductivity for 95% as-fabricated density
k95=(1/(A+B*Tf+f+g*h))-C*Tf^2+D*Tf^4; % W/m-K

% Calculate fuel conductivity for any density
kf=1.0789*k95*(d/(1+0.5*(1-d))); % W/m-K