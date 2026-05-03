function PlotV
clc;clear;
close all;

set(0,'DefaultAxesFontName','Calibri')
set(0,'DefaultAxesFontAngle','italic')
set(0,'DefaultTextFontName','Calibri')
set(0,'DefaultTextFontAngle','italic')

figure;
hold;
test1 = load('SanthakumarWallB(2.0).txt');
test2 = load('SanthakumarWallB2(2.0).txt');
test = [test1; test2];
% dir = '_ResultsRAS.1.0.0.done';
% dir1  = 'TrussReducedArea_NoTruss2.1.0.0.done';
% dir1  = 'Truss_hysteretic.1.0.0.done';
dir1  = 'TrussDRCB.1.0.0.done';
dir2  = 'SpringV.1.0.0.done';
% dir1  = 'BTM_cal.1.0.0.done';
% disp = load([dir '/Disp.txt']);
disp1 = load([dir1 '/Disp.txt']);
disp2 = load([dir2 '/Disp.txt']);

offDisp = 0.038446;
% disp = disp(:,2) - offDisp;
disp1 = disp1(:,2) - offDisp;
disp2 = disp2(:,2) - offDisp;
% ReaX = load([dir '/ReaX.txt']);
% ReaX = sum(-ReaX(:,2:end),2);
ReaX1 = load([dir1 '/ReaX.txt']);
ReaX1W1 = sum(-ReaX1(:,2:5),2);
ReaX1W2 = sum(-ReaX1(:,6:9),2);
ReaX1 = sum(-ReaX1(:,2:end),2);
ReaX2 = load([dir2 '/ReaX.txt']);
ReaX2W1 = sum(-ReaX2(:,2:5),2);
ReaX2W2 = sum(-ReaX2(:,6:9),2);
ReaX2 = sum(-ReaX2(:,2:end),2);

ReaY1 = load([dir1 '/ReaX.txt']);
ReaY1W1 = sum(-ReaY1(:,2:5),2);
ReaY1W2 = sum(-ReaY1(:,6:9),2);
ReaY1 = sum(-ReaY1(:,2:end),2);
ReaY2 = load([dir2 '/ReaX.txt']);
ReaY2W1 = sum(-ReaY2(:,2:5),2);
ReaY2W2 = sum(-ReaY2(:,6:9),2);
ReaY2 = sum(-ReaY2(:,2:end),2);

aux = find(test(:,1)<-5);
aux = sort(aux,'descend');
testPartial = test;

for i=1:length(aux)
    testPartial(aux(i),:) = [];
end

ind1 = find(disp1<-5,1);
ind2 = find(disp2<-5,1);

Vstr = 56.6;
% plot(test(:,1)*25.4,test(:,2)*4.4482216*Vstr,'.','linewidth',1,'color',[0.75 0.75 0.75 0.5],'MarkerSize',12);
plot(testPartial(:,1)*25.4,testPartial(:,2)*4.4482216*Vstr,'.','linewidth',1,'color',[0.75 0.75 0.75 0.5],'MarkerSize',12);
plt1 = plot([0 0],[0 0],'-','linewidth',2,'color',[0.6 0.6 0.6]);
% plt2 = plot(disp(:,1)*25.4,ReaX(:,1)*4.4482216,'k','linewidth',1.3);
plt3 = plot(disp1(1:ind1,1)*25.4,ReaX1(1:ind1,1)*4.4482216,'b','linewidth',1);
plt4 = plot(disp2(1:ind2,1)*25.4,ReaX2(1:ind2,1)*4.4482216,':','color',[0.85 0.33 0.10],'linewidth',2);
% text(-40,185,'5(0.62)','FontSize',10);
% text(2,-217,'6(0.61)','FontSize',10);
% text(10,338,'9(0.60)','FontSize',10);
% text(-48,-320,'10(0.58)','FontSize',10);
% text(40,370,'11(0.57)','FontSize',10);
% text(-98,-325,'12(0.57)','FontSize',10);
% text(75,330,'13(0.58)','FontSize',10);
% text(-148,-330,'14(0.58)','FontSize',10);
% text(105,370,'15(0.58)','FontSize',10);
% text(-195,-330,'16(0.60)','FontSize',10);

mElast = 100/4.56;
yminElast = -303.3;
ymaxElast = 298;
xminElast = yminElast/mElast;
xmaxElast = ymaxElast/mElast;
% plt3 = plot([xminElast xmaxElast],[yminElast ymaxElast],'k--','linewidth',1.3);

set(gcf, 'Position', [100, 100, 700, 500])
ax1 = gca;
ax1.Position = [0.1300 0.1650 0.55 0.68];
%ax1.Position = [0.1300 0.1500 0.60 0.75];
ax1_pos = ax1.Position;
grid on;
ax = gca;
ax.GridLineStyle = '-';
%ax.GridColor = [0.1,0.1,0.1];
ax.GridAlpha = 0.2;
ax.LineWidth = 1.2;
set(gca,'TickLength',[0 0]);

set(gca,'fontsize',13);
%title({'Lateral Force - Top Displacement';'';''});
xlabel('Roof Displacement (mm)');
ylabel('Base Shear, V (kN)');
xlim([-150 150]);
ylim([-400 400]);
plot(xlim,[0 0],'k','linewidth',1);
plot([0 0],ylim,'k','linewidth',1);
%legend([plt1,plt2,plt3],'Test','BTM','Linear','location','southeast');
% legend([plt1,plt2,plt3],'Test','EBTM','Truss','RAS','location','southeast');
% legend([plt1,plt2,plt3,plt4],'Test','EBTM','Truss','Spring M','location','southeast');
legend([plt1,plt3,plt4],'Test','Truss','Spring V','location','southeast');
xlim_ax1 = xlim;
ylim_ax1 = ylim;
if 1
axes('Position',ax1_pos,'XAxisLocation','top','YAxisLocation','right','Color','none');
% axes('XAxisLocation','top','YAxisLocation','right','Color','none');
set(gca,'fontsize',12);
xlabel('Roof Drift Ratio (%)');
xlim([xlim_ax1(1)/5257.80*100, xlim_ax1(2)/5257.80*100]);
ylabel('Lateral Load Ratio, V/V*');
ylim([ylim_ax1(1)/(4.4482216*Vstr), ylim_ax1(2)/(4.4482216*Vstr)]);
ax = gca;
ax.LineWidth = 1.2;

Acw = 102*610; %mm2
fc = 30;    %MPa
norm = Acw*sqrt(fc)/1000;
H = 5486; %mm

figure
set(gcf, 'Position', [100, 100, 1000, 400])
subplot(1,2,1)
hold on
grid minor
grid on
box on
set(gca,'fontsize',13);
% plt1 = plot(test(:,1)*25.4,test(:,2)*4.4482216*Vstr,'.','linewidth',1,'color',[0.75 0.75 0.75 0.5],'MarkerSize',12);
plt2 = plot(disp1(1:ind1,1)*25.4/H*100,ReaX1W1(1:ind1,1)*4.4482216/norm,'color',[0 0 1],'linewidth',1);
plt3 = plot(disp2(1:ind2,1)*25.4/H*100,ReaX2W1(1:ind2,1)*4.4482216/norm,':','color',[0.85 0.33 0.10],'linewidth',2);
title('Wall 1')
% xlabel('Roof Displacement (mm)');
% ylabel('Base Shear, V (kN)');
xlabel('Roof Drift Ratio (%)');
ylabel('$\frac{V}{A_{cw}\sqrt{f''_{c} (MPa)}}$','interpreter','latex','fontsize',16)
% xlim([-200 150]);
% ylim([-400 400]);
xlim([-3 3]);
ylim([-1 1]);
plot(xlim,[0 0],'k','linewidth',1);
plot([0 0],ylim,'k','linewidth',1);
% legend([plt1,plt2,plt3],'Test','Truss','Spring V','location','southeast');
legend([plt2,plt3],'Truss','Spring V','location','southeast');


subplot(1,2,2)
hold on
grid minor
grid on
box on
set(gca,'fontsize',13);
% plt1 = plot(test(:,1)*25.4,test(:,2)*4.4482216*Vstr,'.','linewidth',1,'color',[0.75 0.75 0.75 0.5],'MarkerSize',12);
plt2 = plot(disp1(1:ind1,1)*25.4/H*100,ReaX1W2(1:ind1,1)*4.4482216/norm,'color',[0 0 1],'linewidth',1);
plt3 = plot(disp2(1:ind2,1)*25.4/H*100,ReaX2W2(1:ind2,1)*4.4482216/norm,':','color',[0.85 0.33 0.10],'linewidth',2);
title('Wall 2')
% xlabel('Roof Displacement (mm)');
% ylabel('Base Shear, V (kN)');
xlabel('Roof Drift Ratio (%)');
ylabel('$\frac{V}{A_{cw}\sqrt{f''_{c} (MPa)}}$','interpreter','latex','fontsize',16)
% xlim([-200 150]);
% ylim([-400 400]);
xlim([-3 3]);
ylim([-1 1]);
plot(xlim,[0 0],'k','linewidth',1);
plot([0 0],ylim,'k','linewidth',1);
% legend([plt1,plt2,plt3],'Test','Truss','Spring V','location','southeast');
legend([plt2,plt3],'Truss','Spring V','location','southeast');

figure
set(gcf, 'Position', [100, 100, 1000, 400])
subplot(1,2,1)
hold on
grid minor
grid on
box on
set(gca,'fontsize',13);
% plt1 = plot(test(:,1)*25.4,test(:,2)*4.4482216*Vstr,'.','linewidth',1,'color',[0.75 0.75 0.75 0.5],'MarkerSize',12);
plt2 = plot(disp1(1:ind1,1)*25.4/H*100,ReaX1W1(1:ind1,1)*4.4482216/norm,'color',[0 0 1],'linewidth',1);
plt3 = plot(disp2(1:ind2,1)*25.4/H*100,ReaX2W1(1:ind2,1)*4.4482216/norm,':','color',[0.85 0.33 0.10],'linewidth',2);
title('Wall 1')
% xlabel('Roof Displacement (mm)');
% ylabel('Base Shear, V (kN)');
xlabel('Roof Drift Ratio (%)');
ylabel('$\frac{V}{A_{cw}\sqrt{f''_{c} (MPa)}}$','interpreter','latex','fontsize',16)
% xlim([-200 150]);
% ylim([-400 400]);
xlim([-3 3]);
ylim([-1 1]);
plot(xlim,[0 0],'k','linewidth',1);
plot([0 0],ylim,'k','linewidth',1);
% legend([plt1,plt2,plt3],'Test','Truss','Spring V','location','southeast');
legend([plt2,plt3],'Truss','Spring V','location','southeast');


subplot(1,2,2)
hold on
grid minor
grid on
box on
set(gca,'fontsize',13);
% plt1 = plot(test(:,1)*25.4,test(:,2)*4.4482216*Vstr,'.','linewidth',1,'color',[0.75 0.75 0.75 0.5],'MarkerSize',12);
plt2 = plot(disp1(1:ind1,1)*25.4/H*100,ReaX1W2(1:ind1,1)*4.4482216/norm,'color',[0 0 1],'linewidth',1);
plt3 = plot(disp2(1:ind2,1)*25.4/H*100,ReaX2W2(1:ind2,1)*4.4482216/norm,':','color',[0.85 0.33 0.10],'linewidth',2);
title('Wall 2')
% xlabel('Roof Displacement (mm)');
% ylabel('Base Shear, V (kN)');
xlabel('Roof Drift Ratio (%)');
ylabel('$\frac{V}{A_{cw}\sqrt{f''_{c} (MPa)}}$','interpreter','latex','fontsize',16)
% xlim([-200 150]);
% ylim([-400 400]);
xlim([-3 3]);
ylim([-1 1]);
plot(xlim,[0 0],'k','linewidth',1);
plot([0 0],ylim,'k','linewidth',1);
% legend([plt1,plt2,plt3],'Test','Truss','Spring V','location','southeast');
legend([plt2,plt3],'Truss','Spring V','location','southeast');

end

end







