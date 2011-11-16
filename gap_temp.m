function [Tfo]=gap_temp(Tci,rfo,rci,x,PP,q,cont_flg)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function calculates the fuel surface temperature
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
%
% Tci= cladding inner radius temperature [K]
% rfo= fuel outer radius [m]
% rci= cladding inner radius [m]
% x= molar fraction of gap gases (should sum to 1.0) [-]
%	x(1)=> He
%	x(2)=> Ar
%	x(3)=> Kr
%	x(4)=> Xe
%	x(5)=> H2
%	x(6)=> N2
% PP= plenum pressure [Pa]
% q= linear heat rate [W/m]
% cont_flg= contact flag [-]
%   1= pellet-cladding contact
%   0= no pellet-cladding contact
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs
%
% Tfo= new fuel outer radius temperature [K]
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Created by A. Mieloszyk 11/2/2011
% Last modified:
%       11/2/2011- A. Mieloszyk
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Average gap heat flux
q_dp=q*(rci-rfo)/(pi*(rci^2-rfo^2));                %[W/m^2]

%First guess for the fuel surface temperature
Tfo=Tci+100;                                        %[K]

%Initialize convergence flag and Tfo_old
conv_flg=0;

while conv_flg==0
    
    %Store previous fuel surface temperature
    Tfo_old=Tfo;                                    %[K]
    
    %Approximate gap gas temperature as averge between Tci and Tfo
    Tg=(Tfo+Tci)/2.0;                               %[K]
    
    %Gap gas heat transfer coefficient
    [h_g]=h_gas(rfo,rci,Tg,PP,x);                   %[W/m^2-K]
    
    %Radiative heat transfer coefficient
    [h_r]=h_rad(Tfo,Tci,rfo,rci);                   %[W/m^2-K]
    
    %Solid contact heat transfer
    if cont_flg==1
        [h_s]=h_solid(k_f,k_c);                     %[W/m^2-K]
    else
        h_s=0.0;                                    %[W/m^2-K]
    end
    
    %Sum heat transfer coefficients
    h=h_r+h_g+h_s;                                  %[W/m^2-K]
    
    %Find new surface temperature
    Tfo=q_dp/h+Tci;                                 %[K]
    
    %Check for convergence
    err=abs(Tfo-Tfo_old)/Tfo_old;
    
    if err<=1e-3
        %Converged w/i 0.1%
        conv_flg=1;
    end
end




