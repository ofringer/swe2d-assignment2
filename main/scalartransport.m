function C_new = scalartransport(u_old,v_old,u_new,v_new,xc,yc,xu,yu,xv,yv,C,Huwx,Huwy,...
                                 dx,dy,dt,n,theta,h,d,H_old,L,W,rhs,boundaryregion_type2,Cb_type2,boundaryregion_type3,Cb_type3)

global_pointers;
global FlowRate Flux

getvariables

Cuwx=zeros(size(u_new));
Cuwy=zeros(size(v_new));

H_new = h+d;

utheta=theta*u_new+(1-theta)*u_old;
vtheta=theta*v_new+(1-theta)*v_old;

% First-order upwind values on the u faces
Cuwx(2:end-1,:)=(utheta(2:end-1,:)>0).*C(1:end-1,:)+(utheta(2:end-1,:)<=0).*C(2:end,:);

% First-order upwind values on the v faces
Cuwy(:,2:end-1)=(vtheta(:,2:end-1)>0).*C(:,1:end-1)+(vtheta(:,2:end-1)<=0).*C(:,2:end);


% This sets the value at the face regardless of whether upwind or
% downwind.  Need to fix so that it updates based on upwind,
% i.e. uses interior value instead of boundary value...
[Cuwx,Cuwy]=boundaryconditions_face(C,u_old,v_old,Cuwx,Cuwy,Huwx*dy,Huwy*dx,xu,yu,xv,yv,n,boundaryregion_type2,[],[],[],Cb_type2,'C');
C=boundaryconditions_cell(C,xc,yc,n,boundaryregion_type3,Cb_type3);

if(isempty(rhs))
    rhs=zeros(size(C));
end

C_new=zeros(size(C));
C_new=1./H_new.*(H_old.*C + dt*rhs ...
                 -dt*(Huwx(2:end,:).*utheta(2:end,:).*Cuwx(2:end,:) ...
                      -Huwx(1:end-1,:).*utheta(1:end-1,:).*Cuwx(1:end-1,:))/dx ...
                 -dt*(Huwy(:,2:end).*vtheta(:,2:end).*Cuwy(:,2:end) ...
                      -Huwy(:,1:end-1).*vtheta(:,1:end-1).*Cuwy(:,1:end-1))/dy);

% Don't touch the type 3 boundary cells
C_new(cellmark==3)=C(cellmark==3);
C_new(H_new==0)=0;

% Need to set inactive cells to zero since they may have been
% updated at boundary edges that are inside the domain.
C_new(cellmark==0)=0;

%
% Code to compute fluxes across the cross sections.
%

load data/sfbay_flux_indices

if(n==1)
    FlowRate = zeros(nsteps,5); % Volume flow rate
    Flux = zeros(nsteps,5); % Suspended sediment flux
end

for mf=1:5
    is=flux_i{mf};
    js=flux_j{mf};
    if(flux_type(mf)=='u')
        FlowRate(n,mf)=sum(Huwx(is,js).*utheta(is,js)*dy);
        Flux(n,mf)=sum(Cuwx(is,js).*Huwx(is,js).*utheta(is,js)*dy);
    else
        FlowRate(n,mf)=sum(Huwy(is,js).*vtheta(is,js)*dx);
        Flux(n,mf)=sum(Cuwy(is,js).*Huwy(is,js).*vtheta(is,js)*dy);
    end
end
