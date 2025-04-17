clc;
clear;

ncdisp('D:\data\rainfall\global\China_1km_prep_2018.nc')

nc_FilePath = 'D:\data\rainfall\perdayperkm\China_1km_prep_2018.nc'; 

output_filepath = 'D:\data\rainfall\perdayperkm\tif\';

lon=ncread(nc_FilePath,'lon');          
lat=ncread(nc_FilePath,'lat');         
time=ncread(nc_FilePath,'time');        

for time_index=1:length(time)
   pre = ncread(nc_FilePath,'prep',[1 1 time_index],[length(lon) length(lat) 1]);%获取所需变量数据
   pre(pre<10)=0;
   pre(isnan(pre))=0;
end

prep_power1 = 0;
prep_power2 = 0;
prep_power3 = 0;            
for time_index =1:length(time)
    if time_index <= 120
       pre=ncread(nc_FilePath,'prep',[1 1 time_index],[length(lon) length(lat) 1]);%获取所需变量数据
       prep_1 = power(pre, 1.7265);
       prep_power1 = prep_power1+prep_1;
    elseif time_index > 120 && time_index <= 273
       pre=ncread(nc_FilePath,'prep',[1 1 time_index],[length(lon) length(lat) 1]);%获取所需变量数据
       prep_2 = power(pre, 1.7265);
       prep_power2 = prep_2+ prep_power2;
    else        
       pre=ncread(nc_FilePath,'prep',[1 1 time_index],[length(lon) length(lat) 1]);%获取所需变量数据
       prep_3 = power(pre, 1.7265);
       prep_power3 = prep_3+ prep_power3;
    end
end

R1 = 0.3101*(prep_power1+prep_power3);
R2 = 0.3937*prep_power2;
R_total = (R1+R2);

data=rot90(R_total);                 
R = georasterref('RasterSize', size(data),'Latlim', [double(min(lat)) double(max(lat))], 'Lonlim', [double(min(lon)) double(max(lon))]);
geotiffwrite('D:\data\rainfall\perdayperkm\tif\R_2018.tif',data,R);
