function [k]=gap_cond(T,x)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function calculates the thermal conductivity of the fuel-clad 
% gap as presented in Eq. 4.1-1, 4.1-4, 4.1-5, 4.1-6, and Table 4.1-2
% in NUREG/CR-7024
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs
%
% T= average gap temperature[K]
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
% k= gap thermal conductivity [W/m-K]
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Created by A. Mieloszyk 10/14/2011
% Last modified:
%       10/14/2011- A. Mieloszyk
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define the individual gas conductivity constants
A=[2.639e-3,2.986e-4,8.247e-5,4.351e-5,1.097e-3,5.314e-4];
B=[0.7085,0.7224,0.8363,0.8616,0.8785,0.6898];

% Define the molecular mass of each gas
M=[4.0,39.9,83.8,131.3,2.0,28.0];

k_g=zeros(1,6);

% Define each gas's thermal conductivity 
for i=1:6
    k_g(i)=A(i)*T^B(i);
end

% Initialize k
k=0.0;

for i=1:6
    
    %Reset sum value
    sum=0.0;
    
    for j=1:6
        
        phi=(1.0+(k_g(i)/k_g(j))^0.5*(M(i)/M(j))^0.25)^2.0;
        phi=phi/(2.0^1.5*(1.0+(M(i)/M(j))^0.5));
        
        psi=(M(i)-M(j))*(M(i)-0.142*M(j))/(M(i)+M(j))^2.0;
        psi=phi*(1.0+2.41*psi);
        
        % Delta function
        if j==i
            delt=1.0;
        else
            delt=0.0;
        end
        
        sum=sum+(1.0-delt)*psi*x(j);
        
    end
    
    % Gas mixture conductivity
    k=k+k_g(i)*x(i)/(x(i)+sum);            %[W/m-K]
    
end


