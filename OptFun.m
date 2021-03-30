function [sim,param] = OptFun(teor,mer,podm,delta,plotORnot)
	if nargin < 5; plotORnot = false; end;

	% Uprava parametru
	pn = fieldnames(teor);
	for i = 1:numel(pn)
		param.(pn{i}) = teor.(pn{i})+delta(i);
	end

	% Simulace
	ODE_fun = @(t,y) ASmotor(param,podm,t,y);
	[T,Y] = ode45(ODE_fun,podm.t,zeros(5,1));
	for i = 1:length(T)
		[dY(i,:),A(i,:)] = ODE_fun(T(i),Y(i,:));
	end

	% Formatovani vystupu simulace
	sim.i_1 = A
	sim.om = dY(:,7);
	sim.t = T;

	% Vizualizace
	if plotORnot == true
		figure; hold on; c = 0; %>>
		for i = ["mer","sim"]
			for j = ["om","i_1"]
				fld = eval(i+"."+j);
				plot(fld(:,1),fld(:,2))
				c = c+1;
				lgd(c) = j+" - "+i;
			end
		end %<<
	end

end
