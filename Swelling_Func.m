function [DeltaLSwell,DeltaLIncSwell] = Swelling_Func(Bu,T,p,DeltaLSwell,R,L)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function calculates the fuel swelling induced dimensional changes
% in the fuel due to the buildup of solid and gaseous fission products 
% during irradiation.  This function uses Eqn. 2.7-1 and Eqn. 2.7-2 from
% PNNL-19417.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
%
% T= average fuel temperature [K]
% Bu = Fuel Burnup [MWd/kgU]
% p = Fuel density (g/cm^3)
% R = Outer radius of the Fuel Pellet (m)
% L = Height of the Fuel Pellet (m)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
%
% DeltaLSwell = Total Densification at the current Bu as % Dimensional 
%               Change  [m/m]
% DeltaLIncSwell = Incremental Densification from Bu1 to Bu2 as % 
%                  Dimensional Change (m/m)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Created by E. Fray 10/21/2011
% Last modified:
%       11/5/2011- E. Fray
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Function used to convert the Bu input units from MWd/kg to fissions/m^3

% Initialize the Unit Conversion Array (Bu(Mwd/kg), Wd/MWd, po (kg/m^3),
% s/day, s/s, eV/J, MeV/eV, fission/Mev)

UC = [Bu,1E+6,(p*1000),86400,1,6.2415E+18,1E-6,5E-3];

% Convert the Burn-up units from MWd/kgU to fissions/m^3
Bs=1;

for(i=1:8)
    
    Bs=Bs*UC(i);

end



% Function used to calculate the fractional volume change due to fission
% product build-up (m^3 vol change/ m^3 fuel)at Bu = XX

Ss = (2.5E-29)*Bs;




% Function used to calculate the fractional volume change due to fission
% gas build-up (m^3 vol change/ m^3 fuel)at Bu = XX
if (T < 2800)
    Sg = (8.8E-56)*((2800-T)^11.73)*(exp(-0.0162*(2800-T)))...
        *(exp((-8E-27)*Bs))*Bs;
else
    Sg = 0;
end   





% Convert the Fractional Volume change (m^3 vol/m^3 fuel) to linear
% dimensional change DeltaLSwell % (m/m)

% Initialize Variables
St = Ss + Sg;                       % Total volumetric swelling
Zero = 1;                           % Constant
ZeroPrime = 1;                      % Constant
E1 = 0.001;                         % Incremental Change in Dimension (m)   

% Calculate the incremental change in dimension (E1) m during
% the burnup time-step

while ( abs(Zero) > 0.00001)% Converges when the uncertainty in E1 is within 10um
    Zero = ((R + E1)^2)*(L + E1) - ((R)^2)*L*(1 - St);
    ZeroPrime = 2*R*L + (R^2) + 4*E1*R + 2*L*E1 + 3*((E1)^2);
    E1 = E1 - Zero/ZeroPrime;
end


% Output the total densification and incremental densification
% as % dimensional change (m/m)

DeltaLSwell = (abs(E1)/L) + DeltaLSwell;
DeltaLIncSwell = abs(E1)/L;

end


