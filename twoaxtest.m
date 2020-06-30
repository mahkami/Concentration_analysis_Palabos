% Adding value of 1 to the difference 

fig = figure('name','diffxc');
fig.Position =  get(0, 'Screensize');
fig.Color = 'w'; %fig.Position = [1 1 3060 1844]; %fig.PaperUnits = 'normalized'; fig.PaperPosition =[0 0 1 1];

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

% [0.1 0.2 0.8 0.35]

ax1 = axes('Position', [0.16 0.53 0.75 0.4]);
hold(ax1,'on');

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

set(gca,'XAxisLocation','top')
xlabel(['\color{white} t_{d}'],'interpreter','tex')

% set(gca,'XTickLabel',{})
%xlabel('$t_{d}$')
ylabel('$d x_{c,d} \big/ d t_{d}$')
%set(gca,'YTickLabelMode','auto')

% ytickrange = yticklabels;
% ytickrange = str2double(ytickrange) - 1 ;
% yticklabels(num2cell(ytickrange))

%ylim([1e11 3e12])
leg = legend({'Pe=0.001' 'Pe=0.01' 'Pe=0.1' 'Pe=4'});
leg.Location = 'northeast';
leg.FontSize = 60;


% %set(gca,'Position', [0.1300 0.1337 0.7750 0.7913],'OuterPosition', [0 0.0263 1 0.9715]); F = getframe(fig); %pbaspect([2 1 1]); 
% imwrite(F.cdata, ['diffxc.png'], 'png')
% saveas(fig,['diffxc.eps'], 'epsc')


% fig1= fig;
% 
% fig = figure('name','diffyc');
% fig.Position =  get(0, 'Screensize');
% fig.Color = 'w'; %fig.Position = [1 1 3060 1844]; %fig.PaperUnits = 'normalized'; fig.PaperPosition =[0 0 1 1];

% semilogx(([Out0001(2:end).iteration]*t_d(1)),diff([Out0001.yc]/sigma)/dt(1),cell2mat(shapewline(1)),'color' ,col(1,:)) 
% hold on
% semilogx(([Out001(2:end).iteration]*t_d(2)),diff([Out001.yc]/sigma)/dt(2),cell2mat(shapewline(2)),'color' ,col(2,:)) 
% hold on
% semilogx(([Out01(2:end).iteration]*t_d(3)),diff([Out01.yc]/sigma)/dt(3),cell2mat(shapewline(3)),'color' ,col(3,:)) 
% hold on
% semilogx(([Out4(2:end).iteration]*t_d(4)),diff([Out4.yc]/sigma)/dt(4),cell2mat(shapewline(4)),'color' ,col(4,:)) 
% hold on


ax2 = axes('Position',[0.16 0.1 0.75 0.4 ]);
hold(ax2, 'on')

semilogx(([Out0001(2:end).iteration]*t_d(1)),diff([Out0001.yc])/dt(1),cell2mat(shapewline(1)),'color' ,col(1,:)) 
hold on
semilogx(([Out001(2:end).iteration]*t_d(2)),diff([Out001.yc])/dt(2),cell2mat(shapewline(2)),'color' ,col(2,:)) 
hold on
semilogx(([Out01(2:end).iteration]*t_d(3)),diff([Out01.yc])/dt(3),cell2mat(shapewline(3)),'color' ,col(3,:)) 
hold on
semilogx(([Out4(2:end).iteration]*t_d(4)),diff([Out4.yc])/dt(4),cell2mat(shapewline(4)),'color' ,col(4,:)) 
hold on



symlog(gca,'y',-5)
%yscale_symlog

lbl =yticklabels;
for i = 1 : 1 :length(lbl)
    i;
    
    if i ~= (length(lbl)-1)/2 +1
        temp = char(lbl(i));
        lab_temp = [temp(1:2) '$' temp(3:end) '$'];
        lbl(i) = cellstr(lab_temp);
    end
end

yticklabels(lbl)



xlabel('$t_{d}$')
ylabel('$d y_{c,d} \big/ d t_{d}$')
%set(gca,'YTickLabelMode','auto')
% ylim([-0.31 6])
% ytickrange = yticklabels;
% ytickrange = str2double(ytickrange) - 1 ;
% yticklabels(num2cell(ytickrange))

%ylim([1e11 3e12])
leg = legend({'Pe=0.001' 'Pe=0.01' 'Pe=0.1' 'Pe=4'});
leg.Location = 'northeast';
leg.FontSize = 60;


% set(gca,'Position', [0.1300 0.1337 0.7750 0.7913],'OuterPosition', [0 0.0263 1 0.9715]); F = getframe(fig); %pbaspect([2 1 1]); 
imwrite(F.cdata, ['diffyc.png'], 'png')
saveas(fig,['diffyc.eps'], 'epsc')

fig2= fig;

% pbaspect([2 1 1]); 
% fig = fig;
% fig.PaperUnits = 'inches';
% fig.PaperPosition = [0 0 6 3];
% F = getframe(fig);

