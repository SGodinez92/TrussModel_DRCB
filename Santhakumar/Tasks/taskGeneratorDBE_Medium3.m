clc;
clear;
%close all;

% General
nameTask = mfilename();
par{1} = {'3'};% NipBound
par{2} = {'3'};% NipField
par{3} = {'1e-12'};% prDum
par{4} = {'-'};% eIter (apply only for FBE)
par{5} = {'-'};% eTol (apply only for FBE) 
par{6} = {'10.'};% ftest

% Displacement Control Lateral
par{7} = {'Transformation'};% constraintsType
par{8} = {'RCM'};% numbererType
par{9} = {'SparseSYM'};% systemType
par{10} = {'EnergyIncr'};% testType0/default 
par{11} = {'1e-07'};% tol0/default
par{12} = {'200'};% iter0/default 
par{13} = {'Newton'};% algorithmType0/default 
par{14} = {'0.0035'};% dD
par{15} = {'EnergyIncr'};% testType1
par{16} = {'EnergyIncr'};% testType2
par{17} = {'EnergyIncr'};% testType3
par{18} = {'NormDispIncr'};% testType4
par{19} = {'NormDispIncr'};% testType5
par{20} = {'NormDispIncr'};% testType6
par{21} = {'1e-06'};% tol1
par{22} = {'1e-05'};% tol2
par{23} = {'1e-04'};% tol3
par{24} = {'1e-06'};% tol4
par{25} = {'1e-05'};% tol5
par{26} = {'1e-04'};% tol6
par{27} = {'2000'};% iterH
par{28} = {'1000'};% iterM
par{29} = {'200'};% iterL
% testType1 $tol1
par{30} = {'1'};% run1a/Newton/iterL
par{31} = {'0'};% run2a/Newton Initial/iterH
par{32} = {'1'};% run3a/ModifiedNewton Initial/iterH
par{33} = {'0'};% run4a/ModifiedNewton/iterH
par{34} = {'1'};% run5a/NewtonWithLineSearch/iterM 
par{35} = {'0'};% run6a/BFGS/iterM
par{36} = {'0'};% run7a/Broyden/iterM
par{37} = {'1'};% run8a/KrylovNewton/iterM
% testType2 $tol2
par{38} = {'1'};% run1b/Newton/iterL
par{39} = {'0'};% run2b/Newton Initial/iterH
par{40} = {'1'};% run3b/ModifiedNewton Initial/iterH
par{41} = {'0'};% run4b/ModifiedNewton/iterH
par{42} = {'1'};% run5b/NewtonWithLineSearch/iterM 
par{43} = {'0'};% run6b/BFGS/iterM
par{44} = {'0'};% run7b/Broyden/iterM
par{45} = {'1'};% run8b/KrylovNewton/iterM
% testType3 $tol3
par{46} = {'1'};% run1c/Newton/iterL
par{47} = {'0'};% run2c/Newton Initial/iterH
par{48} = {'1'};% run3c/ModifiedNewton Initial/iterH
par{49} = {'0'};% run4c/ModifiedNewton/iterH
par{50} = {'1'};% run5c/NewtonWithLineSearch/iterM 
par{51} = {'0'};% run6c/BFGS/iterM
par{52} = {'0'};% run7c/Broyden/iterM
par{53} = {'1'};% run8c/KrylovNewton/iterM
% testType4 $tol4
par{54} = {'0'};% run1a/Newton/iterL
par{55} = {'0'};% run2a/Newton Initial/iterH
par{56} = {'0'};% run3a/ModifiedNewton Initial/iterH
par{57} = {'0'};% run4a/ModifiedNewton/iterH
par{58} = {'0'};% run5a/NewtonWithLineSearch/iterM 
par{59} = {'0'};% run6a/BFGS/iterM
par{60} = {'0'};% run7a/Broyden/iterM
par{61} = {'0'};% run8a/KrylovNewton/iterM
% testType5 $tol5
par{62} = {'0'};% run1b/Newton/iterL
par{63} = {'0'};% run2b/Newton Initial/iterH
par{64} = {'0'};% run3b/ModifiedNewton Initial/iterH
par{65} = {'0'};% run4b/ModifiedNewton/iterH
par{66} = {'0'};% run5b/NewtonWithLineSearch/iterM 
par{67} = {'0'};% run6b/BFGS/iterM
par{68} = {'0'};% run7b/Broyden/iterM
par{69} = {'0'};% run8b/KrylovNewton/iterM
% testType6 $tol6
par{70} = {'0'};% run1c/Newton/iterL
par{71} = {'0'};% run2c/Newton Initial/iterH
par{72} = {'0'};% run3c/ModifiedNewton Initial/iterH
par{73} = {'0'};% run4c/ModifiedNewton/iterH
par{74} = {'0'};% run5c/NewtonWithLineSearch/iterM 
par{75} = {'0'};% run6c/BFGS/iterM
par{76} = {'0'};% run7c/Broyden/iterM
par{77} = {'0'};% run8c/KrylovNewton/iterM

lvpar = length(par);
lpar = zeros(lvpar,1);
for ii = 1 : lvpar
    lpar(ii) = length(par{ii});    
end

% Generate combinations
taskList = fopen('taskList.txt','wt');
ltask = prod(lpar); 
fprintf('number of tasks: %d\n',ltask);
ipar = ones(lvpar,1);
for itask = 1 : ltask
    
    task = strcat(nameTask,'_',int2str(itask));
    for npar = 1 : lvpar
        rowpar = par{npar}; task = strcat(task,{' '},rowpar{ipar(npar)});       
    end
    if itask ~= ltask
        task = strcat(task,'\n');
    end
    fprintf(taskList,char(task));  
        
    for npar = lvpar : -1 : 1        
        ipar(npar) = ipar(npar) + 1;
        if ipar(npar) <= lpar(npar)
             break            
        else
            ipar(npar) = 1;            
        end
                     
    end    
end
    
fclose(taskList);












