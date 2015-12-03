data_filename = './data/matches.txt';
im1_filename = './img/im1.jpg';
im2_filename = './img/im2.jpg';


%% Import images.
im1 = imread(im1_filename);
im2 = imread(im2_filename);

%% Display images.
h1 = subplot(1, 2, 1);
subimage(im1);
hold(h1, 'on');
axis(h1, 'off');
h2 = subplot(1, 2, 2);
subimage(im2);
hold(h2, 'on');
axis(h2, 'off');

%% Import data.
data = importdata(data_filename);
N = size(data, 1);

%% Normalization
pmu = sum(data(:, 1:2), 1) / N;
qmu = sum(data(:, 3:4), 1) / N;
psigma = sum(sqrt(sum(data(:, 1:2) .^ 2, 2)), 1) / N;
qsigma = sum(sqrt(sum(data(:, 3:4) .^ 2, 2)), 1) / N;
Tp = [[sqrt(2) / psigma,                0, -pmu(1, 1) * sqrt(2) / psigma];
      [               0, sqrt(2) / psigma, -pmu(1, 2) * sqrt(2) / psigma];
      [               0,                0,                             1]];
Tq = [[sqrt(2) / qsigma,                0, -qmu(1, 1) * sqrt(2) / qsigma];
      [               0, sqrt(2) / qsigma, -qmu(1, 2) * sqrt(2) / qsigma];
      [               0,                0,                             1]];

%% RANSAC
M = 500;
sigma = 1.0;
% Initialisation
idx = randsample(N, 8, false);
F_best = ComputeF(data, idx, Tp, Tq);
K_best = length(FindInliers(data, F_best, sigma));

for i = 1:M
    idx = randsample(N, 8, false);
    F = ComputeF(data, idx, Tp, Tq);
    K = length(FindInliers(data, F, sigma));
    if K_best < K
        F_best = F;
        K_best = K;
    end
end

%% Refine fundamental matrix
idx = FindInliers(data, F_best, sigma);
F_best = ComputeF(data, idx, Tp, Tq);

%% Display inliers
for i = idx
    plot(h1, data(i, 1), data(i, 2), 'g.');
    plot(h2, data(i, 3), data(i, 4), 'g.');
end

%% Display epipolar lines
while true
    [x, y] = ginput(1);
    DisplayEpipolar(gca, h1, h2, x, y, F_best);
end
