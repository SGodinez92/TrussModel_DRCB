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
dir = '_ResultsRAS.1.0.0.done';
% dir1  = 'TrussReducedArea_NoTruss2.1.0.0.done';
dir1  = 'Truss_hysteretic.1.0.0.done';
dir2  = 'SpringV.1.0.0.done';
% dir1  = 'BTM_cal.1.0.0.done';
disp = load([dir '/Disp.txt']);
disp1 = load([dir1 '/Disp.txt']);
disp2 = load([dir2 '/Disp.txt']);
offDisp = 0.038446;
disp = disp(:,2) - offDisp;
disp1 = disp1(:,2) - offDisp;
disp2 = disp2(:,2) - offDisp;
ReaX = load([dir '/ReaX.txt']);
ReaX = sum(-ReaX(:,2:end),2);
ReaY = load([dir '/ReaY.txt']);
ReaM = load([dir '/ReaM.txt']);
ReaM = sum(-ReaM(:,2:end),2);
ReaX1 = load([dir1 '/ReaX.txt']);
ReaX1W1 = sum(-ReaX1(:,2:5),2);
ReaX1W2 = sum(-ReaX1(:,6:9),2);
ReaM1 = load([dir1 '/ReaM.txt']);
ReaM1W1 = sum(ReaM1(:,2:3),2);
ReaM1W2 = sum(ReaM1(:,4:5),2);
ReaY1 = load([dir1 '/ReaY.txt']);
% bp = [-27.9 -21.6 -15.3 -9];
% bp2 = [9 15.3 21.6 27.9];
bp = [-9.45 -3.15 3.15 9.45];
bp2 = [-9.45 -3.15 3.15 9.45];

for i=1:4
    ReaM1W1 = ReaM1W1 + ReaY1(:,i+1)*bp(i);
    ReaM1W2 = ReaM1W2 + ReaY1(:,i+5)*bp2(i);
end
ReaM1 = ReaM1W1 + ReaM1W2;

ReaX1 = sum(-ReaX1(:,2:end),2);
ReaX2 = load([dir2 '/ReaX.txt']);
ReaX2W1 = sum(-ReaX2(:,2:5),2);
ReaX2W2 = sum(-ReaX2(:,6:9),2);
ReaX2 = sum(-ReaX2(:,2:end),2);
ReaM2 = load([dir2 '/ReaM.txt']);
ReaM2W1 = sum(ReaM2(:,2:3),2);
ReaM2W2 = sum(ReaM2(:,4:5),2);
ReaY2 = load([dir2 '/ReaY.txt']);
% bp = [-27.9 -21.6 -15.3 -9];
% bp2 = [9 15.3 21.6 27.9];
for i=1:4
    ReaM2W1 = ReaM2W1 + ReaY2(:,i+1)*bp(i);
    ReaM2W2 = ReaM2W2 + ReaY2(:,i+5)*bp2(i);
end
ReaM2 = ReaM2W1 + ReaM2W2;

Vstr = 56.6;
plot(test(:,1)*25.4,test(:,2)*4.4482216*Vstr,'.','linewidth',1,'color',[0.75 0.75 0.75 0.5],'MarkerSize',12);
plt1 = plot([0 0],[0 0],'-','linewidth',2,'color',[0.6 0.6 0.6]);
% plt2 = plot(disp(:,1)*25.4,ReaX(:,1)*4.4482216,'k','linewidth',1.3);
plt3 = plot(disp1(:,1)*25.4,ReaX1(:,1)*4.4482216,'b','linewidth',1.5);
plt4 = plot(disp2(:,1)*25.4,ReaX2(:,1)*4.4482216,':r','linewidth',2.5);
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
xlim([-200 150]);
ylim([-400 400]);
plot(xlim,[0 0],'k','linewidth',1);
plot([0 0],ylim,'k','linewidth',1);
%legend([plt1,plt2,plt3],'Test','BTM','Linear','location','southeast');
% legend([plt1,plt2,plt3],'Test','EBTM','Truss','RAS','location','southeast');
% legend([plt1,plt2,plt3,plt4],'Test','EBTM','Truss','Spring M','location','southeast');
legend([plt1,plt3,plt4],'Test','Truss','Spring V','location','southeast');
xlim_ax1 = xlim;
ylim_ax1 = ylim;

figure
hold on
plot(ReaM1W1*.113)
plot(ReaM1W2*.113)
plot(ReaM1*.113)

figure
hold on
plot(ReaM2W1*.113)
plot(ReaM2W2*.113)
plot(ReaM2*.113)




