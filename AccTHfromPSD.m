function [ug,t] = AccTHfromPSD(G,dt,Ts,dOmega)
%
% Acceleration time history from a one sided Power Spectral Density (PSD)
%
% ug = AccTHfromPSD(G,dt,Ts,dOmega)
%
% Description
%     This function calculates an acceleration time history that
%     corresponds to the given one sided Power Spectral Density (PSD). See
%     the function StochProcPSD.m for the calculation of PSD. 
%     The methodology is used for the response spectrum based analysis of
%     nonlinear and non-classically damped systems in the following
%     reference:
%     Mitseas, I. P., & Beer, M. (2019). Modal decomposition method for
%     response spectrum based analysis of nonlinear and non-classically
%     damped systems. Mechanical Systems and Signal Processing, 131,
%     469-485.
%
% Input parameters
%     #G# ([#n# x 1]) is the one sided Power Spectral Density (PSD) that is
%         calculated from the function StochProcPSD.m.
%     #dt# (scalar) is a time step arbitrarily selected for the computation
%         of the acceleration time history.
%     #Ts# (scalar) is the duration of stationary seismic input.
%     #dOmega# (scalar) is the integration step in the circular frequency
%         domain.
%
% Output parameters
%     #ug# ([#m# x 1]) is an acceleration time history corresponding to the
%         given one sided Power Spectral Density (PSD).
%
%__________________________________________________________________________
% Copyright (c) 2019
%     George Papazafeiropoulos
%     Captain, Infrastructure Engineer, Hellenic Air Force
%     Civil Engineer, M.Sc., Ph.D. candidate, NTUA
%     Email: gpapazafeiropoulos@yahoo.gr
%__________________________________________________________________________


t=(0:dt:Ts)';
n=numel(G);
m=size(t,1);
ug=zeros(m,1);
for i=1:n
    ug=ug+sqrt(2*G(i)*dOmega)*cos(i*dOmega*t+2*pi*rand);
end
end

