function [sml,param] = SimFun(teor,mer,podm,delta,plotORnot)
	if nargin < 5; plotORnot = false; end;

	% Uprava parametru
	pn = fieldnames(teor);
	for i = 1:numel(pn)
		param.(pn{i}) = teor.(pn{i})+delta(i);
	end

	% Simulace
	% ODE_fun = @(t,y) ASmotor(param,podm,t,y);
	% [T,Y] = ode45(ODE_fun,podm.t,zeros(5,1));
	% for i = 1:length(T)
	% 	[dY(i,:),A(i,:)] = ODE_fun(T(i),Y(i,:));
	% end

	Ls = param.L1;
	Lr = param.L2;
	Lh = param.Lh;
	pp = param.pp;
	Rs = param.R1;
	Rr = param.R2;
	J = param.J;
	Umax = podm.Umax;

	options = simset('SrcWorkspace','current');
	SimOut = sim('ASmodelViskozni',[],options);

	% Formatovani vystupu simulace
	sml.i_ef = reshape(SimOut.I.Data/sqrt(2),1,[]);
	sml.om = reshape(SimOut.om.Data/sqrt(2),1,[]);
	sml.t = SimOut.tout;

	% Vizualizace
	if plotORnot == true
		figure; hold on; %>>
		for i = ["mer","sml"]
			time = eval(i+".t");
			for j = ["om","i_ef"]
				if j == "om"; yyaxis left; end
				if j == "i_ef"; yyaxis right; end
				fld = eval(i+"."+j);
				plot(time,fld)
			end
		end
		legend(["\omega - mer","\omega - sml","i_{ef} - mer","i_{ef} - sml"]) %<<
	end

end
