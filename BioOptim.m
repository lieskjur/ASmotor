% Teoreticke hodnoty parametru
teor = load('TeorParam.mat')
% Namerene rozbehove char.
mer = load('RozbehChar.mat')
% Podminky simulace
podm.Umax = 124; %V
podm.f = 50; %Hz
podm.t = [mer.t_0,mer.t_f]

OPT = @(delta) OptFun(teor,mer,podm,delta)