function PlotShearForceCB_Methods
% Displacements are calculated using the nodes of the rigid elements
% CB Level 1
clc;clear;%close all;

dir  = 'Results.1.0.0.done';
dir1 = 'Results.1.0.0.done';

sStrainCB1_Aeq = shearStrain(dir,'/DispRigidCB1.txt');
% sStrainCB3_Aeq = shearStrain(dir,'/DispRigidCB3.txt');
% sStrainCB5_Aeq = shearStrain(dir,'/DispRigidCB5.txt');
sStrainCB7_Aeq = shearStrain(dir,'/DispRigidCB7.txt');
Ac = 304.8*76.2; 
fc = 30.01;
sForceCB1_Aeq = shearForce(dir,'/CB_trussforces1.txt')*4448.2216/Ac/sqrt(fc);
% sForceCB3_Aeq = shearForce(dir,'/CB_trussforces3.txt')*4448.2216/Ac/sqrt(fc);
% sForceCB5_Aeq = shearForce(dir,'/CB_trussforces5.txt')*4448.2216/Ac/sqrt(fc);
sForceCB7_Aeq = shearForce(dir,'/CB_trussforces7.txt')*4448.2216/Ac/sqrt(fc);

sStrainCB1_BTM = shearStrain(dir1,'/DispRigidCB1.txt');
% sStrainCB3_BTM = shearStrain(dir1,'/DispRigidCB3.txt');
% sStrainCB5_BTM = shearStrain(dir1,'/DispRigidCB5.txt');
sStrainCB7_BTM = shearStrain(dir1,'/DispRigidCB7.txt');

sForceCB1_BTM = shearForce(dir1,'/CB_trussforces1.txt')*4448.2216/Ac/sqrt(fc);
% sForceCB3_BTM = shearForce(dir1,'/CB_trussforces3.txt')*4448.2216/Ac/sqrt(fc);
% sForceCB5_BTM = shearForce(dir1,'/CB_trussforces5.txt')*4448.2216/Ac/sqrt(fc);
sForceCB7_BTM = shearForce(dir1,'/CB_trussforces7.txt')*4448.2216/Ac/sqrt(fc);

figure;
hold;
plt1 = plot(sStrainCB1_Aeq,sForceCB1_Aeq,'b','linewidth',1.3);
plt2 = plot(sStrainCB1_BTM,sForceCB1_BTM,'r','linewidth',1.3);
% plt3 = plot(sStrainCB7_Aeq,sForceCB7_Aeq,'k','linewidth',1.3);
% plt4 = plot(sStrainCB7_BTM,sForceCB7_BTM,'color',[0.35 0.35 0.35],'linewidth',1.3);
set(gca,'TickLength',[0 0]);

grid on;
box on;
xlabel('Shear Strain, \gamma (rad)');
ylabel('Shear Ratio, V/(A_c f''_c^0^.^5)')
xlim([-0.06 0.06]);
ylim([-1.5 1.5]);
set(gca,'Ydir','reverse');
plot(xlim,[0 0],'k','linewidth',1);
plot([0 0],ylim,'k','linewidth',1);
plt5 = plot(xlim,[0.67 0.67],'k--','linewidth',1.3);
plot(xlim,[-0.67 -0.67],'k--','linewidth',1.3);
plt6 = plot(xlim,[10/12 10/12],'--','linewidth',1.3,'color',[0.5 0.5 0.5]);
plot(xlim,[-10/12 -10/12],'--','linewidth',1.3,'color',[0.5 0.5 0.5]);
% legend([plt1 plt2 plt3 plt4 plt5 plt6],'1st A_{eq}','1st BTM','7th A_{eq}','7th BTM','Theoretical','ACI-318 limit','location','southeast');
legend([plt1 plt2 plt5 plt6],'1st A_{eq}','1st A_{eq} calibrated','Theoretical','ACI-318 limit','location','southeast');

set(gcf,'Position',[680,558,560,420]);
set(gca,'fontsize',12);
ax = gca;
ax.Position = [0.1500 0.1400 0.7750 0.7500];
ax.GridLineStyle = '-';
grid(gca,'minor'); 
set(gca,'MinorGridLineStyle','-','MinorGridColor',[0.92 0.92 0.92]);
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

function sStrainCB = shearStrain(dir,fdispCB)
n1 = 1;
n2 = 2;
n3 = 3;
n4 = 4;
dispCB = importdata([dir fdispCB]);
rdispCB = dispCB*0.0254;
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
dx1 = rdispCB(:,(n1-1)*2 + 1);
dy1 = rdispCB(:,(n1-1)*2 + 2);
dx2 = rdispCB(:,(n2-1)*2 + 1);
dy2 = rdispCB(:,(n2-1)*2 + 2);
dx3 = rdispCB(:,(n3-1)*2 + 1);
dy3 = rdispCB(:,(n3-1)*2 + 2);
dx4 = rdispCB(:,(n4-1)*2 + 1);
dy4 = rdispCB(:,(n4-1)*2 + 2);
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

function sForceCB = shearForce(dir,TrussForceDiaCB)
trussForces = importdata([dir TrussForceDiaCB]);
ltrussForces = size(trussForces,2); 
sForceCB = zeros(size(trussForces,1),1);
nelem = ltrussForces/2;
for cc = 1 : nelem
    col = (cc - 1)*2 + 2;
    sForceCB = sForceCB + trussForces(:,col);    
end
end