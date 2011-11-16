function [dG]=relocation(LHGR,Bu)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function calculates the gap change as a percent of the
% as-fabricated gap based on the linear heat generation rate and burnup as
% described in the FRAPCON 3-4 Vol.1 Manual Section 2.4.1.3.4.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
%
% LHGR = nodal linear heat generation rate (kW/m)
% Bu   = burnup [GWd/MTU]
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
%
% dG = gap change as percentage of as-fabricated gap size
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Created by R. Romatoski 11/07/2011
% Last modified:
%       11/07/2011- R. Romatoski
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculate needed FBU and PFACTOR based on inputs

% FBU for burnup less than 5 GWd/MTU
if(Bu<5)
    FBU=Bu/5;
else 
% FBU for burnup greater than or equal to 5
    FBU=1.0;
end

% PFACTOR
PFACTOR=(LHGR-20)*5/20;

% Calculate change in gap size for LGHR less than 20 kW/m
if(LHGR<20)
    dG=30+10*FBU;
% Calculate change in gap size for LGHR greater than 40 kW/m
else if (LHGR>40)
    dG=32+18*FBU;
% Calculate change in gap size for LGHR of 20-40 kW/m
    else
        dG=28+PFACTOR+(12+PFACTOR)*FBU;
    end
end