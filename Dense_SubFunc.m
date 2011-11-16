function [B1,DeltaL] = Dense_SubFunc(Bu,po,To,TSINTR)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is the sub-function for Dense_Func(Bu,T,po,To,TSINTR).  Dense_Func
% calculates the dimensional changes due to densification of UO2 and
% MOX during the first few hours of water reactor operation.
% This function is the sub-function for Eqn. 2.6-6 from PNNL-19417.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
%
% Bu = Fuel Burnup [MWd/kgU]
% TSINTR = sintering temperature [K]
% po = initial UO2 density [kg/m^3]
% To = initial fuel temperature [K]
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
%
% B1 = Fuel Densification Constant [Unitless]
% DeltaL = Total Densification at the Bu=0 as % Dimensional 
%          Change  [m/m]
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Created by E. Fray 10/20/2011
% Last modified:
%       10/20/2011- E. Fray
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Initialize Variables    

DeltaLmaxo = 0;             % Maximum Possible Dimension Change % (m/m)
                            % due to Irradiation
pt = 10.97;                 % Theoretical density of the fuel (kg/m^3)

% Determine the Fuel Densification Function Constant (B1) at Bu=0

if (Bu==0)
    
    if(TSINTR <= 1453)
        DeltaL = 0;
        disp('Error the sintering temperature is too low')
    else
        DeltaL = 0;
        if(To < 1000)
                DeltaLmaxo = (-22.2*(100-(100*po/pt)))/(TSINTR-1453);
                    if (DeltaLmaxo < 0)
                         B1=(log(-DeltaLmaxo))/(log(exp(-3)+2*exp(-35)));
                    end   
        else
                DeltaLmaxo = (-66.6*(100-(100*po/pt)))/(TSINTR-1453);
                    if (DeltaLmaxo < 0)
                         B1=(log(-DeltaLmaxo))/(log(exp(-3)+2*exp(-35)));
                    else
                        disp('Error po must be <= the theoretical density')
                    end  
        end
    end 
end

end


