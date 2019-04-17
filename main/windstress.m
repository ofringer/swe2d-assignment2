function [U10,taux,tauy]=windstress(n,dt)

  getvariables;

  U10=0;
  t=n*dt;
  if(omega_0==0)
    taux=tau_x0;
    tauy=tau_y0;
  else    
    taux=tau_x0*sin(omega_0*(t+dt/2));
    tauy=tau_y0*sin(omega_0*(t+dt/2));
  end 
