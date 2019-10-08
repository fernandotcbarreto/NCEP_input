function []=v_calc(filev)

tgtbase='saida';


NC_v=filev;
dataref='2004-01-01';%aaaa-mm-dd

v=nc_varget(NC_v,'vwnd');
%vwnd = fullfile(tgtpath,[tgtbase '.amv']);
vwnd='saida.amv';
lon1 = nc_varget(NC_v,'lon');
lat1 = nc_varget(NC_v,'lat');
lon1=lon1-360;
dlon1 = diff(lon1);
dlat1 = diff(lat1);
dlat1=dlat1*(-1);
vfid = fopen(vwnd,'w');
fprintf(vfid,'FileVersion      = 1.03\n');
fprintf(vfid,'Filetype         = meteo_on_equidistant_grid\n');
fprintf(vfid,'NODATA_value         = -999.000\n');
fprintf(vfid,'n_cols           = %i\n',size(v,4));%3));
 fprintf(vfid,'n_rows           = %i\n',size(v,3));%2));
    fprintf(vfid,'grid_unit        = degree\n');
    % code currently assumes lon and lat are increasing
    fprintf(vfid,'x_llcorner       = %g\n',min(lon1(:)));
    fprintf(vfid,'dx               = %g\n',dlon1(1));
    fprintf(vfid,'y_llcorner       = %g\n',min(lat1(:)));
    fprintf(vfid,'dy               = %g\n',dlat1(1));

%mfprintf(uvfd,'NODATA_value     = %7.3f\n',nodata);
fprintf(vfid,'n_quantity       = 1\n');
fprintf (vfid,'quantity1        = y_wind\n');
fprintf(vfid,'unit1            = m s-1\n');
[nt,nl,ni,nj] = size(v);
c = 0;
for t = 1:nt
    fprintf(vfid,['TIME = ' num2str(c) ' hours since ' dataref ' 00:00:00 +00:00\n']);
    %for i =ni:-1:1
    for i =1:ni
        for j = 1:nj
            fprintf(vfid,'%9.3f',v(t,1,i,j));
        end
        fprintf(vfid,'\n');
    end
    c = c + 6;
end
fclose(vfid);
end 
        
            
