function PlotShearForceCB
clc;clear;close all;

% dir  = 'Results.1.0.0.done';
dir  = '_ResultsRAS.1.0.0.done';
% dir  = 'BTM';

sStrainCB1 = shearStrain(112,4,6,114);
sStrainCB7 = shearStrain(142,34,36,144);
Ac = 304.8*76.2; 
fc = 30.01;
sForceCB1 = shearForce(dir,'/CB_trussforces1.txt')*4448.2216/Ac/sqrt(fc);
sForceCB7 = shearForce(dir,'/CB_trussforces7.txt')*4448.2216/Ac/sqrt(fc);

figure;
hold;
plt1 = plot(sStrainCB1,sForceCB1,'linewidth',1.3,'color',[0.5 0.5 0.5]);
% % %plot(sStrainCB1,sForceCB1,'b','linewidth',1.3);
plt2 = plot(sStrainCB7,sForceCB7,'k','linewidth',1.3);
set(gca,'TickLength',[0 0]);

grid on;
box on;
xlabel('Shear Strain, \gamma (rad)');
%ylabel('Shear Ratio, V/(A_c f''_c^0^.^5)')
xlim([-0.06 0.06]);
ylim([-1.5 1.5]);
%set(gca,'Xdir','reverse');
set(gca,'Ydir','reverse');
plot(xlim,[0 0],'k','linewidth',1);
plot([0 0],ylim,'k','linewidth',1);
plt3 = plot(xlim,[0.67 0.67],'k--','linewidth',1.3);
plot(xlim,[-0.67 -0.67],'k--','linewidth',1.3);
plt4 = plot(xlim,[10/12 10/12],'--','linewidth',1.3,'color',[0.5 0.5 0.5]);
plot(xlim,[-10/12 -10/12],'--','linewidth',1.3,'color',[0.5 0.5 0.5]);
legend([plt1 plt2 plt3 plt4],'Level 1','Level 7','Theoretical','ACI-318 limit','location','southeast');

set(gcf,'Position',[680,558,560,420]);
set(gca,'fontsize',12);
ax = gca;
ax.Position = [0.1500 0.1400 0.7750 0.7500];
ax.GridLineStyle = '-';
grid(gca,'minor'); 
set(gca,'MinorGridLineStyle','-','MinorGridColor',[0.92 0.92 0.92]);
%ax.GridColor = [0.1,0.1,0.1];
ax.GridAlpha = 0.2;
ax.LineWidth = 1.2;
offx = 0.005;
offy = 0.02;
rectangle('Position',[-0.059+offx -0.755+offy 0.01 0.14*1.3],'FaceColor',[1 1 1])
text(-0.058+offx,-0.68+offy,'0.67');
offx = 0.005;
offy = -0.18;
rectangle('Position',[-0.059+offx -0.755+offy 0.01 0.14*1.3],'FaceColor',[1 1 1])
text(-0.058+offx,-0.68+offy,'0.83');

end

function sStrainCB = shearStrain(n1,n2,n3,n4)
global dispWall1;
global dispWall2;
if isempty(dispWall1)
    modelData
end
rdispWall1 = dispWall1*0.0254;
rdispWall2 = dispWall2*0.0254;
IncH = 0.4559;
IncV = 0.2685;
eta = atand(IncV/IncH);
x1i = 0;
y1i = 0;
x2i = IncH;
y2i = 0;
x3i = IncH;
y3i = IncV;
x4i = 0;
y4i = IncV;
l1i = sqrt((x3i-x1i)^2 + (y3i-y1i)^2);
l2i = sqrt((x2i-x4i)^2 + (y2i-y4i)^2);
%
dx1 = rdispWall1(:,(n1-1)*2 + 1);
dy1 = rdispWall1(:,(n1-1)*2 + 2);
dx2 = rdispWall2(:,(n2-1)*2 + 1);
dy2 = rdispWall2(:,(n2-1)*2 + 2);
dx3 = rdispWall2(:,(n3-1)*2 + 1);
dy3 = rdispWall2(:,(n3-1)*2 + 2);
dx4 = rdispWall1(:,(n4-1)*2 + 1);
dy4 = rdispWall1(:,(n4-1)*2 + 2);
%
x1f = x1i + dx1;
y1f = y1i + dy1;
x2f = x2i + dx2;
y2f = y2i + dy2;
x3f = x3i + dx3;
y3f = y3i + dy3;
x4f = x4i + dx4;
y4f = y4i + dy4;
l1f = sqrt((x3f-x1f).^2 + (y3f-y1f).^2);
l2f = sqrt((x2f-x4f).^2 + (y2f-y4f).^2);
ds1 = l1f - l1i;
ds2 = l2f - l2i;
sStrainCB = (ds1 - ds2)/(2*l1i) * (tand(eta) + 1/tand(eta));
end

function sForceCB = shearForce(dir,CB_trussforces)
trussForces = importdata([dir CB_trussforces]);

ltrussForces = size(trussForces,2); 
trussSum = zeros(size(trussForces,1),1);
for cc = 1 : ltrussForces/6
    col = (cc - 1)*6 + 2;
    trussSum = trussSum + trussForces(:,col);    
end
sForceCB = trussSum;
end