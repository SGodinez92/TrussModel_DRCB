function PlotShearForceCB_Floors
% Displacements are calculated using the nodes of the rigid elements
% CB Level 1
clc;clear;
close all;

% lds = 20.83*.0254;
% ly = 23.084*.0254;
% epsy = 0.001717;
% lambda_e = 7.584/2;
% lambda_i = lambda_e;
% db = 0.3937*.0254;

% dir  = '_ResultsRAS.1.0.0.done';
% dir = 'Truss_hysteretic.1.0.0.done';
dir = 'TrussDRCB.1.0.0.done';
% dir = 'Results.1.0.0.done';
sStrainCB1 = shearStrain(dir,'/DispRigidCB1.txt');
% sStrainCB3 = shearStrain(dir,'/DispRigidCB3.txt');
% sStrainCB5 = shearStrain(dir,'/DispRigidCB5.txt');
sStrainCB7 = shearStrain(dir,'/DispRigidCB7.txt');
% sStrainCB1 = shearStrainAdj(dir,'/DispRigidCB1.txt',lds,ly,epsy,lambda_e,lambda_i,db);
% sStrainCB7 = shearStrainAdj(dir,'/DispRigidCB7.txt',lds,ly,epsy,lambda_e,lambda_i,db);
Ac = 304.8*76.2; 
fc = 30.01;
sForceCB1 = shearForce(dir,'/CB_trussforces1.txt')*4448.2216/Ac/sqrt(fc);
% sForceCB3 = shearForce(dir,'/CB_trussforces3.txt')*4448.2216/Ac/sqrt(fc);
% sForceCB5 = shearForce(dir,'/CB_trussforces5.txt')*4448.2216/Ac/sqrt(fc);
sForceCB7 = shearForce(dir,'/CB_trussforces7.txt')*4448.2216/Ac/sqrt(fc);

figure;
hold;
plt1 = plot(sStrainCB1,sForceCB1,'color',[0 0 1 0.5],'linewidth',1);
% plt2 = plot(sStrainCB3,sForceCB3,'linewidth',1.3);
% plt3 = plot(sStrainCB5,sForceCB5,'linewidth',1.3);
% plt4 = plot(sStrainCB7,sForceCB7,':r','linewidth',2.5);
plt4 = plot(sStrainCB7,sForceCB7,'color',[0 0 1],'linewidth',2);
set(gca,'TickLength',[0 0]);

grid on;
box on;
grid minor;
title('Truss Model');
xlabel('Shear Strain, \gamma (rad)');
% ylabel('Shear Ratio, V/(A_c f''_c^0^.^5)')
ylabel('$\frac{V}{A_{cw}\sqrt{f''_{c} (MPa)}}$','interpreter','latex','fontsize',18)
xlim([-0.06 0.06]);
ylim([-1.5 1.5]);
set(gca,'Ydir','reverse');
plot(xlim,[0 0],'color',[0 0 0 0.5],'linewidth',0.5);
plot([0 0],ylim,'color',[0 0 0 0.5],'linewidth',0.5);
% plt5 = plot(xlim,[0.67 0.67],'k--','linewidth',1.3);
% plot(xlim,[-0.67 -0.67],'k--','linewidth',1.3);
plt6 = plot(xlim,[10/12 10/12],'--','linewidth',1.3,'color',[0.5 0.5 0.5]);
plot(xlim,[-10/12 -10/12],'--','linewidth',1.3,'color',[0.5 0.5 0.5]);
% legend([plt1 plt2 plt3 plt4 plt5 plt6],'1st floor A_{eq}','3rd floor A_{eq}','5th floor A_{eq}','7th floor A_{eq}','Theoretical','ACI-318 limit','location','southeast');
% legend([plt2 plt3 plt5 plt6],'3rd floor BTM','5th floor BTM','Theoretical','ACI-318 limit','location','southeast');
% legend([plt1 plt4 plt5 plt6],'1st floor BTM','7th floor BTM','Theoretical','ACI-318 limit','location','southeast');
legend([plt1 plt4 plt6],'1^{st} floor','7^{th} floor','ACI-318 limit','location','southeast');

set(gcf,'Position',[680,558,560,420]);
set(gca,'fontsize',12);
% ax = gca;
% ax.Position = [0.1500 0.1400 0.7750 0.7500];
% ax.GridLineStyle = '-';
% grid(gca,'minor'); 
% set(gca,'MinorGridLineStyle','-','MinorGridColor',[0.92 0.92 0.92]);
% ax.GridAlpha = 0.2;
% ax.LineWidth = 1.2;
% offx = 0.005;
% offy = 0.02;
% rectangle('Position',[-0.059+offx -0.755+offy 0.01 0.14*1.3],'FaceColor',[1 1 1])
% text(-0.058+offx,-0.68+offy,'0.67');
% offx = 0.005;
% offy = -0.18;
% rectangle('Position',[-0.059+offx -0.755+offy 0.01 0.14*1.3],'FaceColor',[1 1 1])
% text(-0.058+offx,-0.68+offy,'0.83');

end

function sStrainCBadj = shearStrainAdj(dir,fdispCB,lds,ly,epsy,lambda_e,lambda_i,db)
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
es1o = ds1/l1i;
es2o = ds2/l2i;
es1 = (es1o*l1i-ly*epsy)/(2*(lambda_e+lambda_i)*db);
es2 = (es2o*l1i-ly*epsy)/(2*(lambda_e+lambda_i)*db);
sStrainCBadj = (es1 - es2)/2 * (tand(eta) + 1/tand(eta));
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