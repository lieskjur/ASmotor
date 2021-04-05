addpath('Mereni')
SamplT=0.002;   %[s]
% Syrove char.
rb1.om = table2array(readtable('Mereni/Rozbeh1CH1.CSV','range',[19,4]))' .* [1;80/1000*30/pi];
rb1.i_1 = table2array(readtable('Mereni/Rozbeh1CH2.CSV','range',[19,4]))' .* [1;11/(1.085)]; % 11A/1.085V; ef hodnota
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
in=find(mer.t>mer.t_0 & mer.t<mer.t_f);

%obalky
i_1=mer.i_1(in);
[pks,locs] = findpeaks(i_1,mer.t(in));

%efektivni proud
i_ef_pks=pks./sqrt(2);

%prevzorkovani primkami
% tq=mer.t_0:SamplT:mer.t_f;
i_ef = interp1(locs,i_ef_pks,mer.t(in));


% Vizualizace
figure; hold on; %>>
xline(mer.t_0,'r');xline(mer.t_f,'r')
yyaxis left
plot(mer.t,mer.om)
yyaxis right
plot(mer.t,mer.i_1) 
hold off%<<
figure
hold on
plot(mer.t(in),i_1)
plot(locs,pks)
plot(locs,i_ef_pks,'.')
plot(mer.t(in),i_ef,'.')

%export dat
mer.t=mer.t(in);
mer.om=mer.om(in);
mer.i_ef=i_ef;

figure
plot(mer.t,mer.om./50,mer.t,mer.i_ef)

% Ulozeni
save('RozbehChar.mat','-struct','mer')