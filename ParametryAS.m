demo.Lh = 0.3; %H
L1s = 0.02; demo.L1 = Lh+L1s; %H
L2s = 0.02; demo.L2 = Lh+L2s; %H
demo.R1 = 2; %Ohm
demo.R2 = 4; %Ohm
demo.M_B = 5; %Nm
demo.J = 0.1; %kg*m^2
U1 = 230; %V
Umax = sqrt(2)*U1; %V
f = 50; %Hz
demo.pp = 1;

save('DemoParametry.mat','-struct','demo')
