addpath('Mereni')
addpath('fittingTools')

%Parametry z ESP:
%   ze stitku
pp=2;
%   naprazdno
U0f=220;
I0=5.35;
alfa0=31;
kW0=4;
P0_1f=kW0*alfa0;
S0_1f=U0f*I0;
Q0_1f=sqrt(S0_1f^2-P0_1f^2);
cos_fi0=P0_1f/S0_1f;
%   nakratko
Ukf=58;
Ik=9.9;
alfak=74;
kWk=4;
Pk_1f=alfak*kWk;
Sk_1f=Ukf*Ik;
cos_fik=Pk_1f/Sk_1f;
%   odpory
R1=0.888;
R2=0.191;
p=R1/R2;
%   vypocet parametru z mereni naprazdno
Lh=((U0f)^2)/(2*pi*50*sqrt((S0_1f)^2-(P0_1f)^2));
% Lh=(U0f)/(2*pi*50*I0*sqrt(1-cos_fi0^2));  %dava stejny vysledek
%   vypocet parametru z mereni nakratko
Zk=Ukf/Ik;
L_1sig=(Zk*sqrt(1-(cos_fik)^2))/(2*2*pi*50);
% L_1sig=L_2sig'
L_2sig=L_1sig/p^2;
%   prepocet pro nas model
L1=Lh+L_1sig;
L2=Lh+L_2sig;
L=Lh-(L1*L2)/Lh;
%zapis
teor.L1=L1;
teor.L2=L2;
teor.Lh=Lh;
teor.R1=R1;
teor.R2=R2; 
teor.pp=pp;

% Dobeh
DB = table2array(readtable('Mereni/Dobeh.CSV','range',[19,4]));
[~,dwdt] = fitLin(-24.62,[],DB(:,1),DB(:,2),false);
r = 265e-3; %m
G = 1860e-3*9.81; %N
teor.M_B = r*G;
teor.J = -1/(dwdt*teor.M_B);

save('TeorParam.mat','-struct','teor')