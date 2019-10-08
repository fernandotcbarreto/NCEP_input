function []=pressure(file)
%pressure
tgtbase='saida'
u=nc_varget('p2004.nc','pres');
uwnd = [tgtbase '.amp'];
lon = nc_varget('p2004.nc','lon');
lat = nc_varget('p2004.nc','lat');
lon=lon-360;
dlon = diff(lon);
dlat = diff(lat);
dlat=dlat*(-1);
ufid = fopen(uwnd,'w');
fprintf(ufid,'FileVersion      = 1.03\n');
fprintf(ufid,'Filetype         = meteo_on_equidistant_grid\n');
fprintf(ufid,'NODATA_value     = -999.000\n');
fprintf(ufid,'n_cols           = %i\n',size(u,3));
 fprintf(ufid,'n_rows           = %i\n',size(u,2))
    fprintf(ufid,'grid_unit        = degree\n');
    % code currently assumes lon and lat are increasing
    fprintf(ufid,'x_llcenter        = %g\n',min(lon(:)));
    fprintf(ufid,'dx               = %g\n',dlon(1));
    fprintf(ufid,'y_llcenter       = %g\n',min(lat(:)));
    fprintf(ufid,'dy               = %g\n',dlat(1));

%mfprintf(uvfd,'NODATA_value     = %7.3f\n',nodata);
fprintf(ufid,'n_quantity       = 1\n');
fprintf (ufid,'quantity1        = air_pressure\n');
fprintf(ufid,'unit1            = Pa\n');

[nt,ni,nj] = size(u);
c = 0;
for t = 1:nt
    fprintf(ufid,['TIME = ' num2str(c) ' hours since 2013-03-01 00:00:00 +00:00\n']);
    %for i =ni:-1:1
    for i =1:ni               
        for j = 1:nj
             fprintf(ufid,'%15.5f',u(t,i,j));
        end
        fprintf(ufid,'\n');
    end
    c = c + 6;
end
fclose(ufid);
end 
            