addpath('Mereni')
SamplT=0.002;   %[s]
% Syrove char.
rb1.om = table2array(readtable('Mereni/Rozbeh1CH1.CSV','range',[19,4]))' .* [1;1000/80*pi/30];
rb1.i_1 = table2array(readtable('Mereni/Rozbeh1CH2.CSV','range',[19,4]))' .* [1;11/1.085]; % 11A/1.085V; ef hodnota
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
mer.in = find(mer.t>=mer.t_0 & mer.t<=mer.t_f);

% Vyhlazeni dat
mer.i_ef = [mer.i_1(1:in(1)-1),movmean(mer.i_1(in),5),mer.i_1(in(end)+1:end)]

% Vizualizace
figure; hold on; %>>
xline(mer.t_0,'r');xline(mer.t_f,'r')
yyaxis left
plot(mer.t,mer.om)
yyaxis right
%plot(mer.t,mer.i_1)
plot(mer.t,mer.i_ef) 

% Ulozeni
save('RozbehChar.mat','-struct','mer')