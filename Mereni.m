addpath('Mereni')
addpath('fittingTools')

% Dobeh
DB = table2array(readtable('Mereni/Dobeh.CSV','range',[19,4]));
[~,dwdt] = fitLin(-24.62,[],DB(:,1),DB(:,2),true);
r = 256e-3; %m
G = 1860e-3; %kg
Mz = r*g
J = 1/(dwdt*Mz)

%% Rozbeh
U = 124;
%I_ef = 4.5; %A NEVYCHAZI
rb1.om = table2array(readtable('Mereni/Rozbeh1CH1.CSV','range',[19,4]))' .* [1;80/1000*30/pi];
rb1.i = table2array(readtable('Mereni/Rozbeh1CH2.CSV','range',[19,4]))' .* [1;11/(1.085*sqrt(2))]; % 11A/1.085V + ef hodnota
plot(rb1.om(1,:),rb1.om(2,:))
plot(rb1.i(1,:),rb1.i(2,:))

% Naprazdno
U0f = 220; %V
I0 = 5.35; %V

% Nakratko
Ukf = 58; %V
Ik = 9.9; %A

% Odpory vinutí
R1 = 0.888;
R2 = 0.191;
p12 = 0.46;