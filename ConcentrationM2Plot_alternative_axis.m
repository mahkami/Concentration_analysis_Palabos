clear all
close all
clc

%% set figure properties

set(groot,'defaulttextinterpreter','latex');
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');


set(0,'DefaultTextFontSize', 40)
set(0,'DefaultAxesFontSize',65);
set(0,'DefaultLegendFontSize',75);
set(0,'DefaultLineMarkerSize', 35)
set(0,'DefaultLineLineWidth', 5)
% set(0,'DefaultMarkerMarkerSize', 5)
set(0,'defaultUicontrolFontName', 'Arial')
set(0,'defaultUitableFontName', 'Arial')
set(0,'defaultAxesFontName', 'Arial')
set(0,'defaultTextFontName', 'Arial')
set(0,'defaultUipanelFontName', 'Arial')

shapewline = {'-.d',':>','--s','-.^',':o'};
% shapewline = {'d','>','s','^','o'};
col = magma(6);
col = col(1:end-1,:);


%% identifying different regions in the media


media = NaN(2180,1680);

% flow through fractures

ff_lp = media; ff_lp(95:2088  ,559:604)   = 1;
ff_hp = media; ff_hp(97:2088  ,1079:1128) = 1;

% Dead-end fractures

fd_lp = media; fd_lp(95:214  ,   261:304) = 1;
fd_lp(211:334 ,   241:284) = 1;
fd_lp(331:454 ,   221:264) = 1;
fd_lp(451:574 ,   201:244) = 1;
fd_lp(571:694 ,   181:224) = 1;
fd_lp(691:814 ,   161:204) = 1;
fd_lp(811:934 ,   141:184) = 1;
fd_lp(931:1054 ,  121:164) = 1;
fd_lp(1051:1174 , 101:144) = 1;
fd_lp(1171:1294 , 81:124)  = 1;
fd_lp(1291:1414 , 61:104)  = 1;
fd_lp(1411:1534 , 41:84)   = 1;
fd_lp(1531:1654 , 21:64)   = 1;
fd_lp(1651:1774 , 1:44)    = 1;



fd_hp = media; fd_hp(97:228  ,  1365:1414) = 1;
fd_hp(223:360 ,  1387:1436) = 1;
fd_hp(355:492 ,  1409:1458) = 1;
fd_hp(487:624 ,  1431:1480) = 1;
fd_hp(619:756 ,  1453:1502) = 1;
fd_hp(751:888 ,  1475:1524) = 1;
fd_hp(883:1020 , 1497:1546) = 1;
fd_hp(1015:1152 ,1519:1568) = 1;
fd_hp(1147:1284 ,1541:1590) = 1;
fd_hp(1279:1416 ,1563:1612) = 1;
fd_hp(1411:1548 ,1585:1624) = 1;
fd_hp(1543:1680 ,1607:1646) = 1;
fd_hp(1675:1812 ,1629:1671) = 1;



% Low perm matrix
lp = media; lp(95:2088 , 1:862) = 1;
temp_lay  = fd_lp; temp_lay(temp_lay==1) =0; temp_lay(isnan(temp_lay))= 1;
temp_lay2 = ff_lp; temp_lay2(temp_lay2==1) =0; temp_lay2(isnan(temp_lay2))= 1;
lp = lp.*(temp_lay); lp = lp.*(temp_lay2);
lp(lp==0)=NaN;

% High perm matrix

hp = media; hp(98:2088 , 863:end) = 1;
temp_lay  = fd_hp; temp_lay(temp_lay==1) =0; temp_lay(isnan(temp_lay))= 1;
temp_lay2 = ff_hp; temp_lay2(temp_lay2==1) =0; temp_lay2(isnan(temp_lay2))= 1;
hp = hp.*(temp_lay); hp = hp.*(temp_lay2);
hp(hp==0)=NaN;

filt(1).name = 'Flow fracture high perm'; filt(1).val = ff_hp;
filt(2).name = 'Flow fracture low perm' ; filt(2).val = ff_lp;
filt(3).name = 'Dead fracture high perm'; filt(3).val = fd_hp;
filt(4).name = 'Dead fracture low perm' ; filt(4).val = fd_lp;
filt(5).name = 'Matrix high perm'       ; filt(5).val = hp;
filt(6).name = 'Matrix low perm'        ; filt(6).val = lp;

% Saving filter file

save('Filter_file.mat','filt')

files = dir('Output_3D*');

% Conversion factor
conv_f = 1680/2180;

%sigma2xx = sigma2xx*conv^2
% sigma2xy = sigma2xx*conv
% xc = xc*conv
               
% Importing data

Out0001 = load(files(1).name');
Out0001 = Out0001.output;

for cc = 1:length([Out0001.xc])
Out0001(cc).SigmaXX = Out0001(cc).SigmaXX*conv_f^2;
Out0001(cc).SigmaXY = Out0001(cc).SigmaXY*conv_f;
Out0001(cc).xc = Out0001(cc).xc*conv_f;
end

Out001 = load(files(2).name');
Out001 = Out001.output;

for cc = 1:length([Out001.xc])
Out001(cc).SigmaXX = Out001(cc).SigmaXX*conv_f^2;
Out001(cc).SigmaXY = Out001(cc).SigmaXY*conv_f;
Out001(cc).xc = Out001(cc).xc*conv_f;
end


Out01 = load(files(3).name');
Out01 = Out01.output;

for cc = 1:length([Out01.xc])
Out01(cc).SigmaXX = Out01(cc).SigmaXX*conv_f^2;
Out01(cc).SigmaXY = Out01(cc).SigmaXY*conv_f;
Out01(cc).xc = Out01(cc).xc*conv_f;
end

Out4 = load(files(4).name');
Out4 = Out4.output;

for cc = 1:length([Out4.xc])
Out4(cc).SigmaXX = Out4(cc).SigmaXX*conv_f^2;
Out4(cc).SigmaXY = Out4(cc).SigmaXY*conv_f;
Out4(cc).xc = Out4(cc).xc*conv_f;
end

load('coordmat.mat')
disp('Load Finished')


%% plotting results


% D = ud * sigma /Pe
% t_d = iteration *ud/Pe*sigma
ud = 7.89075e-5;
sigma = 45;

t_d(1) = ud/(0.001*sigma);
t_d(2) = ud/(0.01*sigma);
t_d(3) = ud/(0.1*sigma);
t_d(4) = ud/(4*sigma);


% % to plot based on interation, we should assign 1 to the conversion
% t_d(1) = 1;
% t_d(2) = 1;
% t_d(3) = 1;
% t_d(4) = 1;




fig = figure('name','M2XX');
fig.Position =  get(0, 'Screensize');
fig.Color = 'w'; fig.Position = [1 1 3060 1844]; %fig.PaperUnits = 'normalized'; fig.PaperPosition =[0 0 1 1];

semilogx([Out0001.iteration]*t_d(1),[Out0001.M2XX],cell2mat(shapewline(1)),'color' ,col(1,:)) 
hold on
semilogx([Out001.iteration]*t_d(2),[Out001.M2XX],cell2mat(shapewline(2)),'color' ,col(2,:))
hold on
semilogx([Out01.iteration]*t_d(3),[Out01.M2XX],cell2mat(shapewline(3)),'color' ,col(3,:)) 
hold on
semilogx([Out4.iteration]*t_d(4),[Out4.M2XX],cell2mat(shapewline(4)),'color' ,col(4,:)) 
hold on


% % WIth intital value reduction
% semilogx([Out0001.iteration]*t_d(1),[Out0001.M2XX]-mean([Out0001(1:5).M2XX]),cell2mat(shapewline(1)),'color' ,col(1,:)) 
% hold on
% semilogx([Out001.iteration]*t_d(2),[Out001.M2XX]-mean([Out001(1:5).M2XX]),cell2mat(shapewline(2)),'color' ,col(2,:))
% hold on
% semilogx([Out01.iteration]*t_d(3),[Out01.M2XX]-mean([Out01(1:5).M2XX]),cell2mat(shapewline(3)),'color' ,col(3,:)) 
% hold on
% semilogx([Out4.iteration]*t_d(4),[Out4.M2XX]-mean([Out4(1:5).M2XX]),cell2mat(shapewline(4)),'color' ,col(4,:)) 
% hold on
grid on
set(gca,'XTickLabel',{})
%xlabel('$t_{d}$')
ylabel('$M^{2}_{XX}$ $[lattices^2]$')
%ylim([1e11 3e12])
leg = legend({'Pe=0.001' 'Pe=0.01' 'Pe=0.1' 'Pe=4'});
leg.Location = 'northwest';
leg.FontSize = 60;

pbaspect([2 1 1]);   F = getframe(fig);
imwrite(F.cdata, ['M2XX.png'], 'png')
saveas(fig,['M2XX.eps'], 'epsc')


fig = figure('name','M2XY');
fig.Position =  get(0, 'Screensize');
fig.Color = 'w'; fig.Position = [1 1 3060 1844]; %fig.PaperUnits = 'normalized'; fig.PaperPosition =[0 0 1 1];

semilogx([Out0001.iteration]*t_d(1),[Out0001.M2XY],cell2mat(shapewline(1)),'color' ,col(1,:)) 
hold on
semilogx([Out001.iteration]*t_d(2),[Out001.M2XY],cell2mat(shapewline(2)),'color' ,col(2,:))
hold on
semilogx([Out01.iteration]*t_d(3),[Out01.M2XY],cell2mat(shapewline(3)),'color' ,col(3,:)) 
hold on
semilogx([Out4.iteration]*t_d(4),[Out4.M2XY],cell2mat(shapewline(4)),'color' ,col(4,:)) 
hold on

% % WIth intital value reduction
% semilogx([Out0001.iteration]*t_d(1),[Out0001.M2XY]-mean([Out0001(1:5).M2XY]),cell2mat(shapewline(1)),'color' ,col(1,:)) 
% hold on
% semilogx([Out001.iteration]*t_d(2),[Out001.M2XY]-mean([Out001(1:5).M2XY]),cell2mat(shapewline(2)),'color' ,col(2,:))
% hold on
% semilogx([Out01.iteration]*t_d(3),[Out01.M2XY]-mean([Out01(1:5).M2XY]),cell2mat(shapewline(3)),'color' ,col(3,:)) 
% hold on
% semilogx([Out4.iteration]*t_d(4),[Out4.M2XY]-mean([Out4(1:5).M2XY]),cell2mat(shapewline(4)),'color' ,col(4,:)) 
% hold on

grid on
xlabel('$t_{d}$')
ylabel('$M^{2}_{XY}$ $[lattices^2]$')
%ylim([1e11 3e12])
leg = legend({'Pe=0.001' 'Pe=0.01' 'Pe=0.1' 'Pe=4'});
leg.Location = 'northwest';
leg.FontSize = 60;


pbaspect([2 1 1]);   F = getframe(fig);
imwrite(F.cdata, ['M2XY.png'], 'png')
saveas(fig,['M2XY.eps'], 'epsc')



fig = figure('name','M2YY');
fig.Position =  get(0, 'Screensize');
fig.Color = 'w'; fig.Position = [1 1 3060 1844]; %fig.PaperUnits = 'normalized'; fig.PaperPosition =[0 0 1 1];

semilogx([Out0001.iteration]*t_d(1),[Out0001.M2YY],cell2mat(shapewline(1)),'color' ,col(1,:)) 
hold on
semilogx([Out001.iteration]*t_d(2),[Out001.M2YY],cell2mat(shapewline(2)),'color' ,col(2,:))
hold on
semilogx([Out01.iteration]*t_d(3),[Out01.M2YY],cell2mat(shapewline(3)),'color' ,col(3,:)) 
hold on
semilogx([Out4.iteration]*t_d(4),[Out4.M2YY],cell2mat(shapewline(4)),'color' ,col(4,:)) 
hold on

% WIth intital value reduction
% semilogx([Out0001.iteration]*t_d(1),[Out0001.M2YY]-mean([Out0001(1:5).M2YY]),cell2mat(shapewline(1)),'color' ,col(1,:)) 
% hold on
% semilogx([Out001.iteration]*t_d(2),[Out001.M2YY]-mean([Out001(1:5).M2YY]),cell2mat(shapewline(2)),'color' ,col(2,:))
% hold on
% semilogx([Out01.iteration]*t_d(3),[Out01.M2YY]-mean([Out01(1:5).M2YY]),cell2mat(shapewline(3)),'color' ,col(3,:)) 
% hold on
% semilogx([Out4.iteration]*t_d(4),[Out4.M2YY]-mean([Out4(1:5).M2YY]),cell2mat(shapewline(4)),'color' ,col(4,:)) 
% hold on



grid on
xlabel('$t_{d}$')
ylabel('$M^{2}_{YY}$ $[lattices^2]$')
%ylim([1e11 3e12])
leg = legend({'Pe=0.001' 'Pe=0.01' 'Pe=0.1' 'Pe=4'});
leg.Location = 'northwest';
leg.FontSize = 60;


pbaspect([2 1 1]);   F = getframe(fig);
imwrite(F.cdata, ['M2YY.png'], 'png')
saveas(fig,['M2YY.eps'], 'epsc')

fig = figure('name','Center of mass_y');
fig.Position =  get(0, 'Screensize');
fig.Color = 'w'; fig.Position = [1 1 3060 1844]; %fig.PaperUnits = 'normalized'; fig.PaperPosition =[0 0 1 1];

semilogy([Out0001.yc],[Out0001.iteration]*t_d(1),cell2mat(shapewline(1)),'color' ,col(1,:)) 
hold on
semilogy([Out001.yc],[Out001.iteration]*t_d(2),cell2mat(shapewline(2)),'color' ,col(2,:))
hold on
semilogy([Out01.yc],[Out01.iteration]*t_d(3),cell2mat(shapewline(3)),'color' ,col(3,:)) 
hold on
semilogy([Out4.yc],[Out4.iteration]*t_d(4),cell2mat(shapewline(4)),'color' ,col(4,:)) 
hold on

grid on
ylabel('$t_{d}$')
xlabel('$y_{c}$')
%ylim([1e11 3e12])
leg = legend({'Pe=0.001' 'Pe=0.01' 'Pe=0.1' 'Pe=4'});
leg.Location = 'northwest';
leg.FontSize = 60;

lbl =xticklabels;
for i = 1 : length(lbl)
temp = sprintf('%.2f',str2num(char((lbl(i)))));

lbl(i) = cellstr(temp);
end
xticklabels(lbl)

pbaspect([2 1 1]);   F = getframe(fig);
imwrite(F.cdata, ['Center_mass_Y.png'], 'png')
saveas(fig,['Center_mass_Y.eps'], 'epsc')



fig = figure('name','Center of mass_x');
fig.Position =  get(0, 'Screensize');
fig.Color = 'w'; fig.Position = [1 1 3060 1844]; %fig.PaperUnits = 'normalized'; fig.PaperPosition =[0 0 1 1];

semilogx([Out0001.iteration]*t_d(1),[Out0001.xc],cell2mat(shapewline(1)),'color' ,col(1,:)) 
hold on
semilogx([Out001.iteration]*t_d(2),[Out001.xc],cell2mat(shapewline(2)),'color' ,col(2,:))
hold on
semilogx([Out01.iteration]*t_d(3),[Out01.xc],cell2mat(shapewline(3)),'color' ,col(3,:)) 
hold on
semilogx([Out4.iteration]*t_d(4),[Out4.xc],cell2mat(shapewline(4)),'color' ,col(4,:)) 
hold on

grid on
set(gca,'XTickLabel',{})
%xlabel('$t_{d}$')
ylabel('$x_{c}$')
%ylim([1e11 3e12])
leg = legend({'Pe=0.001' 'Pe=0.01' 'Pe=0.1' 'Pe=4'});
leg.Location = 'northwest';
leg.FontSize = 60;

lbl =yticklabels;
for i = 1 : length(lbl)
temp = sprintf('%.2f',str2num(char((lbl(i)))));

lbl(i) = cellstr(temp);
end
yticklabels(lbl)

pbaspect([2 1 1]);   F = getframe(fig);
imwrite(F.cdata, ['Center_mass_x.png'], 'png')
saveas(fig,['Center_mass_x.eps'], 'epsc')



fig = figure('name','Sigmaxx');
fig.Position =  get(0, 'Screensize');
fig.Color = 'w'; fig.Position = [1 1 3060 1844]; %fig.PaperUnits = 'normalized'; fig.PaperPosition =[0 0 1 1];

semilogx([Out0001.iteration]*t_d(1),[Out0001.SigmaXX],cell2mat(shapewline(1)),'color' ,col(1,:)) 
hold on
semilogx([Out001.iteration]*t_d(2),[Out001.SigmaXX],cell2mat(shapewline(2)),'color' ,col(2,:))
hold on
semilogx([Out01.iteration]*t_d(3),[Out01.SigmaXX],cell2mat(shapewline(3)),'color' ,col(3,:)) 
hold on
semilogx([Out4.iteration]*t_d(4),[Out4.SigmaXX],cell2mat(shapewline(4)),'color' ,col(4,:)) 
hold on
grid on

xlabel('$t_{d}$')
ylabel('$\sigma^{2}_{xx}$')
%ylim([1e11 3e12])
leg = legend({'Pe=0.001' 'Pe=0.01' 'Pe=0.1' 'Pe=4'});
leg.Location = 'northwest';
leg.FontSize = 60;

lbl =yticklabels;
for i = 1 : length(lbl)
temp = sprintf('%.2f',str2num(char((lbl(i)))));

lbl(i) = cellstr(temp);
end
yticklabels(lbl)


pbaspect([2 1 1]);   F = getframe(fig);
imwrite(F.cdata, ['Sigmaxx.png'], 'png')
saveas(fig,['Sigmaxx.eps'], 'epsc')



fig = figure('name','Sigmayy');
fig.Position =  get(0, 'Screensize');
fig.Color = 'w'; fig.Position = [1 1 3060 1844]; %fig.PaperUnits = 'normalized'; fig.PaperPosition =[0 0 1 1];

semilogy([Out0001.SigmaYY],[Out0001.iteration]*t_d(1),cell2mat(shapewline(1)),'color' ,col(1,:)) 
hold on
semilogy([Out001.SigmaYY],[Out001.iteration]*t_d(2),cell2mat(shapewline(2)),'color' ,col(2,:))
hold on
semilogy([Out01.SigmaYY],[Out01.iteration]*t_d(3),cell2mat(shapewline(3)),'color' ,col(3,:)) 
hold on
semilogy([Out4.SigmaYY],[Out4.iteration]*t_d(4),cell2mat(shapewline(4)),'color' ,col(4,:)) 
hold on
grid on

ylabel('$t_{d}$')
xlabel('$\sigma^{2}_{yy}$')
%ylim([1e11 3e12])
leg = legend({'Pe=0.001' 'Pe=0.01' 'Pe=0.1' 'Pe=4'});
leg.Location = 'northwest';
leg.FontSize = 60;

lbl =xticklabels;
for i = 1 : length(lbl)
temp = sprintf('%.2f',str2num(char((lbl(i)))));

lbl(i) = cellstr(temp);
end
xticklabels(lbl)


pbaspect([2 1 1]);   F = getframe(fig);
imwrite(F.cdata, ['Sigmayy.png'], 'png')
saveas(fig,['Sigmayy.eps'], 'epsc')


fig = figure('name','Sigmaxy');
fig.Position =  get(0, 'Screensize');
fig.Color = 'w'; fig.Position = [1 1 3060 1844]; %fig.PaperUnits = 'normalized'; fig.PaperPosition =[0 0 1 1];

semilogx([Out0001.iteration]*t_d(1),[Out0001.SigmaXY],cell2mat(shapewline(1)),'color' ,col(1,:)) 
hold on
semilogx([Out001.iteration]*t_d(2),[Out001.SigmaXY],cell2mat(shapewline(2)),'color' ,col(2,:))
hold on
semilogx([Out01.iteration]*t_d(3),[Out01.SigmaXY],cell2mat(shapewline(3)),'color' ,col(3,:)) 
hold on
semilogx([Out4.iteration]*t_d(4),[Out4.SigmaXY],cell2mat(shapewline(4)),'color' ,col(4,:)) 
hold on
grid on

xlabel('$t_{d}$')
ylabel('$\sigma^{2}_{xy}$')
%ylim([1e11 3e12])
leg = legend({'Pe=0.001' 'Pe=0.01' 'Pe=0.1' 'Pe=4'});
leg.Location = 'northwest';
leg.FontSize = 60;

lbl =yticklabels;
for i = 1 : length(lbl)
temp = sprintf('%.2f',str2num(char((lbl(i)))));

lbl(i) = cellstr(temp);
end
yticklabels(lbl)

pbaspect([2 1 1]);   F = getframe(fig);
imwrite(F.cdata, ['Sigmaxy.png'], 'png')
saveas(fig,['Sigmaxy.eps'], 'epsc')


%% Calculating the derivatives for dispersion coefficient tensor

% dt for iteration of 10000 for Pe = 0.001, Pe = 0.01, Pe = 0.1, Pe =4
dt(1) = 1e4*ud/(0.001*sigma);
dt(2) = 1e4*ud/(0.01*sigma);
dt(3) = 1e4*ud/(0.1*sigma);
dt(4) = 1e4*ud/(4*sigma);


fig = figure('name','diffSigmaxy');
fig.Position =  get(0, 'Screensize');
fig.Color = 'w'; fig.Position = [1 1 3060 1844]; %fig.PaperUnits = 'normalized'; fig.PaperPosition =[0 0 1 1];

% semilogx(([Out0001(2:end).iteration]*t_d(1)),diff([Out0001.SigmaXY]/sigma^2)/dt(1),cell2mat(shapewline(1)),'color' ,col(1,:)) 
% hold on
% semilogx(([Out001(2:end).iteration]*t_d(2)),diff([Out001.SigmaXY]/sigma^2)/dt(2),cell2mat(shapewline(2)),'color' ,col(2,:))
% hold on
% semilogx(([Out01(2:end).iteration]*t_d(3)),diff([Out01.SigmaXY]/sigma^2)/dt(3),cell2mat(shapewline(3)),'color' ,col(3,:)) 
% hold on
% semilogx(([Out4(2:end).iteration]*t_d(4)),diff([Out4.SigmaXY]/sigma^2)/dt(4),cell2mat(shapewline(4)),'color' ,col(4,:)) 
% hold on
% symlog(gca,'y',-9)
%yscale_symlog


semilogx(([Out0001(2:end).iteration]*t_d(1)),diff([Out0001.SigmaXY])/dt(1),cell2mat(shapewline(1)),'color' ,col(1,:)) 
hold on
semilogx(([Out001(2:end).iteration]*t_d(2)),diff([Out001.SigmaXY])/dt(2),cell2mat(shapewline(2)),'color' ,col(2,:))
hold on
semilogx(([Out01(2:end).iteration]*t_d(3)),diff([Out01.SigmaXY])/dt(3),cell2mat(shapewline(3)),'color' ,col(3,:)) 
hold on
semilogx(([Out4(2:end).iteration]*t_d(4)),diff([Out4.SigmaXY])/dt(4),cell2mat(shapewline(4)),'color' ,col(4,:)) 
hold on
symlog(gca,'y',-9)



lbl =yticklabels;
for i = 1 : 2 :length(lbl)
    i;
    if i < (length(lbl)-1)/2 +1
        temp = char(lbl(i));
        lab_temp = [temp(1:3) '$' temp(4:end) '$'];
        lbl(i) = cellstr(lab_temp);
    elseif i > (length(lbl)-1)/2 +1
        temp = char(lbl(i));
        lab_temp = [temp(1:2) '$' temp(3:end) '$'];
        lbl(i) = cellstr(lab_temp);
        
    end
end

yticklabels(lbl)


xlabel('$t_{d}$')
ylabel('$d \sigma^{2}_{d(xy)} \big/ dt_{d}$')
%set(gca,'YTickLabelMode','auto')

% ytickrange = yticklabels;
% ytickrange = str2double(ytickrange) - 1 ;
% yticklabels(num2cell(ytickrange))

%ylim([1e11 3e12])
leg = legend({'Pe=0.001' 'Pe=0.01' 'Pe=0.1' 'Pe=4'});
leg.Location = 'northeast';
leg.FontSize = 60;


pbaspect([2 1 1]);   F = getframe(fig);
imwrite(F.cdata, ['diffSigmaxy.png'], 'png')
saveas(fig,['diffSigmaxy.eps'], 'epsc')


fig = figure('name','diffSigmaXX');
fig.Position =  get(0, 'Screensize');
fig.Color = 'w'; fig.Position = [1 1 3060 1844]; %fig.PaperUnits = 'normalized'; fig.PaperPosition =[0 0 1 1];

% semilogx(([Out0001(2:end).iteration]*t_d(1)),diff([Out0001.SigmaXX]/sigma^2)/dt(1),cell2mat(shapewline(1)),'color' ,col(1,:)) 
% hold on
% semilogx(([Out001(2:end).iteration]*t_d(2)),diff([Out001.SigmaXX]/sigma^2)/dt(2),cell2mat(shapewline(2)),'color' ,col(2,:))
% hold on
% semilogx(([Out01(2:end).iteration]*t_d(3)),diff([Out01.SigmaXX]/sigma^2)/dt(3),cell2mat(shapewline(3)),'color' ,col(3,:)) 
% hold on
% semilogx(([Out4(2:end).iteration]*t_d(4)),diff([Out4.SigmaXX]/sigma^2)/dt(4),cell2mat(shapewline(4)),'color' ,col(4,:)) 
% hold on
% symlog(gca,'y',-9)
%yscale_symlog

semilogx(([Out0001(2:end).iteration]*t_d(1)),diff([Out0001.SigmaXX])/dt(1),cell2mat(shapewline(1)),'color' ,col(1,:)) 
hold on
semilogx(([Out001(2:end).iteration]*t_d(2)),diff([Out001.SigmaXX])/dt(2),cell2mat(shapewline(2)),'color' ,col(2,:))
hold on
semilogx(([Out01(2:end).iteration]*t_d(3)),diff([Out01.SigmaXX])/dt(3),cell2mat(shapewline(3)),'color' ,col(3,:)) 
hold on
semilogx(([Out4(2:end).iteration]*t_d(4)),diff([Out4.SigmaXX])/dt(4),cell2mat(shapewline(4)),'color' ,col(4,:)) 
hold on
symlog(gca,'y',-9)



lbl =yticklabels;
for i = 2 : 2 :length(lbl)
    i;
    if i < (length(lbl)-1)/2 +1
        temp = char(lbl(i));
        lab_temp = [temp(1:3) '$' temp(4:end) '$'];
        lbl(i) = cellstr(lab_temp);
    elseif i > (length(lbl)-1)/2 +1
        temp = char(lbl(i));
        lab_temp = [temp(1:2) '$' temp(3:end) '$'];
        lbl(i) = cellstr(lab_temp);
        
    end
end

yticklabels(lbl)


set(gca,'XTickLabel',{})
xlabel('$t_{d}$')
ylabel('$d \sigma^{2}_{d(xx)} \big/ dt_{d}$')
%set(gca,'YTickLabelMode','auto')

% ytickrange = yticklabels;
% ytickrange = str2double(ytickrange) - 1 ;
% yticklabels(num2cell(ytickrange))

%ylim([1e11 3e12])
leg = legend({'Pe=0.001' 'Pe=0.01' 'Pe=0.1' 'Pe=4'});
leg.Location = 'northeast';
leg.FontSize = 60;


pbaspect([2 1 1]);   F = getframe(fig);
imwrite(F.cdata, ['diffSigmaXX.png'], 'png')
saveas(fig,['diffSigmaXX.eps'], 'epsc')




fig = figure('name','diffSigmaYY');
fig.Position =  get(0, 'Screensize');
fig.Color = 'w'; fig.Position = [1 1 3060 1844]; %fig.PaperUnits = 'normalized'; fig.PaperPosition =[0 0 1 1];
% axes1 = axes('Parent',fig);


% semilogx(([Out0001(2:end).iteration]*t_d(1)),diff([Out0001.SigmaYY]/sigma^2)/dt(1),cell2mat(shapewline(1)),'color' ,col(1,:)) 
% hold on
% semilogx(([Out001(2:end).iteration]*t_d(2)),diff([Out001.SigmaYY]/sigma^2)/dt(2),cell2mat(shapewline(2)),'color' ,col(2,:))
% hold on
% semilogx(([Out01(2:end).iteration]*t_d(3)),diff([Out01.SigmaYY]/sigma^2)/dt(3),cell2mat(shapewline(3)),'color' ,col(3,:)) 
% hold on
% semilogx(([Out4(2:end).iteration]*t_d(4)),diff([Out4.SigmaYY]/sigma^2)/dt(4),cell2mat(shapewline(4)),'color' ,col(4,:)) 
% hold on
% symlog(gca,'y',-9)
%yscale_symlog


semilogy(diff([Out0001.SigmaYY])/dt(1),([Out0001(2:end).iteration]*t_d(1)),cell2mat(shapewline(1)),'color' ,col(1,:)) 
hold on
semilogy(diff([Out001.SigmaYY])/dt(2),([Out001(2:end).iteration]*t_d(2)),cell2mat(shapewline(2)),'color' ,col(2,:))
hold on
semilogy(diff([Out01.SigmaYY])/dt(3),([Out01(2:end).iteration]*t_d(3)),cell2mat(shapewline(3)),'color' ,col(3,:)) 
hold on
semilogy(diff([Out4.SigmaYY])/dt(4),([Out4(2:end).iteration]*t_d(4)),cell2mat(shapewline(4)),'color' ,col(4,:)) 
hold on
symlog(gca,'x',-9)


lbl =xticklabels;
for i = 2 : 2 :length(lbl)
    i;
    if i < (length(lbl)-1)/2 +1
        temp = char(lbl(i));
        lab_temp = [temp(1:3) '$' temp(4:end) '$'];
        lbl(i) = cellstr(lab_temp);
    elseif i > (length(lbl)-1)/2 +1
        temp = char(lbl(i));
        lab_temp = [temp(1:2) '$' temp(3:end) '$'];
        lbl(i) = cellstr(lab_temp);
        
    end
end

xticklabels(lbl)


ylabel('$t_{d}$')
xlabel('$d \sigma^{2}_{d(yy)} \big/ dt_{d}$')

%set(gca,'YTickLabelMode','auto')
% ytickrange = yticklabels;
% ytickrange = str2double(ytickrange) - 1 ;
% yticklabels(num2cell(ytickrange))


%ylim([1e11 3e12])
leg = legend({'Pe=0.001' 'Pe=0.01' 'Pe=0.1' 'Pe=4'});
leg.Location = 'northeast';
leg.FontSize = 60;

% ylim([2 10])
pbaspect([2 1 1]);   F = getframe(fig);
imwrite(F.cdata, ['diffSigmaYY.png'], 'png')
saveas(fig,['diffSigmaYY.eps'], 'epsc')


% 
% Out0001.dimenSigmaXX = [Out0001.SigmaXX]/sigma^2;
% Out001.dimenSigmaXX  = [Out001.SigmaXX]/sigma^2;
% Out01.dimenSigmaXX   = [Out01.SigmaXX]/sigma^2;
% Out4.dimenSigmaXX    = [Out4.SigmaXX]/sigma^2;
% 
% 
% 
% Out0001.DiffdimenSigmaXX = diff([Out0001.dimenSigmaXX],[Out0001.iteration]*t_d(1));
% Out001.DiffdimenSigmaXX  = diff([Out001.dimenSigmaXX], [Out001.iteration]*t_d(1));
% Out01.DiffdimenSigmaXX   = diff([Out01.dimenSigmaXX],  [Out01.iteration]*t_d(1));
% Out4.DiffdimenSigmaXX    = diff([Out4.dimenSigmaXX],   [Out4.iteration]*t_d(1));
% 
% 
% Out0001.dimenSigmaYY = [Out0001.SigmaYY]/sigma^2;
% Out001.dimenSigmaYY  = [Out001.SigmaYY]/sigma^2;
% Out01.dimenSigmaYY   = [Out01.SigmaYY]/sigma^2;
% Out4.dimenSigmaYY    = [Out4.SigmaYY]/sigma^2;
% 
% Out0001.DiffdimenSigmaYY = diff([Out0001.dimenSigmaYY],[Out0001.iteration]*t_d(1));
% Out001.DiffdimenSigmaYY  = diff([Out001.dimenSigmaYY], [Out001.iteration]*t_d(1));
% Out01.DiffdimenSigmaYY   = diff([Out01.dimenSigmaYY],  [Out01.iteration]*t_d(1));
% Out4.DiffdimenSigmaYY    = diff([Out4.dimenSigmaYY],   [Out4.iteration]*t_d(1));
% 
% 
% Out0001.dimenSigmaXY = [Out0001.SigmaXY]/sigma^2;
% Out001.dimenSigmaXY  = [Out001.SigmaXY]/sigma^2;
% Out01.dimenSigmaXY   = [Out01.SigmaXY]/sigma^2;
% Out4.dimenSigmaXY    = [Out4.SigmaXY]/sigma^2;
% 
% Out0001.DiffdimenSigmaXY = diff([Out0001.dimenSigmaXY],[Out0001.iteration]*t_d(1));
% Out001.DiffdimenSigmaXY  = diff([Out001.dimenSigmaXY], [Out001.iteration]*t_d(1));
% Out01.DiffdimenSigmaXY   = diff([Out01.dimenSigmaXY],  [Out01.iteration]*t_d(1));
% Out4.DiffdimenSigmaXY    = diff([Out4.dimenSigmaXY],   [Out4.iteration]*t_d(1));



%% Calculating the derivatives for mean velocity



%------------------------------------------------------------------------------------------------------------------------------------------------
% Adding value of 1 to the difference 

fig = figure('name','diffxc');
fig.Position =  get(0, 'Screensize');
fig.Color = 'w'; fig.Position = [1 1 3060 1844]; %fig.PaperUnits = 'normalized'; fig.PaperPosition =[0 0 1 1];

% semilogx(([Out0001(2:end).iteration]*t_d(1)),diff([Out0001.xc]/sigma)/dt(1),cell2mat(shapewline(1)),'color' ,col(1,:)) 
% hold on
% semilogx(([Out001(2:end).iteration]*t_d(2)),diff([Out001.xc]/sigma)/dt(2),cell2mat(shapewline(2)),'color' ,col(2,:)) 
% hold on
% semilogx(([Out01(2:end).iteration]*t_d(3)),diff([Out01.xc]/sigma)/dt(3),cell2mat(shapewline(3)),'color' ,col(3,:)) 
% hold on
% semilogx(([Out4(2:end).iteration]*t_d(4)),diff([Out4.xc]/sigma)/dt(4),cell2mat(shapewline(4)),'color' ,col(4,:)) 
% hold on
% symlog(gca,'y',-7)
%yscale_symlog



semilogx(([Out0001(2:end).iteration]*t_d(1)),diff([Out0001.xc])/dt(1),cell2mat(shapewline(1)),'color' ,col(1,:)) 
hold on
semilogx(([Out001(2:end).iteration]*t_d(2)),diff([Out001.xc])/dt(2),cell2mat(shapewline(2)),'color' ,col(2,:)) 
hold on
semilogx(([Out01(2:end).iteration]*t_d(3)),diff([Out01.xc])/dt(3),cell2mat(shapewline(3)),'color' ,col(3,:)) 
hold on
semilogx(([Out4(2:end).iteration]*t_d(4)),diff([Out4.xc])/dt(4),cell2mat(shapewline(4)),'color' ,col(4,:)) 
hold on
symlog(gca,'y',-7)



lbl =yticklabels;
for i = 2 : 2 :length(lbl)
    i;
    if i < (length(lbl)-1)/2 +1
        temp = char(lbl(i));
        lab_temp = [temp(1:3) '$' temp(4:end) '$'];
        lbl(i) = cellstr(lab_temp);
    elseif i > (length(lbl)-1)/2 +1
        temp = char(lbl(i));
        lab_temp = [temp(1:2) '$' temp(3:end) '$'];
        lbl(i) = cellstr(lab_temp);
        
    end
end

yticklabels(lbl)

set(gca,'XTickLabel',{})
xlabel('$t_{d}$')
ylabel('$d x_{c,d} \big/ d t_{d}$')
%set(gca,'YTickLabelMode','auto')

% ytickrange = yticklabels;
% ytickrange = str2double(ytickrange) - 1 ;
% yticklabels(num2cell(ytickrange))

%ylim([1e11 3e12])
leg = legend({'Pe=0.001' 'Pe=0.01' 'Pe=0.1' 'Pe=4'});
leg.Location = 'southeast';
leg.FontSize = 60;


pbaspect([2 1 1]);   F = getframe(fig);
imwrite(F.cdata, ['diffxc.png'], 'png')
saveas(fig,['diffxc.eps'], 'epsc')


fig1= fig;

fig = figure('name','diffyc');
fig.Position =  get(0, 'Screensize');
fig.Color = 'w'; fig.Position = [1 1 3060 1844]; %fig.PaperUnits = 'normalized'; fig.PaperPosition =[0 0 1 1];

% semilogx(([Out0001(2:end).iteration]*t_d(1)),diff([Out0001.yc]/sigma)/dt(1),cell2mat(shapewline(1)),'color' ,col(1,:)) 
% hold on
% semilogx(([Out001(2:end).iteration]*t_d(2)),diff([Out001.yc]/sigma)/dt(2),cell2mat(shapewline(2)),'color' ,col(2,:)) 
% hold on
% semilogx(([Out01(2:end).iteration]*t_d(3)),diff([Out01.yc]/sigma)/dt(3),cell2mat(shapewline(3)),'color' ,col(3,:)) 
% hold on
% semilogx(([Out4(2:end).iteration]*t_d(4)),diff([Out4.yc]/sigma)/dt(4),cell2mat(shapewline(4)),'color' ,col(4,:)) 
% hold on


semilogy(diff([Out0001.yc])/dt(1),([Out0001(2:end).iteration]*t_d(1)),cell2mat(shapewline(1)),'color' ,col(1,:)) 
hold on
semilogy(diff([Out001.yc])/dt(2),([Out001(2:end).iteration]*t_d(2)),cell2mat(shapewline(2)),'color' ,col(2,:)) 
hold on
semilogy(diff([Out01.yc])/dt(3),([Out01(2:end).iteration]*t_d(3)),cell2mat(shapewline(3)),'color' ,col(3,:)) 
hold on
semilogy(diff([Out4.yc])/dt(4),([Out4(2:end).iteration]*t_d(4)),cell2mat(shapewline(4)),'color' ,col(4,:)) 
hold on



symlog(gca,'x',-5)
%yscale_symlog

lbl =xticklabels;
for i = 1 : 1 :length(lbl)
    i;
    
    if i ~= (length(lbl)-1)/2 +1
        temp = char(lbl(i));
        lab_temp = [temp(1:2) '$' temp(3:end) '$'];
        lbl(i) = cellstr(lab_temp);
    end
end

xticklabels(lbl)



ylabel('$t_{d}$')
xlabel('$d y_{c,d} \big/ d t_{d}$')
%set(gca,'YTickLabelMode','auto')

% ytickrange = yticklabels;
% ytickrange = str2double(ytickrange) - 1 ;
% yticklabels(num2cell(ytickrange))

%ylim([1e11 3e12])
leg = legend({'Pe=0.001' 'Pe=0.01' 'Pe=0.1' 'Pe=4'});
leg.Location = 'northeast';
leg.FontSize = 60;


pbaspect([2 1 1]);   F = getframe(fig);
imwrite(F.cdata, ['diffyc.png'], 'png')
saveas(fig,['diffyc.eps'], 'epsc')

fig2= fig;

% pbaspect([2 1 1]); 
% fig = fig;
% fig.PaperUnits = 'inches';
% fig.PaperPosition = [0 0 6 3];
% F = getframe(fig);









