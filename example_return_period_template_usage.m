%% plot_return_period_template 使用例（ダミーデータで動作確認可能）
%
% d4PDF(HPB/+2K/+4K) vs GESLA観測 の再現期間比較図を、
% plot_return_period_template を使って統一スタイルで描画する例。

rng(1);
cfg = plot_style_config();

T_common = [1 2 5 10 20 50 100 150 200 250 300 360];
RL_hpb = 1.0 + 0.3*log10(T_common) + 0.02*randn(size(T_common));
RL_2k  = RL_hpb + 0.05 + 0.02*randn(size(T_common));
RL_4k  = RL_hpb + 0.10 + 0.02*randn(size(T_common));

obs_T = [2 5 10 20 50];
obs_S = 1.0 + 0.28*log10(obs_T) + 0.05*randn(size(obs_T));

f  = paper_figure(cfg.W1, 7);
ax = axes(f); hold(ax, 'on');

h1 = plot_return_period_template(ax, T_common, RL_hpb, ...
    'LineColor', cfg.colors_scenario.hpb, 'DisplayName', 'Hist');
h2 = plot_return_period_template(ax, T_common, RL_2k, ...
    'LineColor', cfg.colors_scenario.k2, 'DisplayName', '+2K', ...
    'DrawAxes', false);
h3 = plot_return_period_template(ax, T_common, RL_4k, ...
    'LineColor', cfg.colors_scenario.k4, 'DisplayName', '+4K', ...
    'DrawAxes', false);
hObs = plot_return_period_template(ax, obs_T, obs_S, ...
    'Style', 'marker', 'DisplayName', 'Osaka', 'DrawAxes', false);

legend(ax, [h1 h2 h3 hObs], 'Location', 'northwest', ...
    'NumColumns', 1, 'FontSize', cfg.FONT_SIZE-4);

exportgraphics(f, 'example_return_period_template.png', 'Resolution', cfg.OUT_RES);
close(f);
