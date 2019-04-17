function [dx,dy,Ni,Nj,depth,markuface,markvface,cellmark]=make_grid()

load('data/sfbay_grid');

% Bathymetry is in depth
hoffset=-4;
H = depth+hoffset;
Dmin = 2;            % Minimum allowable bottom depth (relative to
                     % MSL) to prevent wetting/drying (otherwise
                     % the calculation takes a lot longer).
depth(H<Dmin & depth~=0)=Dmin-hoffset;
