srcpath='C:\Users\fernando\Desktop\wind_NCEP_2_DELFT'
tgtpath='C:\Users\fernando\Desktop\wind_NCEP_2_DELFT'
tgtbase='saida'
ufile='u_acu.nc'
vfile='v_acu.nc'

u=nc_varget(ufile,'uwnd');
v=nc_varget(vfile,'vwnd');
uwnd = fullfile(tgtpath,[tgtbase '.amu']);
vwnd = fullfile(tgtpath,[tgtbase '.amv']);
lon = nc_varget(ufile,'lon');
lat = nc_varget(ufile,'lat');
lon1 = nc_varget(vfile,'lon');
lat1 = nc_varget(vfile,'lat');
lon=lon-360;
lon1=lon1-360
dlon = diff(lon);
dlat = diff(lat);
dlon1 = diff(lon1);
dlat1 = diff(lat1);
dlat=dlat*(-1);
dlat1=dlat1*(-1);
ufid = fopen(uwnd,'w');
vfid = fopen(vwnd,'w');
uvfd = [ufid vfid];
fprintf(ufid,'FileVersion      = 1.03\n');
fprintf(vfid,'FileVersion      = 1.03\n');
fprintf(ufid,'Filetype         = meteo_on_equidistant_grid\n');
fprintf(vfid,'Filetype         = meteo_on_equidistant_grid\n');
fprintf(ufid,'NODATA_value         = -999.000\n');
fprintf(vfid,'NODATA_value         = -999.000\n');
fprintf(ufid,'n_cols           = %i\n',size(u,3));
fprintf(vfid,'n_cols           = %i\n',size(u,3));
 fprintf(ufid,'n_rows           = %i\n',size(u,2));
 fprintf(vfid,'n_rows           = %i\n',size(u,2));
    fprintf(ufid,'grid_unit        = degree\n');
    fprintf(vfid,'grid_unit        = degree\n');
    % code currently assumes lon and lat are increasing
    fprintf(ufid,'x_llcorner       = %g\n',min(lon(:)));
    fprintf(vfid,'x_llcorner       = %g\n',min(lon1(:)));
    fprintf(ufid,'dx               = %g\n',dlon(1));
    fprintf(vfid,'dx               = %g\n',dlon1(1));
    fprintf(ufid,'y_llcorner       = %g\n',min(lat(:)));
    fprintf(vfid,'y_llcorner       = %g\n',min(lat1(:)));
    fprintf(ufid,'dy               = %g\n',dlat(1));
    fprintf(vfid,'dy               = %g\n',dlat1(1));

%mfprintf(uvfd,'NODATA_value     = %7.3f\n',nodata);
fprintf(ufid,'n_quantity       = 1\n');
fprintf(vfid,'n_quantity       = 1\n');
fprintf (ufid,'quantity1        = x_wind\n');
fprintf (vfid,'quantity1        = y_wind\n');
fprintf(ufid,'unit1            = m s-1\n');
fprintf(vfid,'unit1            = m s-1\n');
[nt,ni,nj] = size(u);
c = 0;
for t = 1:nt
    fprintf(ufid,['TIME = ' num2str(c) ' hours since 2013-03-01 00:00:00 +00:00\n']);
    fprintf(vfid,['TIME = ' num2str(c) ' hours since 2013-03-01 00:00:00 +00:00\n']);
    %for i =ni:-1:1
    for i =1:ni
        for j = 1:nj
            fprintf(ufid,'%9.3f',u(t,i,j));
            fprintf(vfid,'%9.3f',v(t,i,j));
        end
        fprintf(ufid,'\n');
        fprintf(vfid,'\n');
    end
    c = c + 6;
end
fclose(ufid);
fclose(vfid);
        
            
