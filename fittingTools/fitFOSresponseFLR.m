function tau = fitFOSresponseFLR(t_0,t_f,time,I_meas,plotORnot)
	if nargin < 4; plotORnot = false; end;
	if isempty(t_f); t_f = max(time); end;
	
	in = find( (time>=t_0) & (time<=t_f) );
	I_0 = I_meas(in(1));

	%I = @(tau,t) I_0*(1-exp(-(t-t_0)/tau));
	I = @(flr,tau,t) (I_0-flr)*exp(-(t-t_0)/tau)+flr;
	FitOptions = fitoptions('Method','NonlinearLeastSquares','StartPoint',[1,1]);
	FitFun = fittype(I,'independent','t','coefficients',{'flr','tau'});
	FitObj = fit(time(in),I_meas(in),FitFun,FitOptions);
	tau = FitObj.tau; flr = FitObj.flr;

	if plotORnot == true
		figure
		hold on
		plot(time,I_meas);
		plot(time(in),I(flr,tau,time(in)));
		scatter(t_0,I_0);
	end
end