% Initial variables
u = zeros(Ni+1,Nj);
v = zeros(Ni,Nj+1);
C = zeros(Ni,Nj);

h = hoffset*ones(Ni,Nj);
zb = zeros(Ni,Nj);

% Load start file contains initial u, v, and h related to river
% inflow. Uncomment for Problem 4.
%load('data/sfbay_init_seds');


