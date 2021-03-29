function COST = OptFun(teor,mer,podm,delta,plotORnot)
	if nargin < 5; plotORnot = false; end;

	%% UPRAVA PARAMETRU
	pn = fieldnames(teor);
	for i = 1:numel(pn)
		par.(pn(i)) = teor.(pn(i))+delta(i);
	end

	% Simulace
	ODE_fun = @(t,y) ASmotor(par,podm,t,y);
	[T,Y] = ode45(ODE_fun,podm.t,zeros(5,1));
	for i = 1:length(T)
		[dY(i,:),A(i,:)] = ODE_fun(T(i),Y(i,:));
	end

	% Formatovani vystupu simulace
	sim.i_1 = A
	sim.om = dY(:,7);
	sim.t = T;

	% Cost funkce
	[sm,mr] = find( sim.t' == mer.t );
	rn = ["om","i_1"];
	for i = 1:numel(rn)
		sim_fld = sim.(rn(i))(sm);
		mer_fld = mer.(rn(i))(mr);
		
		Delta(i) = (sim_fld-mer_fld);
		Ny(i) = mean(mer_fld.^(-2));
	end
	COST = Delta'*diag(Ny)*Delta;

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
