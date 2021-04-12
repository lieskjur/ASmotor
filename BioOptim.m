close all;
% Teoreticke hodnoty parametru
teor = load('TeorParam.mat');
%teor = load('DemoParametry.mat'); %Chyskeho 230V motor

% Namerene rozbehove char.
mer = load('RozbehChar.mat');

% Podminky simulace
podm.Umax = sqrt(2)*124; %V
podm.f = 50; %Hz
podm.t = [mer.t_0,mer.t_f];

% Limity optimalizace
fn = fieldnames(teor);
for i = 1:numel(fn)
	delta.Min(i) = teor.(fn{i})*-0.6;
	delta.Max(i) = teor.(fn{i})*0.6;
end

% Cost funkce
C = @(delta) Cost(teor,mer,podm,delta);

% Pred optimalizaci
disp('pred optimalizaci')
[~,~] = SimFun(teor,mer,podm,zeros(numel(fn),1),true);

% Optimalizace
disp('zacina ga optimalizace, cas:')
starttime=clock;
disp([num2str(starttime(4)),':',num2str(starttime(5))]);

options = optimoptions('ga','MaxTime',60*5);
[Optim.Delta,Optim.Cost] = ga(@(delta) Cost(delta,teor,mer,podm),numel(fn),[],[],[],[],delta.Min,delta.Max,[],options);

save results

disp('konec ga optimalizace, cas:')
stoptime=clock;
disp([num2str(stoptime(4)),':',num2str(stoptime(5))]);

% Po optimalizaci
disp('po optimalizaci')
[~,Optim.Param] = SimFun(teor,mer,podm,delta.Opt,true);