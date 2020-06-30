clear all
close all
clc

%% set figure properties

set(groot,'defaulttextinterpreter','latex');
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');


set(0,'DefaultTextFontSize', 40)
set(0,'DefaultAxesFontSize',50);
set(0,'DefaultLegendFontSize',20);
set(0,'DefaultLineMarkerSize', 20)
set(0,'DefaultLineLineWidth', 5)
% set(0,'DefaultMarkerMarkerSize', 5)
set(0,'defaultUicontrolFontName', 'Arial')
set(0,'defaultUitableFontName', 'Arial')
set(0,'defaultAxesFontName', 'Arial')
set(0,'defaultTextFontName', 'Arial')
set(0,'defaultUipanelFontName', 'Arial')




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

files = dir('*.csv');


        for k=1:4

                
                % Importing data
                
                data= importdata(files(k).name,'/');
                output(k).name = files(k).name;                
                output(k).concentration = transp(reshape(data.data(:,1),[1680 2180]));
                
                % Concentration analysis
                
                Concent = output(k).concentration;
                conc_i = ff_hp.*output(k).concentration;
                [freaqConc1 , seriesConc] = hist(conc_i(:),200);
                indx2 = find(max(freaqConc1));
                output(k).ConcFlowFracHighPerm= seriesConc(indx2);

                
                %Concent = output(k).concentration;
                conc_i = ff_lp.*output(k).concentration;
                [freaqConc1 , seriesConc] = hist(conc_i(:),200);
                indx2 = find(max(freaqConc1));
                output(k).ConcFlowFracLowPerm= seriesConc(indx2);

                
                %Concent = output(k).concentration;
                conc_i = fd_hp.*output(k).concentration;
                [freaqConc1 , seriesConc] = hist(conc_i(:),200);
                indx2 = find(max(freaqConc1));
                output(k).ConcDeadFracHighPerm= seriesConc(indx2);

                
                %Concent = output(k).concentration;
                conc_i = fd_lp.*output(k).concentration;
                [freaqConc1 , seriesConc] = hist(conc_i(:),200);
                indx2 = find(max(freaqConc1));
                output(k).ConcDeadFracLowPerm= seriesConc(indx2);

                
                %Concent = output(k).concentration;
                conc_i = hp.*output(k).concentration;
                [freaqConc1 , seriesConc] = hist(conc_i(:),200);
                indx2 = find(max(freaqConc1));
                output(k).ConcMatHighPerm= seriesConc(indx2);

                
                
                %Concent = output(k).concentration;
                conc_i = lp.*output(k).concentration;
                [freaqConc1 , seriesConc] = hist(conc_i(:),200);
                indx2 = find(max(freaqConc1));
                output(k).ConcMatLowPerm= seriesConc(indx2);

%                 end
             end
            
  
    

    save(['output.mat'],'output','-v7.3')
    


disp('Job Finished')











%% plotting results


% D = ud * sigma /Pe
% t_d = iteration *ud/Pe*sigma
ud = 7.89075e-5;
sigma = 45;

t_d(1) = 1260e3*ud/(0.01*sigma);
t_d(2) = 1360e3*ud/(4*sigma);
t_d(3) = 1430e3*ud/(0.1*sigma);
t_d(4) = 1600e3*ud/(0.001*sigma);


fig = figure('position',[1 1 1240 1490]);
% fig.Position =  get(0, 'Screensize');
fig.Color = 'w';

[C h] = contourf(output(1).concentration,200, 'LineColor','none');
colormap magma
% colorbar
set(gca,'YTickLabel',[],'XTickLabel',[])
axis(gca, 'image')
set(gcf,'position',[1 1 1240 1490])
caxis([0 1])

% fig.PaperPositionMode = 'auto';
% fig_pos = fig.PaperPosition;
% fig.PaperSize = [fig_pos(3) fig_pos(4)];


F    = getframe(fig);
imwrite(F.cdata, ['Conc001' num2str(round(t_d(1)),2.1) '.png'], 'png')
saveas(fig,['Conc001' num2str(round(t_d(1)),2.1) '.eps'], 'epsc')




fig = figure('position',[1 1 1240 1490]);
% fig.Position =  get(0, 'Screensize');
fig.Color = 'w';

[C h] = contourf(output(2).concentration,200, 'LineColor','none');
colormap magma
% col = colorbar;
% col.Location = 'westoutside';
set(gca,'YTickLabel',[],'XTick',...
    [0 400 800 1200 1680],'XTickLabel',{'-840','-420','0','420','840'})
axis(gca, 'image')
set(gcf,'position',[1 1 1240 1490])
caxis([0 1])
xlabel('Width (lattices)')


% fig.PaperPositionMode = 'auto';
% fig_pos = fig.PaperPosition;
% fig.PaperSize = [fig_pos(3) fig_pos(4)];

F    = getframe(fig);
imwrite(F.cdata, ['Conc4' num2str(round(t_d(2)),2.1) '.png'], 'png')
saveas(fig,['Conc4' num2str(round(t_d(2)),2.1) '.eps'], 'epsc')



fig = figure('position',[1 1 1240 1490]);
% fig.Position =  get(0, 'Screensize');
fig.Color = 'w';

[C h] = contourf(output(3).concentration,200, 'LineColor','none');
colormap magma
% colorbar
% set(gca,'YTickLabel',[],'XTickLabel',[])
axis(gca, 'image')
set(gcf,'position',[1 1 1240 1490])
set(gca,'XTick',...
    [0 400 800 1200 1680],'XTickLabel',{'-840','-420','0','420','840'},'YTick',...
    [0 400 800 1200 1600 2180],'YTickLabel',...
    {'0','400','800','1200','1600','2180'});

% fig.PaperPositionMode = 'auto';
% fig_pos = fig.PaperPosition;
% fig.PaperSize = [fig_pos(3) fig_pos(4)];

xlabel('Width (lattices)')
ylabel('Length (lattices)')


F    = getframe(fig);
imwrite(F.cdata, ['Conc01' num2str(round(t_d(3)),2.1) '.png'], 'png')
saveas(fig,['Conc01' num2str(round(t_d(3)),2.1) '.eps'], 'epsc')




fig = figure('position',[1 1 1240 1490]);
% fig.Position =  get(0, 'Screensize');
fig.Color = 'w';

[C h] = contourf(output(4).concentration,200, 'LineColor','none');
colormap magma
% colorbar
set(gca,'XTickLabel',[],'YTick',...
    [0 400 800 1200 1600 2180],'YTickLabel',...
    {'0','400','800','1200','1600','2180'});

axis(gca, 'image')
set(gcf,'position',[1 1 1240 1490])
% fig.PaperPositionMode = 'auto';
% fig_pos = fig.PaperPosition;
% fig.PaperSize = [fig_pos(3) fig_pos(4)];

ylabel('Length (lattices)')

F    = getframe(fig);
imwrite(F.cdata, ['Conc0001' num2str(round(t_d(4)),2.1) '.png'], 'png')
saveas(fig,['Conc0001' num2str(round(t_d(4)),2.1) '.eps'], 'epsc')
    
    
%     figure
% colors = ['y' 'm' 'c' 'r' 'g' 'b'];
%
% leg = ['Flow fracture - High-perm' , 'Flow fracture - Low-perm', ...
%        'Dead-end - high-perm',       'Dead-end - low-perm',      ...
%        'Matrix - high-perm',         'Matrix - low-perm'];
%
%    font = 20;
%
% for i = 1:c
%
%     figure(1)
%     plot(i,(VelX(i).ff_hp(2)-VelX(i).ff_hp(1)),['o' colors(1)])
%     hold on
%
%     plot(i,(VelX(i).ff_lp(2)-VelX(i).ff_lp(1)),['o' colors(2)])
%     hold on
%
%     plot(i,(VelX(i).fd_hp(2)-VelX(i).fd_hp(1)),['o' colors(3)])
%     hold on
%
%     plot(i,(VelX(i).fd_lp(2)-VelX(i).fd_lp(1)),['o' colors(4)])
%     hold on
%
%     plot(i,(VelX(i).hp(2)-VelX(i).hp(1)),['o' colors(5)])
%     hold on
%
%     plot(i,(VelX(i).lp(2)-VelX(i).lp(1)),['o' colors(6)])
%     hold on
%
%     if i == 1
%         legend('Flow fracture - High-perm' , 'Flow fracture - Low-perm', ...
%        'Dead-end - high-perm',       'Dead-end - low-perm',      ...
%        'Matrix - high-perm',         'Matrix - low-perm')
%        ylabel('Change in x velocity','Interpreter','latex')
%        set(gca,'XMinorTick','off','XTick',[1:16],'XTickLabel',name)
%     end
%
%
%     figure(2)
%     plot(i,(VelY(i).ff_hp(2)-VelY(i).ff_hp(1)),['o' colors(1)])
%     hold on
%
%     plot(i,(VelY(i).ff_lp(2)-VelY(i).ff_lp(1)),['o' colors(2)])
%     hold on
%
%     plot(i,(VelY(i).fd_hp(2)-VelY(i).fd_hp(1)),['o' colors(3)])
%     hold on
%
%     plot(i,(VelY(i).fd_lp(2)-VelY(i).fd_lp(1)),['o' colors(4)])
%     hold on
%
%     plot(i,(VelY(i).hp(2)-VelY(i).hp(1)),['o' colors(5)])
%     hold on
%
%     plot(i,(VelY(i).lp(2)-VelY(i).lp(1)),['o' colors(6)])
%     hold on
%
%     if i == 1
%         legend('Flow fracture - High-perm' , 'Flow fracture - Low-perm', ...
%        'Dead-end - high-perm',       'Dead-end - low-perm',      ...
%        'Matrix - high-perm',         'Matrix - low-perm')
%        ylabel('Change in y velocity','Interpreter','latex')
%        set(gca,'XMinorTick','off','XTick',[1:16],'XTickLabel',name)
%     end
%
%
%     figure(3)
%     plot(i,(Porosity(i).ff_hp(2)-Porosity(i).ff_hp(1))/Porosity(i).ff_hp(1),['o' colors(1)])
%     hold on
%
%     plot(i,(Porosity(i).ff_lp(2)-Porosity(i).ff_lp(1))/Porosity(i).ff_lp(1),['o' colors(2)])
%     hold on
%
%     plot(i,(Porosity(i).fd_hp(2)-Porosity(i).fd_hp(1))/Porosity(i).fd_hp(1),['o' colors(3)])
%     hold on
%
%     plot(i,(Porosity(i).fd_lp(2)-Porosity(i).fd_lp(1))/Porosity(i).fd_lp(1),['o' colors(4)])
%     hold on
%
%     plot(i,(Porosity(i).hp(2)-Porosity(i).hp(1))/Porosity(i).hp(1),['o' colors(5)])
%     hold on
%
%     plot(i,(Porosity(i).lp(2)-Porosity(i).lp(1))/Porosity(i).lp(1),['o' colors(6)])
%     hold on
%
%     set(gca,'YScale','log')
%
%
%
%     if i == 1
%         legend('Flow fracture - High-perm' , 'Flow fracture - Low-perm', ...
%        'Dead-end - high-perm',       'Dead-end - low-perm',      ...
%        'Matrix - high-perm',         'Matrix - low-perm')
%
%        ylabel('Change in Porosity (log scale)','Interpreter','latex')
%        set(gca,'XMinorTick','on','XTick',[1:16],'XTickLabel',name)
%     end
%
%
% end
%
%
% % set(gca,'XMinorTick','on','XTick',[1:16],'XTickLabel',name)
%
%
%
% % figure(1)
% % fig.Color = 'w';
% %
% %
% %
% %
% %
% %
% % fig.Color = 'w';
% % [series1 , series2] = hist(u_frac(:),200);
% % [series3] = hist(u_mat(:),series2);
% %
% % bar(series2,series1,0.8,'FaceColor','r','EdgeColor','none');
% % hold on
% % bar(series2,series3,0.5,'FaceColor','b','EdgeColor','none');
% % hold off
% % legend('Velocity in fractures','Velocity in matrices')
% % xlabel('Velocity in x direction $[\frac{mm}{sec}$]','Interpreter','latex')
% % ylabel('Frequency (log scale)','Interpreter','latex')
% % set(gca,'YScale','log','YGrid','on','XGrid','on')
% % set(gca,'XMinorTick','on','XTick',...
% %     [-0.01 0 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1 0.11 0.12 ])
% %
% % ylim([10 10000])
% % xlim([-0.01 0.12])
% % F    = getframe(fig);
% % imwrite(F.cdata, 'low-x_histogram.png', 'png')
% % saveas(fig,'low-x_histogram.eps', 'epsc')







