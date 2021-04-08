    WaveGen = @(f,phi,t) sin(2*pi*f*t+phi);
    t=0:0.0001:2*pi;
    f=25;
    u_u=220*WaveGen(f,0,t);
    u_v=220*WaveGen(f,-2/3*pi,t);
    u_w=220*WaveGen(f,-4/3*pi,t);
    k=2/3;
	u_1a = k*(u_u-0.5*u_v-0.5*u_w);
	u_1b = k*(0-sqrt(3)/2*u_v+sqrt(3)/2*u_w);
    plot(t,u_1a,t,u_1b)