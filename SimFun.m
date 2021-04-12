function [sim,param] = SimFun(teor,mer,podm,delta,plotORnot)
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
	sim.i_ef = A/sqrt(2);
	sim.om = Y(:,5);
	sim.t = T;

	% Vizualizace
	if plotORnot == true
		figure; hold on; %>>
		for i = ["mer","sim"]
			time = eval(i+".t");
			for j = ["om","i_ef"]
				if j == "om"; yyaxis left; end
				if j == "i_ef"; yyaxis right; end
				fld = eval(i+"."+j);
				plot(time,fld)
			end
		end
		legend(["\omega [rad/s] - mer","\omega [rad/s] - sim","i_{ef} [A] - mer","i_{ef} [A] - sim"],'location','east') %<<
	end

end
