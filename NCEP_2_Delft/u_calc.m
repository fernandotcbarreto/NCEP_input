function []=u_calc(fileu)


tgtbase=pwd;
NC_u=fileu;
dataref='2013-03-01';%aaaa-mm-dd

u=nc_varget(NC_u,'uwnd');
%uwnd = fullfile([tgtbase '.amu']);
uwnd='saida.amu';
lon = nc_varget(NC_u,'lon');
lat = nc_varget(NC_u,'lat');
lon=lon-360;
dlon = diff(lon);
dlat = diff(lat);
dlat=dlat*(-1);
ufid = fopen(uwnd,'w');
fprintf(ufid,'FileVersion      = 1.03\n');
fprintf(ufid,'Filetype         = meteo_on_equidistant_grid\n');
fprintf(ufid,'NODATA_value         = -999.000\n');
fprintf(ufid,'n_cols           = %i\n',size(u,4));%size(u,3));
 fprintf(ufid,'n_rows           = %i\n',size(u,3));%2));
    fprintf(ufid,'grid_unit        = degree\n');
    % code currently assumes lon and lat are increasing
    fprintf(ufid,'x_llcorner       = %g\n',min(lon(:)));
    fprintf(ufid,'dx               = %g\n',dlon(1));
    fprintf(ufid,'y_llcorner       = %g\n',min(lat(:)));
    fprintf(ufid,'dy               = %g\n',dlat(1));

%mfprintf(uvfd,'NODATA_value     = %7.3f\n',nodata);
fprintf(ufid,'n_quantity       = 1\n');
fprintf (ufid,'quantity1        = x_wind\n');
fprintf(ufid,'unit1            = m s-1\n');
[nt,nl,ni,nj] = size(u);
c = 0;
for t = 1:nt
    fprintf(ufid,['TIME = ' num2str(c) ' hours since ' dataref ' 00:00:00 +00:00\n']);
    %for i =ni:-1:1
    for i =1:ni
        for j = 1:nj
            fprintf(ufid,'%9.3f',u(t,1,i,j));
        end
        fprintf(ufid,'\n');
    end
    c = c + 6;
end
fclose(ufid);
end 
        
            
