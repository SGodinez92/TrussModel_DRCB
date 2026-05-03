clc
clear
close all

set(0,'DefaultAxesFontName','Calibri')
set(0,'DefaultAxesFontAngle','italic')
set(0,'DefaultTextFontName','Calibri')
set(0,'DefaultTextFontAngle','italic')

test = load('CB1_test.txt');
testE = load('CB1.txt');
% testEtabs = load('CB1_etabs_beta0.7.txt');
testEtabs = load('CB1_etabs_beta1.0.txt');
L = 34;
x = [-0.08 0.08];
% y = [-200 200];
y = [-1200 1200];

% test(:,2) = test(:,2)/L;

figure;
hold on
grid on
grid minor
box on
set(gca,'fontsize',12);
set(gcf,'Position',[100 100 600 450])

line(x,[0,0],'Color','black');
line([0,0],y,'Color','black');

plt0 = plot(test(:,1)/100,test(:,2)*4.4482,'.','MarkerSize',14,'color',[0.75 0.75 0.75]);

dirResults = 'Results_draft4.1';
dirResults2 = 'Results_spring';
dirResults3 = 'Results_momSpring';

modelFile = load([dirResults '/' 'Displacement.txt']);
% modelFile2 = load([dirResults2 '/' 'Displacement.txt']);
plt1 = plot(modelFile(:,2)/L,modelFile(:,1)*4.4482,'b','linewidth',1);
% plt2 = plot(modelFile2(:,2)/L,modelFile2(:,1),'r','linewidth',1.5);
% legend([plt1 plt2],'\Omega_{fac} = 1.0','\Omega_{fac} = 0.75','location','southeast')
% plt2 = plot(testEtabs(:,1),testEtabs(:,2)*4.4482,'--','color',[1 0 0 0.6],'linewidth',2.0);

modelFile2 = load([dirResults2 '/' 'Displacement.txt']);
plt3 = plot(modelFile2(:,2)/L,modelFile2(:,1)*4.4482,':','color',[0.85 0.33 0.1 1],'linewidth',2.0);

modelFile3 = load([dirResults3 '/' 'Displacement.txt']);
plt4 = plot(modelFile3(:,2)/L,modelFile3(:,1)*4.4482,'--','color',[0.32 0.44 0.15 0.75],'linewidth',1.5);

title('CB1')
% legend([plt0,plt1],'Test','Model','location','southeast')
% legend([plt0,plt1,plt2],'Test','Model OS','Model ETABS','location','southeast')
% legend([plt0,plt1,plt3],'Test','Model OS','Shear Spring','location','southeast')
legend([plt0,plt1,plt3,plt4],'Test','Model OS','Shear Spring','Moment Springs','location','southeast')
xlabel('Chord Rotation (rad)');
% ylabel('Force (kips)');
ylabel('Force (kN)');
xlim(x)
ylim(y)


% Energy comparison
% Test
E1 = 0;
for i=1:length(testE)-1
    xp = testE(i,2);
    xn = testE(i+1,2);
    yp = testE(i+1,1);
    yn = testE(i,1);
    E1(i) = xp*yp - xn*yn;
end

xp = testE(end,2);
xn = testE(1,2);
yp = testE(1,1);
yn = testE(end,1);

E1(i+1) = xp*yp - xn*yn;
E1_tot = abs(cumsum(E1))/2;
E1_final = E1_tot(end);

E1c = cumtrapz(testE(:,2),testE(:,1));

[pks,locs] = findpeaks(testE(:,1));
locs(pks<0.0199) = [];
pks(pks<0.0199) = [];

[pksMin,locsMin] = findpeaks(-testE(:,1));
locsMin(pksMin<0.0199) = [];
pksMin(pksMin<0.0199) = [];

locsTest = [locs;locsMin;length(testE)];
locsTest = sort(locsTest);

E1_peaks = E1_tot(locsTest)';

% Model OS
aux = find(modelFile(:,2)/L > 0.0299,1);
testPartial = modelFile(1:aux,:);
aux = find(testPartial(:,2)<0,1,'last');
testPartial = modelFile(aux:end,:);

E2 = 0;
for i=1:length(testPartial)-1
    xp = testPartial(i,2)/L;
    xn = testPartial(i+1,2)/L;
    yp = testPartial(i+1,1);
    yn = testPartial(i,1);
    E2(i) = xp*yp - xn*yn;
end

xp = testPartial(end,2)/L;
xn = testPartial(1,2)/L;
yp = testPartial(1,1);
yn = testPartial(end,1);

E2(i+1) = xp*yp - xn*yn;
E2_tot = abs(cumsum(E2))/2;

E2c = cumtrapz(testPartial(:,2)/L,testPartial(:,1));

[pksM,locsM] = findpeaks(testPartial(:,2)/L);
locsM(pksM<0.0299) = [];
pksM(pksM<0.0299) = [];
flag = 0;
flag2 = 0;
cont = 1;
cont2 = 1;
while flag2 == 0
    for ii=1:length(pksM)-1
        if pksM(ii+1)<pksM(ii)*.85
            flag = 1;
            ind = ii+1;
            cont = cont + 1;
        else
            cont2 = cont2 + 1;
        end
    end
    if flag == 1
        locsM(ind) = [];
        pksM(ind) = [];
        flag = 0;
    end
    if cont2 == ii+1
        flag2 = 1;
    end
    cont2 = 1;
end

[pksMinM,locsMinM] = findpeaks(-testPartial(:,2)/L);
locsMinM(pksMinM<0.0299) = [];
pksMinM(pksMinM<0.0299) = [];

locsModel = [locsM;locsMinM;length(testPartial)];
locsModel = sort(locsModel);

E2_peaks = E2_tot(locsModel)';

% Etabs
aux = find(testEtabs(:,1) > 0.0299,1);
testPartialE = testEtabs(1:aux,:);
aux = find(testPartialE(:,2)<0,1,'last');
testPartialE = testEtabs(aux:end,:);

E3 = 0;
for i=1:length(testPartialE)-1
    xp = testPartialE(i,1);
    xn = testPartialE(i+1,1);
    yp = testPartialE(i+1,2);
    yn = testPartialE(i,2);
    E3(i) = xp*yp - xn*yn;
end

xp = testPartialE(end,1);
xn = testPartialE(1,1);
yp = testPartialE(1,2);
yn = testPartialE(end,2);

E3(i+1) = xp*yp - xn*yn;
E3_tot = abs(cumsum(E3))/2;

E3c = cumtrapz(testPartialE(:,1),testPartialE(:,2));

[pksE,locsE] = findpeaks(testPartialE(:,2));
locsE(pksE<0.0299) = [];
pksE(pksE<0.0299) = [];
flag = 0;
flag2 = 0;
cont = 1;
cont2 = 1;
while flag2 == 0
    for ii=1:length(pksE)-1
        if pksE(ii+1)<pksE(ii)*.85
            flag = 1;
            ind = ii+1;
            cont = cont + 1;
        else
            cont2 = cont2 + 1;
        end
    end
    if flag == 1
        locsE(ind) = [];
        pksE(ind) = [];
        flag = 0;
    end
    if cont2 == ii+1
        flag2 = 1;
    end
    cont2 = 1;
end

[pksMinE,locsMinE] = findpeaks(-testPartialE(:,2));
locsMinE(pksMinE<0.0299) = [];
pksMinE(pksMinE<0.0299) = [];

locsModelE = [locsE;locsMinE;length(testPartialE)];
locsModelE = sort(locsModelE);

E3_peaks = E3_tot(locsModelE)';

% Shear Spring
aux = find(modelFile2(:,2)/L > 0.0299,1);
testPartialS = modelFile2(1:aux,:);
aux = find(testPartialS(:,2)<0,1,'last');
testPartialS = modelFile2(aux:end,:);

E4 = 0;
for i=1:length(testPartialS)-1
    xp = testPartialS(i,2)/L;
    xn = testPartialS(i+1,2)/L;
    yp = testPartialS(i+1,1);
    yn = testPartialS(i,1);
    E4(i) = xp*yp - xn*yn;
end

xp = testPartialS(end,2)/L;
xn = testPartialS(1,2)/L;
yp = testPartialS(1,1);
yn = testPartialS(end,1);

E4(i+1) = xp*yp - xn*yn;
E4_tot = abs(cumsum(E4))/2;

E4c = cumtrapz(testPartialS(:,2)/L,testPartialS(:,1));

[pksS,locsS] = findpeaks(testPartialS(:,2)/L);
locsS(pksS<0.0199) = [];
pksS(pksS<0.0199) = [];
flag = 0;
flag2 = 0;
cont = 1;
cont2 = 1;
while flag2 == 0
    for ii=1:length(pksS)-1
        if pksS(ii+1)<pksS(ii)*.85
            flag = 1;
            ind = ii+1;
            cont = cont + 1;
        else
            cont2 = cont2 + 1;
        end
    end
    if flag == 1
        locsS(ind) = [];
        pksS(ind) = [];
        flag = 0;
    end
    if cont2 == ii+1
        flag2 = 1;
    end
    cont2 = 1;
end

[pksMinS,locsMinS] = findpeaks(-testPartialS(:,2)/L);
locsMinS(pksMinS<0.0199) = [];
pksMinS(pksMinS<0.0199) = [];

locsModelS = [locsS;locsMinS;length(testPartialS)];
locsModelS = sort(locsModelS);

E4_peaks = E4_tot(locsModelS)';

% Moment Spring
aux = find(modelFile3(:,2)/L > 0.0299,1);
testPartialM = modelFile3(1:aux,:);
aux = find(testPartialM(:,2)<0,1,'last');
testPartialM = modelFile3(aux:end,:);

E5 = 0;
for i=1:length(testPartialM)-1
    xp = testPartialM(i,2)/L;
    xn = testPartialM(i+1,2)/L;
    yp = testPartialM(i+1,1);
    yn = testPartialM(i,1);
    E5(i) = xp*yp - xn*yn;
end

xp = testPartialM(end,2)/L;
xn = testPartialM(1,2)/L;
yp = testPartialM(1,1);
yn = testPartialM(end,1);

E5(i+1) = xp*yp - xn*yn;
E5_tot = abs(cumsum(E5))/2;

E5c = cumtrapz(testPartialM(:,2)/L,testPartialM(:,1));

[pksM,locsM] = findpeaks(testPartialM(:,2)/L);
locsM(pksM<0.0199) = [];
pksM(pksM<0.0199) = [];
flag = 0;
flag2 = 0;
cont = 1;
cont2 = 1;
while flag2 == 0
    for ii=1:length(pksM)-1
        if pksM(ii+1)<pksM(ii)*.85
            flag = 1;
            ind = ii+1;
            cont = cont + 1;
        else
            cont2 = cont2 + 1;
        end
    end
    if flag == 1
        locsM(ind) = [];
        pksM(ind) = [];
        flag = 0;
    end
    if cont2 == ii+1
        flag2 = 1;
    end
    cont2 = 1;
end

[pksMinM,locsMinM] = findpeaks(-testPartialM(:,2)/L);
locsMinM(pksMinM<0.0199) = [];
pksMinM(pksMinM<0.0199) = [];

locsModelM = [locsM;locsMinM;length(testPartialM)];
locsModelM = sort(locsModelM);

E5_peaks = E5_tot(locsModelM)';

figure
grid minor
box on
hold on
plot(testE(:,1),E1_tot)
plot(testPartial(:,2)/L,E2_tot)
plot(testPartialE(:,1),E3_tot)
plot(testPartialS(:,2)/L,E4_tot)
plot(testPartialM(:,2)/L,E5_tot)

figure
hold on
set(gca,'fontsize',12);
set(gcf,'Position',[100 100 450 300])
grid on
box on
plot(E1_peaks*4.4482*L*25.4/1000,'linewidth',4.5,'color',[0.75 0.75 0.75])
plot(E2_peaks*4.4482*L*25.4/1000,'b','linewidth',1.5)
plot(E3_peaks*4.4482*L*25.4/1000,'--','color',[1 0 0 0.75],'linewidth',1.5)
plot(E4_peaks*4.4482*L*25.4/1000,':','color',[0.85 0.33 0.1 1],'linewidth',2)
plot(E5_peaks*4.4482*L*25.4/1000,'-.','color',[0.32 0.44 0.15 0.75],'linewidth',1)
ylabel('Cumulative Energy (kN-m)')
xlabel('Chord Rotation (cycle)')
title('Energy Dissipated CB1')
% legend('Test','Model OS','Model ETABS','Shear Spring','location','northwest')
legend('Test','Model OS','Model ETABS','Shear Spring','Moment Springs','location','northwest')