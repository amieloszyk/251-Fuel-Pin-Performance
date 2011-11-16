function [DeltaL,DeltaLInc] = Dense_Func(Bu,po,T,TSINTR,B1,DeltaL)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function calculates the dimensional changes due to densification
% of UO2 and MOX during the first few hours of water reactor operation.
% This function uses Eqn. 2.6-4 , 2.6-5, and 2.6-6 from PNNL-19417.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
%
% T= average fuel temperature [K]
% Bu = Fuel Burnup [MWd/kgU]
% TSINTR = sintering temperature [K]
% po = initial UO2 density [kg/m^3]
% B1 = Fuel Densification Constant [Unitless]
% DeltaL = Total Densification at the preceeding Bu as % Dimensional 
%          Change  [m/m]
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
%
% DeltaL = Total Densification at the current Bu as % Dimensional 
%          Change  [m/m]
% DeltaLInc = Incremental Densification at from Bu1 to Bu2 as % 
%             Dimensional Change
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Created by E. Fray 10/19/2011
% Last modified:
%       10/20/2011- E. Fray
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Initialize Variables

DeltaLmax = 0;             % Maximum Possible Dimension Change % (m/m)
                           % due to Irradiation
DeltaL1 = DeltaL;          % Dimensional Change in % at previous Bu
DeltaL2 = 0;               % Dimensional Change in % at current Bu
pt = 10.97;                % Theoretical density of the fuel (kg/m^3)

% Calculate the maximum % Dimensional Change DeltaLmax (m/m) at TSINTR
if(Bu > 0)

    if(TSINTR <= 1453)
        DeltaL2 = 0;
    else
        if(T < 1000)
            DeltaLmax = (-22.2*(100-(100*po/pt)))/(TSINTR-1453);
        else
            DeltaLmax = (-66.6*(100-(100*po/pt)))/(TSINTR-1453);
        end

% Calculates the % Dimensional Change due to Densification at a Bu = XX
% The temperature must be less greater than 0 K and less than the melting
% point of the fuel
% The burnup also must be greater than the (B1) Fuel Densification Constant

        if((0 <= T <= 3140)&&(Bu > abs(B1)))
            DeltaL2 = DeltaLmax + exp(-3*(Bu + B1)) + 2*exp(-35*(Bu + B1));
        else
            disp('Error the minimum burnup input (Bu) is too low')
            disp('&/or the temperature (T) is out of range')
        end
        
% Calculates the Incremental Densification between the current burnup and
% the burnup in the previous time-step

    DeltaLInc = DeltaL2 - DeltaL1;
    
% Resets the Total Densification from the preious Bu to the current Bu
    
    DeltaL = DeltaL2;

    end

else
    
    DeltaL = 0;
    DeltaLInc = 0;
    
end

end


