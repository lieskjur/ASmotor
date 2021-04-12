function C = Cost(delta,teor,mer,podm)
	% Prubeh simulace
	[sim,~] = SimFun(teor,mer,podm,delta,false);

	% Cost funkce
	rn = ["om"];
	for i = 1:numel(rn)
		sim_fld = sim.(rn(i))(sm);
		mer_fld = mer.(rn(i))(mr);
		
		interp_fld = interp1(sim_fld,mer.t0:0.002:mer.t_f)

		Delta(i) = (interp_fld'-mer_fld);
		Ny(i) = mean(mer_fld.^(-2));
	end
	C = Delta'*diag(Ny)*Delta;
end