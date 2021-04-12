function C = Cost(delta,teor,mer,podm)
	% Prubeh simulace
	[sim,~] = SimFun(teor,mer,podm,delta,false);

	% Cost funkce
	mer_fld = mer.om(mer.in);
	interp_fld = interp1(sim.t,sim.om,mer.t_0:0.002:mer.t_f);

	Delta = (interp_fld-mer_fld)';

	C = Delta'*Delta;
end