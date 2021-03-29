addpath('Mereni')
addpath('fittingTools')

% Dobeh
DB = table2array(readtable('Mereni/Dobeh.CSV','range',[19,4]));
[~,dwdt] = fitLin(-24.62,[],DB(:,1),DB(:,2),true);
r = 256e-3; %m
G = 1860e-3*9.81; %N
teor.M_B = r*G;
teor.J = 1/(dwdt*M_B)

% Naprazdno a nakratko
NP = table2cell(readtable('mereni_AS_motor.xlsx','range','B21:C24')); NP_T = NP';
np = struct(NP_T{:});
NK = table2cell(read;table('mereni_AS_motor.xlsx','range','E21:F24')); NK_T = NK';
nk = struct(NK_T{:});

% Odpory vinutí
R1 = 0.888;
R2 = 0.191;
p12 = 0.46;

save('TeorParam.mat','-struct','teor')