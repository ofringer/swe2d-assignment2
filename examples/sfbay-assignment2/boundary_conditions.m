% Incoming flows and SSC at the river boundaries
Qsac=1500; % Sacramento River inflow (m3/s)
Csac=100;  % Sacramento River incoming sediment concentration (mg/liter)
Qsan=1500; % San Joaquin River inflow (m3/s)
Csan=100;  % San Joaquin River incoming sediment (mg/liter)

% Create a pulse time series (the variables are known and global,
% except for Tday)
Tday=86400;
t=[1:nsteps]*dt; 
time_pulse=10*Tday;
f_pulse=exp(-2*(t-time_pulse)/Tday);
f_pulse(f_pulse>1)=1;

% For problem 4, the inflows should be constant, so uncomment this line.
%f_pulse=ones(size(t));

% Boundary conditions
% Sacramento River
boundaryregion_type2{1} = 1e4*[8.7673 6.9737 ; 9.1820 7.6462];
Qb_type2{1} = Qsac*f_pulse;
Cb_type2{1} = Csac*f_pulse;
ub_type2{1} = 0;
vb_type2{1} = 0;

% San Joaquin River
boundaryregion_type2{2} = 1e4*[8.7442 6.2427 ; 9.2051 6.8860];
Qb_type2{2} = Qsan*f_pulse;
Cb_type2{2} = Csan*f_pulse;
ub_type2{2} = 0.0;
vb_type2{2} = 0.0;

% Simplified tide at the ocean boundary that ramps up over one day
% with the function 1 - exp(-t/Tday)
amp=1;
TM2=12*3600; % Use 12 hours to ensure periodicity with Tday
omegaM2=2*pi/TM2;
hb=hoffset+TIDES*amp*sin(omegaM2*t).*(1-exp(-t/Tday)); 

% This polygon surrounds the open ocean boundary
boundaryregion_type3{1} = 1e4*...
    [1.4332    4.8868
     2.1612    3.2852
     2.3797    1.6107
     0.3048    2.0839
     -0.4960    3.8130
     0.1774    5.6512
     1.2876    5.0870];
Cb_type3{1} = 0;
hb_type3{1} = hb;

