addpath('Mereni')

% Syrove char.
rb1.om = table2array(readtable('Mereni/Rozbeh1CH1.CSV','range',[19,4]))' .* [1;80/1000*30/pi];
rb1.i_1 = table2array(readtable('Mereni/Rozbeh1CH2.CSV','range',[19,4]))' .* [1;11/(1.085*sqrt(2))]; % 11A/1.085V; ef hodnota
%I_ef = 4.5; %A NEVYCHAZI

% Formatovani char.
if isequal(rb1.om(1,:),rb1.i_1(1,:)) % Kontrola shody intervalu
	mer.t = rb1.om(1,:);
	mer.om = rb1.om(2,:);
	mer.i_1 = rb1.i_1(2,:);
end

% Casovy interval mereneho prechodu
mer.t_0 = 0.5;
mer.t_f = 4.75;

% Vizualizace
figure; hold on; %>>
xline(mer.t_0,'r');xline(mer.t_f,'r')
yyaxis left
plot(mer.t,mer.om)
yyaxis right
plot(mer.t,mer.i_1) %<<

% Ulozeni
save('RozbehChar.mat','-struct','mer')