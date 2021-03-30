% Teoreticke hodnoty parametru
teor = load('TeorParam.mat')

% Namerene rozbehove char.
mer = load('RozbehChar.mat')

% Podminky simulace
podm.Umax = 124; %V
podm.f = 50; %Hz
podm.t = [mer.t_0,mer.t_f];

% Limity optimalizace
fn = fieldnames(meas)
for i = 1:numel(fn)
	delta.Min(i) = -meas.(fn{i})*0.6;
	delta.Max(i) = meas.(fn{i})*0.6;
end

% Cost funkce
C = @(delta) Cost(teor,mer,podm,delta);

% Pred optimalizaci
[~,~] = SimFun(teor,mer,podm,zeros(numel(fn),1),true);

% Optimalizace
disp('zacina ga optimalizace, cas:')
starttime=clock;
disp([num2str(starttime(4)),':',num2str(starttime(5))]);

options = optimoptions('ga','MaxTime',3600*5);
[Optim.Delta,Optim.Cost] = ga(C,numel(fn),[],[],[],[],delta.Min,delta.Max,[],options);

save results

disp('konec ga optimalizace, cas:')
stoptime=clock;
disp([num2str(stoptime(4)),':',num2str(stoptime(5))]);

% Po optimalizaci
[~,Optim.Param] = SimFun(teor,mer,podm,delta.Opt,true);
