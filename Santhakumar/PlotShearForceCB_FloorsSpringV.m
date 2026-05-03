function PlotShearForceCB_FloorsSpringV
% Displacements are calculated using the nodes of the rigid elements
% CB Level 1
clc;clear;
close all;

% dir  = '_ResultsRAS.1.0.0.done';
dir = 'SpringV.1.0.0.done';
% dir = 'Results.1.0.0.done';
strainCB = load(fullfile(dir,'/SpringDeformation.txt'));
L = 15; %in
cont = 1;
for i=2:2:14
    sStrainCB(:,cont) = strainCB(:,i)/L;
    cont = cont+1;
end
% sStrainCB1 = shearStrain(dir,'/SpringDeformation.txt');
% sStrainCB3 = shearStrain(dir,'/DispRigidCB3.txt');
% sStrainCB5 = shearStrain(dir,'/DispRigidCB5.txt');
% sStrainCB7 = shearStrain(dir,'/DispRigidCB7.txt');
Ac = 304.8*76.2; 
fc = 30.01;
forceCB = load(fullfile(dir,'/SpringForce.txt'))*4448.2216/Ac/sqrt(fc);
cont = 1;
for i=2:3:21
    sForceCB(:,cont) = forceCB(:,i);
    cont = cont+1;
end
% sForceCB1 = shearForce(dir,'/SpringForce.txt')*4448.2216/Ac/sqrt(fc);
% sForceCB3 = shearForce(dir,'/CB_trussforces3.txt')*4448.2216/Ac/sqrt(fc);
% sForceCB5 = shearForce(dir,'/CB_trussforces5.txt')*4448.2216/Ac/sqrt(fc);
% sForceCB7 = shearForce(dir,'/CB_trussforces7.txt')*4448.2216/Ac/sqrt(fc);

figure;
hold;
plt1 = plot(sStrainCB(:,1),sForceCB(:,1),'color',[0.85 0.33 0.10],'linewidth',1);
% plt2 = plot(sStrainCB3,sForceCB3,'linewidth',1.3);
% plt3 = plot(sStrainCB5,sForceCB5,'linewidth',1.3);
% plt4 = plot(sStrainCB(:,7),sForceCB(:,7),':r','linewidth',2.5);
plt4 = plot(sStrainCB(:,7),sForceCB(:,7),':','color',[0.85 0.33 0.10 0.5],'linewidth',2);
set(gca,'TickLength',[0 0]);

grid on;
box on;
grid minor;
title('Shear Spring');
xlabel('Chord Rotation (rad)');
% ylabel('Shear Ratio, V/(A_c f''_c^0^.^5)')
ylabel('$\frac{V}{A_{cw}\sqrt{f''_{c} (MPa)}}$','interpreter','latex','fontsize',18)
xlim([-0.06 0.06]);
ylim([-1.5 1.5]);
set(gca,'Ydir','reverse');
plot(xlim,[0 0],'color',[0 0 0 0.5],'linewidth',0.5);
plot([0 0],ylim,'color',[0 0 0 0.5],'linewidth',0.5)
% plt5 = plot(xlim,[0.67 0.67],'k--','linewidth',1.3);
% plot(xlim,[-0.67 -0.67],'k--','linewidth',1.3);
plt6 = plot(xlim,[10/12 10/12],'--','linewidth',1.3,'color',[0.5 0.5 0.5]);
plot(xlim,[-10/12 -10/12],'--','linewidth',1.3,'color',[0.5 0.5 0.5]);
% legend([plt1 plt2 plt3 plt4 plt5 plt6],'1st floor A_{eq}','3rd floor A_{eq}','5th floor A_{eq}','7th floor A_{eq}','Theoretical','ACI-318 limit','location','southeast');
% legend([plt2 plt3 plt5 plt6],'3rd floor BTM','5th floor BTM','Theoretical','ACI-318 limit','location','southeast');
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