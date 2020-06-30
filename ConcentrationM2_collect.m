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
set(0,'DefaultLineMarkerSize', 20)
set(0,'DefaultLineLineWidth', 5)
% set(0,'DefaultMarkerMarkerSize', 5)
set(0,'defaultUicontrolFontName', 'Arial')
set(0,'defaultUitableFontName', 'Arial')
set(0,'defaultAxesFontName', 'Arial')
set(0,'defaultTextFontName', 'Arial')
set(0,'defaultUipanelFontName', 'Arial')


% dest = pwd;

%% List of all the data sets
% Complete data is the first set
% Fold ={'3D_sim_Pe001','3D_sim_Pe01' ,'3D_sim_Pe0001' ,'3D_sim_Pe1','3D_sim_Pe4'};
Fold ={'3D_sim_Pe001','3D_sim_Pe01' ,'3D_sim_Pe0001','3D_sim_Pe4'};
% Fold ={'3D_sim_Pe0001','3D_sim_Pe1','3D_sim_Pe4'};
% Fold ={'3D_sim_Pe4'};
% Fold ={'3D_sim_Pe0001'};

% pref ={'Pe001Da',      'Pe01Da' ,'Pe0001Da' ,   'Pe1Da',  'Pe4Da'};
 pref ={'Pe001Da', 'Pe01Da' ,'Pe0001Da',  'Pe4Da'};
% pref ={'Pe4Da'};
% pref ={'Pe0001Da'};

Pe   =[0.01,0.1,0.001,4];
% Pe   =[0.001,1,4];
% Pe   =[4];
% Pe = [0.001];

%tail ={'0', '0001', '001', '01', '1', '2_5', '4'};
tail ={'0'};
% tail ={'10'};
% Da   =[0,0.001,0.01,0.1,1,2.5,4,10];
% Da   =[10];
Da = [0];

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




Coord_mat = zeros(2180,1680); 


mid_point = 1680/2;


for yy = 1:2180
    for xx = 1:1680
        
    M2XX(yy,xx)  = mid_point^(-2)*(xx-mid_point)^2;
    M2YY(yy,xx)  = 2180^(-2)*yy^2;
    M2XY(yy,xx) = yy*(xx-mid_point)/(2180*mid_point);    
        
    end
end



for yy = 1:2180
    for xx = 1:1680
        
    M1XX(yy,xx)  = mid_point^(-1)*(xx-mid_point);
    M1YY(yy,xx)  = 2180^(-1)*yy;
 
    end
end





save coordmat.mat M2XX M2YY M2XY M1XX M1YY



%%
 t = 0;
for i = 1:length(Fold)
        
        
        %nas address in mac
        % dest = ['/Volumes/erdw_ifg_saar_home_01$/mahkami/Simulations/Pallabos/',char(Fold(i)),'/',char(pref(i))];
        
        % nas address in Euler
%         dest = ['/cluster/home/mahkami/nas_home/Simulations/Pallabos/',char(Fold(i)),'/',char(pref(i))];
        
        % Euler destination
          %dest = ['/cluster/scratch/mahkami/Post_process/',char(Fold(i)),'/',char(pref(i))];
          
          
          % External hdd
%            dest = ['/Volumes/Mac only backp/Simulations/Pallabos/Pallabos_v4/',char(Fold(i)),'/',char(pref(i))];

           % dest = ['/Volumes/Mac only backp/Simulations/Pallabos/Pallabos_v4/',char(Fold(i)),'/',char(pref(i))];
           
           dest = ['/cluster/scratch/mahkami/',char(Fold(i)),'/',char(pref(i))];

        %nas in lab windows machine\\
        
%          dest = ['Y:\mahkami\Simulations\Pallabos\',char(Fold(i)),'\',char(pref(i))];
        dest2 = [dest,char(tail(1))];
        cd(dest2)

        files = dir('Order*');
      
        
        permDat = importdata('permeabilityEvolution.txt');
        for k=1:(length(permDat(:,1))-2)
%          for k=1:numel(files)
            t = t+1
%             dest2
            
             if files(k).bytes >= 100000000
                
             

               file_n = ['Order.' num2str(k) '.csv'];
                
               % data= importdata(files(t).name,'/');
                data= importdata(file_n,'/');
                output(t).name = file_n;
                output(t).Pe = Pe(i);
                output(t).Da = 0;
                output(t).iteration= (t-1)*10000;
                
                % output(t).solidfrac = transp(reshape(data.data(:,6),[1680 2180]));
%                 idx  = find(output(1).solidfrac >= 0.5);
%                 idx2 = find(output(1).solidfrac < 0.5);
%                 output(1).solidfrac(idx) = 1;
%                 output(1).solidfrac(idx2) =0;               
                output(t).concentration = transp(reshape(data.data(:,1),[1680 2180]));
                
                output(t).concentration = (output(t).concentration - 0.1)/0.9;

                        tempXX = times( output(t).concentration,M2XX);
                        tempYY = times( output(t).concentration,M2YY);
                        tempXY = times( output(t).concentration,M2XY);

                        output(t).M2XX = sum(tempXX(:));
                        output(t).M2YY = sum(tempYY(:));
                        output(t).M2XY = sum(tempXY(:));

                        
                        temp1XX = times( output(t).concentration,M1XX);
                        temp1YY = times( output(t).concentration,M1YY);

                        output(t).M1XX = sum(temp1XX(:));
                        output(t).M1YY = sum(temp1YY(:));
                        

                        M0 = output(t).concentration;
                        output(t).M0 = sum(M0(:));
                        
                        output(t).xc = output(t).M1XX/output(t).M0;
                        output(t).yc = output(t).M1YY/output(t).M0;
                        
                        
                        output(t).SigmaYY = output(t).M2YY/output(t).M0 - (output(t).yc)^2;
                        output(t).SigmaXX = output(t).M2XX/output(t).M0 - (output(t).xc)^2;
                        output(t).SigmaXY = output(t).M2XY/output(t).M0 - output(t).xc*output(t).yc;
                        
                                           
                       
                        


                
                
%                 % Concentration analysis
%                 
%                 Concent = output(1).concentration;
%                 conc_i = ff_hp.*output(1).concentration;
%                 [freaqConc1 , seriesConc] = hist(conc_i(:),200);
%                 indx2 = find(max(freaqConc1));
%                 output(1).ConcFlowFracHighPerm= seriesConc(indx2);
%               analysis(t).ConcFlowFracHighPerm= seriesConc(indx2);
%                 
%                 %Concent = output(1).concentration;
%                 conc_i = ff_lp.*output(1).concentration;
%                 [freaqConc1 , seriesConc] = hist(conc_i(:),200);
%                 indx2 = find(max(freaqConc1));
%                 output(1).ConcFlowFracLowPerm= seriesConc(indx2);
%               analysis(t).ConcFlowFracLowPerm= seriesConc(indx2);
%                 
%                 %Concent = output(1).concentration;
%                 conc_i = fd_hp.*output(1).concentration;
%                 [freaqConc1 , seriesConc] = hist(conc_i(:),200);
%                 indx2 = find(max(freaqConc1));
%                 output(1).ConcDeadFracHighPerm= seriesConc(indx2);
%               analysis(t).ConcDeadFracHighPerm= seriesConc(indx2);
%                 
%                 %Concent = output(1).concentration;
%                 conc_i = fd_lp.*output(1).concentration;
%                 [freaqConc1 , seriesConc] = hist(conc_i(:),200);
%                 indx2 = find(max(freaqConc1));
%                 output(1).ConcDeadFracLowPerm= seriesConc(indx2);
%               analysis(t).ConcDeadFracLowPerm= seriesConc(indx2);
%                 
%                 %Concent = output(1).concentration;
%                 conc_i = hp.*output(1).concentration;
%                 [freaqConc1 , seriesConc] = hist(conc_i(:),200);
%                 indx2 = find(max(freaqConc1));
%                 output(1).ConcMatHighPerm= seriesConc(indx2);
%               analysis(t).ConcMatHighPerm= seriesConc(indx2);
%                 
%                 
%                 %Concent = output(1).concentration;
%                 conc_i = lp.*output(1).concentration;
%                 [freaqConc1 , seriesConc] = hist(conc_i(:),200);
%                 indx2 = find(max(freaqConc1));
%                 output(1).ConcMatLowPerm= seriesConc(indx2);
%               analysis(t).ConcMatLowPerm= seriesConc(indx2);
% %                 end
             end
            
            
        end

    %saveDest = 'Y:\mahkami\Simulations\Pallabos\PostProccessing';
    
    
    
disp(['saving' 'output' char(Fold(i)) '.mat'])
 
    % External hdd 
%  saveDest = '/Volumes/Mac only backp/Simulations/Pallabos/Pallabos_v4/Concentration';
 saveDest = '/cluster/scratch/mahkami/Concentration';
 
cd(saveDest)

    save(['Output_' char(Fold(i)) '.mat'],'output','-v7.3')
    
    clear output 
    t = 0;
end




%nas destination in mac
% saveDest = '/Volumes/erdw_ifg_saar_home_01$/mahkami/Simulations/Pallabos/PostProccessing';

% nas destination in Euler
% saveDest = '/cluster/home/mahkami/nas_home/Simulations/Pallabos/PostProccessing';
%

% External hdd 
% saveDest = '/Volumes/Mac only backp/Simulations/Pallabos/Pallabos_v4/Permeability';
% 
% cd(saveDest)
% save('Output.mat','output','-v7.3')
% 
% disp('Job Finished')




% for i =1:50
%     
%     conc = Out01(i).concentration;
%     idx = find(conc ==0.1);
%     conc(idx) =0;
%     
%     %plot(i,sum(conc(:)), '+')
%     %hold on
%     
%     figure(100)
%     contourf(conc)
%     drawnow
%     
%     
% %     sum_conc = sum_conc + sum(conc(:));
% end 
    




