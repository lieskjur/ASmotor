function param = Dopocet(param)
	param.pp = 2;

	param.L1 = param.Lh+param.L_1sig;
	param.L2 = param.Lh+param.L_2sig;
	param.J = -param.M_B/param.dwdt;
end