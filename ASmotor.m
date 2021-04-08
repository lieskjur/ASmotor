function [dy,i_1] = ASmotor(par,nap,t,y)
	%% Stavove veliciny
	psi_1a = y(1); psi_1b = y(2);
	psi_2a = y(3); psi_2b = y(4);
	om = y(5);
	%% Pomocne funkce
	i_n1 = @(a_n,a_m) ( a_n*par.L2-a_m*par.Lh )/( par.L1*par.L2-par.Lh^2 );
    i_n2 = @(a_n,a_m) ( a_n*par.L1-a_m*par.Lh )/( par.L1*par.L2-par.Lh^2 );
	WaveGen = @(f,phi,t) sin(2*pi*f*t+phi);
	%% Proudy
	i_1a = i_n1(psi_1a,psi_2a);
	i_2a = i_n2(psi_2a,psi_1a);
	i_1b = i_n1(psi_1b,psi_2b);
	i_2b = i_n2(psi_2b,psi_1b);
	%% Napeti
    f=nap.f/par.pp;
    u_u=nap.Umax*WaveGen(f,0,t);
    u_v=nap.Umax*WaveGen(f,-2/3*pi,t);
    u_w=nap.Umax*WaveGen(f,-4/3*pi,t);
    k=2/3;
	u_1b = k*(u_u-0.5*u_v-0.5*u_w);
	u_1a = k*(0-sqrt(3)/2*u_v+sqrt(3)/2*u_w);
	u_2a = 0;
	u_2b = 0;
	%% Statorova napeti
	d_psi_1a = u_1a - par.R1*i_1a;
	d_psi_1b = u_1b - par.R1*i_1b;
	%% Rotorova napeti
	d_psi_2a = u_2a - par.R2*i_2a - om*psi_2b;
	d_psi_2b = u_2b - par.R2*i_2b + om*psi_2a;
	%% Moment a uhlova rychlost
	Mh = 3/2*par.pp*(psi_1a*i_1b-psi_1b*i_1a);
	d_om = (Mh-par.M_B)/(par.J*par.pp);
	%% Derivace stavovych velicin
	dy = [	d_psi_1a
			d_psi_1b
			d_psi_2a
			d_psi_2b
			d_om		];
	%% Celkovy proud
	i_1 = norm([i_1a,i_1b]);
end