function  SA = specAccEC8(T,q,S,Tb,Tc,Td,ag,b)
%
% #SA# = specAccEC8(#T#,#q#,#S#,#Tb#,#Tc#,#Td#,#ag#,#b#)
%     Calculation of PSA according to EC8-1[3.2.2.5(4)P]
%
% Input parameters
%     #T# ([#n# x 1]): period vector
%     #q# (scalar): behavior factor
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
% Output parameters
%     #SA# ([#n# x 1]): spectral acceleration
%
% Example:
%     T=(0.04:0.04:4)'
%     q=3;
%     GroundType='A';
%     SeismicZone=1;
%     ImportanceFactor=1;
%     [S,Tb,Tc,Td,ag,b]=paramEC8(GroundType,SeismicZone,ImportanceFactor);
%     SA = specAccEC8(T,q,S,Tb,Tc,Td,ag,b);
%     plot(T,SA)
%
%__________________________________________________________________________
% Copyright (c) 2018
%     George Papazafeiropoulos
%     Captain, Infrastructure Engineer, Hellenic Air Force
%     Civil Engineer, M.Sc., Ph.D. candidate, NTUA
%     Email: gpapazafeiropoulos@yahoo.gr
% _________________________________________________________________________


T1= 0<=T & T<=Tb;
SA(T1)=ag.*S.*(2/3+T(T1)./Tb.*(2.5./q-2/3));
T2= Tb<=T & T<=Tc;
SA(T2)=ag.*S.*2.5./q;
T3= Tc<=T & T<=Td;
SA(T3)=max(ag.*S.*2.5./q.*Tc./T(T3),b.*ag);
T4= Td<=T;
SA(T4)=max(ag.*S.*2.5./q.*Tc.*Td./T(T4).^2,b.*ag);
SA=SA';
end
    