%% ================= EXAMPLE: plot_scatter_template の使い方 =================
clear; close all; clc;

cfg = plot_style_config();

% --- ダミーデータ（実際は自分のデータに置き換える） ---
rng(1);
obs    = rand(200,1) * 2;
model1 = obs + 0.15*randn(200,1);
model2 = obs + 0.25*randn(200,1) + 0.05;

% --- Figure 作成（正方形, 8cm） ---
f = paper_figure(8, 8);
ax = gca;

% --- 系列1（1回目: 軸・1:1線・グリッドも同時に描画） ---
h1 = plot_scatter_template(ax, obs, model1, ...
    'MarkerColor', 'b', 'DisplayName', 'd4PDF', ...
    'MaxLim', 2.5, 'AnnotateStats', true);

% --- 系列2（2回目以降: DrawAxes=false で重複描画を防ぐ） ---
h2 = plot_scatter_template(ax, obs, model2, ...
    'MarkerColor', 'r', 'DisplayName', 'd4PDFv2', ...
    'MaxLim', 2.5, 'DrawAxes', false, 'AnnotateStats', true);

% --- 凡例 ---
lg = legend([h1 h2], 'Location', 'southeast', 'FontSize', cfg.FONT_SIZE-1);
lg.Box = 'on';

exportgraphics(f, 'example_scatter_template.png', 'Resolution', cfg.OUT_RES);
close(f);
