%% Verification
% Seismic codes allow ground motion representation by means of artificial
% accelerograms generated as parts of finite duration Ts of samples of a
% stationary process, characterized by a PSD consistent with the assigned
% elastic response spectrum.
%
% In this script the following steps are
% implemented:
% 
% # The design pseudo-acceleration response spectrum of EC8 is calculated
% (EC8Sa)
% # The one-sided Power Spectral Density (PSD) and Peak Factor (PF) of
% EC8Sa are calculated
% # An artificial acceleration time history (ug) is generated based on
% the above PSD
% # The pseudo-acceleration response spectrum of ug (PSa) is calculated
% and it is verified that PSa and EC8Sa are close to each other.

%% Initial input
% Duration of stationary seismic input (sec)
Ts=20;
%%
% Probability of outcrossing of peak value
p=0.5;
%%
% Modal damping ratio
zeta=0.05;
%%
% Cut-off frequency (rad/s)
omegaC= 100;
%%
% Integration step (rad/s)
dOmega=0.1;
%%
% Lowest bound of the existence domain of etaXi (rad/s)
omega0=0.36;

%% Normalized design pseudo-acceleration response spectrum of EC8
% Circular frequency range
omega=(omega0+dOmega/2:dOmega:omegaC)';
%%
% Eigenperiod range for which the response spectrum will be calculated.
Tspectra=2*pi./omega;
%%
% Selection of spectrum parameters
q=3;
GroundType='A';
SeismicZone=1;
ImportanceFactor=1;
%%
% Calculation
[S,Tb,Tc,Td,ag,b]=paramEC8(GroundType,SeismicZone,ImportanceFactor);
EC8Sa = 2*specAccEC8(Tspectra,q,S,Tb,Tc,Td,ag,b);

%% One sided PSD and Peak Factor
% Calculation
[G,etaX] = StochProcPSD(EC8Sa,omega,Ts,p,zeta,omega0,dOmega);
%%
% Plot and compare with Figure 1(a) of Cacciola et al. (2004), PFWN, soil
% type A
figure(1)
plot(omega(omega>4),G(omega>4))

%% Artificial acceleration time history
% Selection of time step
dt=0.02;
%%
% Calculation
[ug,t] = AccTHfromPSD(G,dt,Ts,dOmega);
%%
% Plot
figure(2)
plot(t,ug)

%% Verification of elastic pseudo-acceleration response spectra
% Calculation with OpenSeismoMatlab (Papazafeiropoulos & Plevris, 2018).
% Open source code OpenSeismoMatlab is available for free download at the
% following link:
% <https://www.mathworks.com/matlabcentral/fileexchange/67069-openseismomatlab>
param=OpenSeismoMatlab(dt,ug,'ES',true,[],zeta,Tspectra);
PSa=param.PSa;
%% 
% Plot the two spectra and compare with each other.
figure(4)
plot(omega,EC8Sa)
hold on
plot(omega,PSa)
hold off
legend('Eurocode 8 target spectrum','PSa of artificial time history');



