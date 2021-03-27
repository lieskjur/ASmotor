function  [a0,a1] = fitLin(t_0,t_f,time,Y,plotORnot)
	if nargin < 4; plotORnot = false; end;
	if isempty(t_f); t_f = max(time); end;
	
	in = find( (time>=t_0) & (time<=t_f) );

	y = @(a0,a1,x) a0+a1*x;
	FitOptions = fitoptions('Method','NonlinearLeastSquares','StartPoint',[0,0]);
	FitFun = fittype(y,'independent','x','coefficients',{'a0','a1'});
	FitObj = fit(time(in),Y(in),FitFun,FitOptions);
	a0 = FitObj.a0;
	a1 = FitObj.a1;

	if plotORnot == true
		figure
		hold on
		plot(time,Y);
		plot(time(in),y(a0,a1,time(in)));
	end
end