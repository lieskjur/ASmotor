function C = Cost(teor,mer,podm,delta)
	% Prubeh simulace
	[sim,~] = SimFun(teor,mer,podm,delta,false)

	% Cost funkce
	[sm,mr] = find( sim.t' == mer.t ); %Prumet casovych prubehu
	rn = ["om","i_1"];
	for i = 1:numel(rn)
		sim_fld = sim.(rn(i))(sm);
		mer_fld = mer.(rn(i))(mr);
		
		Delta(i) = (sim_fld-mer_fld);
		Ny(i) = mean(mer_fld.^(-2));
	end
	C = Delta'*diag(Ny)*Delta;
end