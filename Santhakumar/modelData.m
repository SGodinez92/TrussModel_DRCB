function modelData
clc;
clearvars -global

global dispWall1;
global dispWall2;
global dispCB;

fprintf('running modelData.m ...\n');
dir = 'Results.1.0.0.done';
dispWall1 = importdata([dir '/DispWall1.txt']);
dispWall2 = importdata([dir '/DispWall2.txt']);
dispCB = importdata([dir '/DispCB.txt']);
fprintf('done!\n');

end