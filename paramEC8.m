function [S,Tb,Tc,Td,ag,b]=paramEC8(GroundType,SeismicZone,ImportanceFactor)
%
% [#S#,#Tb#,#Tc#,#Td#,#ag#,#b#]=paramEC8(#GroundType#,#SeismicZone#,...
%     #ImportanceFactor#)
%     Calculation of the properties of the Type 1 design response spectrum
%     of EC8. The values are taken from Table 3.2 and Figure 3.2 of
%     EC8-1[3.2.2.2(2)P]
%
% Input parameters
%     #GroundType# (scalar string) is type of the ground type. Possible
%         values are: 'A', 'B', 'C', 'D', 'E'.
%     #SeismicZone# (scalar integer) is the seismic zone. Possible
%         values are: 1, 2, 3.
%     #ImportanceFactor# (scalar double) is the importance factor.
%
% Output parameters
%     #S# (scalar): soil factor
%     #Tb# (scalar): lower limit of the period of the constant spectral
%         acceleration branch 
%     #Tc# (scalar): upper linlit of the period of the constant spectral
%         acceleration branch 
%     #Td# (scalar): value defining the beginning of the constant
%         displacement response range of the spectrum
%     #ag# (scalar): design ground acceleration on type A ground
%     #b# (scalar): lower bound factor for the horizontal design spectrum
%
% Example:
%     q=3; % behavior factor
%     GroundType='A';
%     SeismicZone=1;
%     ImportanceFactor=1;
%     [S,Tb,Tc,Td,ag,b]=paramEC8(GroundType,SeismicZone,ImportanceFactor)
%
%__________________________________________________________________________
% Copyright (c) 2018
%     George Papazafeiropoulos
%     Captain, Infrastructure Engineer, Hellenic Air Force
%     Civil Engineer, M.Sc., Ph.D. candidate, NTUA
%     Email: gpapazafeiropoulos@yahoo.gr
% _________________________________________________________________________


% Calculate S,Tb,Tc,Td according to ground type
switch GroundType
    case 'A'
        S=1;
        Tb=0.15;
        Tc=0.4;
    case 'B'
        S=1.2;
        Tb=0.15;
        Tc=0.5;
    case 'C'
        S=1.15;
        Tb=0.2;
        Tc=0.6;
    case 'D'
        S=1.35;
        Tb=0.2;
        Tc=0.8;
    case 'E'
        S=1.4;
        Tb=0.15;
        Tc=0.5;
end
Td=2; % alternatively, according to national annex (Td=2.5)
% agRHor: reference peak ground acceleration on type A ground
switch SeismicZone
    case 1
        agR=0.16*9.81; % seismic zone I
    case 2
        agR=0.24*9.81; % seismic zone II
    case 3
        agR=0.32*9.81; % seismic zone III
end
% Importance class & Importance factor (given in EC8-1[4.2.5(4)]
ag=ImportanceFactor*agR; % EC8-1[3.2.1(3)]
b=0.2; % EC8-1[3.2.2.5(4)P-NOTE]

end

