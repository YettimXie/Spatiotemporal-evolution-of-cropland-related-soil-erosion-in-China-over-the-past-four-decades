clear;
clc;

[A,R]=geotiffread('C:\Users\user\Desktop\xyt\ccrop_china.tif');
A2=double(A);
A2(find(A2<0))=NaN; 
F = fillmissing(A2,'nearest');
info=geotiffinfo('C:\Users\user\Desktop\xyt\ccrop_china.tif');
geotiffwrite('C:\Users\user\Desktop\xyt\ccrop_china_new.tif', F, R,'TiffType','bigtiff','GeoKeyDirectoryTag', info.GeoTIFFTags.GeoKeyDirectoryTag);
