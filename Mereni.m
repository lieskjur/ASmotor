addpath('Mereni')
addpath('fittingTools')

% Dobeh
DB = table2array(readtable('Mereni/Dobeh.CSV','range',[19,4]));
[~,a1] = fitLin(-24.62,[],DB(:,1),DB(:,2),true);

% Zatezovani
rozsahy = ["A3:F13","J3:O6","J10:O14"];
for i = 1:numel(rozsahy) 
	Z = table2array(readtable('mereni_AS_motor.xlsx','range',rozsahy(i)));
	z{i}.M = Z(:,1);
	z{i}.om = 80/1000*30/pi*Z(:,2);
	z{i}.I = Z(:,3);
	z{i}.U = Z(:,4);
	z{i}.alfa = Z(:,5);
	z{i}.kW = Z(:,6);
end
z{1}.R2 = 0; %Ohm
z{2}.R2 = 0; %Ohm
z{3}.R2 = 0.67; %Ohm

% Naprazdno a nakratko
NP = table2cell(readtable('mereni_AS_motor.xlsx','range','B21:C24')); NP_T = NP';
np = struct(NP_T{:});
NK = table2cell(read;table('mereni_AS_motor.xlsx','range','E21:F24')); NK_T = NK';
nk = struct(NK_T{:});

% Odpory vinutí
R1 = 0.888;
R2 = 0.191;
p12 = 0.46;