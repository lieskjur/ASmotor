addpath('Mereni')
addpath('fittingTools')

%Parametry z ESP:
%   ze stitku
pp=1;
%   naprazdno
U0f=220;
I0=5.35;
alfa0=31;
kW0=4;
P0_1f=kW0*alfa0;
S0_1f=U0f*I0;
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
R1=2;
R2=4;
p=R1/R2;
%   vypocet parametru z mereni naprazdno
Lh=0.3;
% Lh=(U0f)/(2*pi*50*I0*sqrt(1-cos_fi0^2));  %dava stejny vysledek
%   vypocet parametru z mereni nakratko
Zk=Ukf/Ik;
L_1sig=0.02;
% L_1sig=L_2sig'
L_2sig=0.02;
%   prepocet pro nas model
L1=Lh+L_1sig;
L2=Lh+L_2sig;
L=Lh-(L1*L2)/Lh;
%zapis
teor.L1=0.139616;
teor.L2=0.131996;
teor.Lh=0.131626;
teor.R1=0.191;
teor.R2=0.888; 
teor.pp=2;

% Dobeh
DB = table2array(readtable('Mereni/Dobeh.CSV','range',[19,4]));
[~,dwdt] = fitLin(-24.62,[],DB(:,1),DB(:,2),true);
r = 256e-3; %m
G = 1860e-3*9.81; %N
% teor.M_B = r*G;
teor.M_B=4.3;
% teor.J = abs(1/(dwdt*teor.M_B));
teor.J = 8;

% % Naprazdno a nakratko
% NP = table2cell(readtable('mereni_AS_motor.xlsx','range','B21:C24')); NP_T = NP';
% np = struct(NP_T{:});
% NK = table2cell(readtable('mereni_AS_motor.xlsx','range','E21:F24')); NK_T = NK';
% nk = struct(NK_T{:});


save('TeorParam.mat','-struct','teor')