%
% Plot the SSC as a function of distance from the GGB at the end of
% each day of simulation.
% 
% The code can output C_out, u_out, v_out, h_out, H_out at the locations
% indicated in the file data/transect, as indicated by the variable
% vars_to_output, which can have any one of 'u','v','h','C', or 'H'
% to output the desired data.  For example, to output u, h, and C, 
% use vars_to_output='uhC';
%
plot_days=[5,10,15,20];
figure(1);
clf;
hold on;
set(gca,'fontsize',18,'box','on');
plot(dist_transect/1000,C_out(plot_days,:));
legend('t=5 days','10','15','20','location','northwest');
xlabel('Distance from GGB (km)');
ylabel('SSC (mg/l)');
