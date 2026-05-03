clc;clear;close all;
set(0,'DefaultAxesFontName','Calibri')
set(0,'DefaultAxesFontAngle','italic')
set(0,'DefaultTextFontName','Calibri')
set(0,'DefaultTextFontAngle','italic')

test = load('Naish.txt');
L = 60;
x = [-0.08 0.08];
% y = [-175 175];
y = [-600 600];

test(:,2) = test(:,2)/L;

lastStep = 1861;
test = test(1:lastStep,:);
test(:,1) = test(:,1);

dirResults = 'Results_truss';
dirResults2 = 'Results';

figure;
hold on
grid on
grid minor
box on
set(gca,'fontsize',12);
set(gcf,'Position',[100 100 600 450])

line(x,[0,0],'Color','black');
line([0,0],y,'Color','black');

plt0 = plot(test(:,2),test(:,1)*4.4482,'linewidth',2.5,'color',[0.5 0.5 0.5]);

modelFile = load([dirResults '/' 'Displacement.txt']);
plt1 = plot(modelFile(:,2)/L,modelFile(:,1)*4.4482,'b','linewidth',1.5);
modelFile2 = load([dirResults2 '/' 'Displacement.txt']);
plt2 = plot(modelFile2(:,2)/L,modelFile2(:,1)*4.4482,'--','color',[1 0 0 0.75],'linewidth',2.0);

% legend([plt0,plt1],'Test','Model','location','southeast')
legend([plt0,plt1,plt2],'Test','Truss Model','Shear Spring','location','southeast')

title('CB33D')
xlabel('Chord Rotation (rad)');
% ylabel('Force (kips)');
ylabel('Force (kN)');
xlim(x)
ylim(y)
