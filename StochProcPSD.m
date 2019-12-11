function [G,etaX] = StochProcPSD(PSa,omega,Ts,p,zeta,omega0,dOmega)
%
% One sided PSD and Peak Factor of a given pseudo-acceleration spectrum
%
% [G,etaX] = StochProcPSD(PSa,omega,Ts,p,zetai,omega0,dOmega)
%
% Description
%     This function calculates the one sided Power Spectral Density (PSD)
%     and Peak Factor (PF) of the stochastic response process Xi of an
%     elastic oscillator of frequency omega and damping ratio zeta. The PDF
%     and PF are consistent with a given pseudoacceleration spectrum PSa.
%     PSa can be any design spectrum, e.g. the design spectrum of EC8. The
%     methodology implemented is presented in the following paper:
%     Cacciola, P., Colajanni, P., & Muscolino, G. (2004). Combination of
%     modal responses consistent with seismic input representation. Journal
%     of Structural Engineering, 130(1), 47-55.
%     The methodology is also used for the response spectrum based
%     analysis of nonlinear and non-classically damped systems in the
%     following reference:
%     Mitseas, I. P., & Beer, M. (2019). Modal decomposition method for
%     response spectrum based analysis of nonlinear and non-classically
%     damped systems. Mechanical Systems and Signal Processing, 131,
%     469-485.
%
% Input parameters
%     #PSa# ([#n# x 1]) Linear elastic pseudo-acceleration response
%         spectrum
%     #omega# ([#n# x 1]) is the circular frequencies for the calculation
%         of the PSD and PF
%     #Ts# (scalar) is the duration of stationary seismic input.
%     #p# (scalar) is teh probability of outcrossing of the peak value.
%     #zeta# (scalar) is the modal damping ratio.
%     #omega0# (scalar) is the lowest circular frequency bound in order for
%         etaX to exist.
%     #dOmega# (scalar) is the integration step in the circular frequency
%         domain.
%
% Output parameters
%     #G# ([#n# x 1]) is the one sided Power Spectral Density (PSD).
%     #etaX# ([#n# x 1]) is the one sided Power Spectral Density (PSD).
%
%__________________________________________________________________________
% Copyright (c) 2019
%     George Papazafeiropoulos
%     Captain, Infrastructure Engineer, Hellenic Air Force
%     Civil Engineer, M.Sc., Ph.D. candidate, NTUA
%     Email: gpapazafeiropoulos@yahoo.gr
%__________________________________________________________________________


% Peak factor
n=numel(omega);
etaX=zeros(n,1);
for i=1:n
    % ith modal undamped natural circular frequency of structure
    omegai=omega(i);
    % mean zero crossing rate of response process Xi
    NXi=Ts/2/pi*omegai*(1/(-log(p)));
    % spread factor of response process Xi
    deltaXi=sqrt(1-1/(1-zeta^2)*(1-2/pi*atan(zeta/sqrt(1-zeta^2)))^2);
    % peak factor of Xi process
    etaX(i)=sqrt(2*log(2*NXi*(1-exp(-deltaXi^1.2*sqrt(pi*log(2*NXi))))));
end
% One-sided Power Spectral Density of ground acceleration
G=0;
for i=2:n
    if omega(i)<omega0
        G=[G;0];
    else
        G=[G;4*zeta/(omega(i)*pi-4*zeta*omega(i-1))*(PSa(i)^2/etaX(i)^2-...
            dOmega*sum(G))];
    end
end
end

