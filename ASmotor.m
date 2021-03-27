function [dy,i_a] = ASmotor(t,y)
	%% Stavove veliciny
	psi_1a = y(1); psi_1b = y(2);
	psi_2a = y(3); psi_2b = y(4);
	om = y(5);
	%% Parametry
	ParametryAsynch
	%% Pomocne funkce
	i_n = @(a_n,a_m) ( a_n*L2-a_m*Lh )/( L1*L2-Lh^2 );
	WaveGen = @(f,phi,t) sin(2*pi*f*t+phi);
	%% Proudy
	i_1a = i_n(psi_1a,psi_2a);
	i_2a = i_n(psi_2a,psi_1a);
	i_1b = i_n(psi_1b,psi_2b);
	i_2b = i_n(psi_2b,psi_1b);
	%% Napeti
	u_1a = Umax*WaveGen(f,0,t);
	u_1b = Umax*WaveGen(f,-pi/2,t);
	u_2a = 0;
	u_2b = 0;
	%% Statorova napeti
	d_psi_1a = u_1a - R1*i_1a;
	d_psi_1b = u_1b - R1*i_1b;
	%% Rotorova napeti
	d_psi_2a = u_2a - R2*i_2a - om*psi_2b;
	d_psi_2b = u_2b - R2*i_2b + om*psi_2a;
	%% Moment a uhlova rychlost
	Mh = 3/2*pp*(psi_1a*i_1b-psi_1b*i_1a);
	d_om = (Mh-Mz)/(J*pp);
	%% Derivace stavovych velicin
	dy = [	d_psi_1a
			d_psi_1b
			d_psi_2a
			d_psi_2b
			d_om		];
end