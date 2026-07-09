function h = plot_return_period_template(ax, T, Y, varargin)
% plot_return_period_template  論文用・再現期間プロットの標準テンプレート
%
% d4PDF(HPB/+2K/+4K) vs GESLA観測 比較図のスタイルに統一した汎用関数。
% 対数横軸(1〜1000年) / Box on / 軸枠線太さ0.8 / GridAlpha 0.3 を
% 標準スタイルとして固定しているので、再現期間図のスタイルを常に統一できる。
% スタイルの既定値は plot_style_config() から取得する。
%
% 使い方（モデル系列を複数重ねて観測点を重ねる）:
%   cfg = plot_style_config();
%   f  = paper_figure(cfg.W1, 7);
%   ax = axes(f); hold(ax, 'on');
%
%   h1 = plot_return_period_template(ax, T_common, RL_hpb, ...
%       'LineColor', cfg.colors_scenario.hpb, 'DisplayName', 'Hist');
%   h2 = plot_return_period_template(ax, T_common, RL_2k, ...
%       'LineColor', cfg.colors_scenario.k2, 'DisplayName', '+2K', ...
%       'DrawAxes', false);
%   h3 = plot_return_period_template(ax, T_common, RL_4k, ...
%       'LineColor', cfg.colors_scenario.k4, 'DisplayName', '+4K', ...
%       'DrawAxes', false);
%   hObs = plot_return_period_template(ax, obs_T, obs_S, ...
%       'Style', 'marker', 'DisplayName', 'Osaka', 'DrawAxes', false);
%
%   legend(ax, [h1 h2 h3 hObs], 'Location', 'northwest', ...
%       'NumColumns', 1, 'FontSize', cfg.FONT_SIZE-4);
%   exportgraphics(f, 'out.png', 'Resolution', cfg.OUT_RES);
%
% 入力:
%   ax - axes ハンドル（あらかじめ paper_figure 等で作成しておく）
%   T  - 再現期間 [yr]
%   Y  - 対応する値（潮位偏差など [m]）
%
% Name-Value オプション:
%   'Style'         'line'（モデル系列, 既定）| 'marker'（観測点）
%   'LineColor'     線の色（Style='line' 時, 既定値 'b'）
%   'LineWidth'     線の太さ（既定値は plot_style_config().RP_LINE_LW）
%   'MarkerSize'    マーカーサイズ（Style='marker' 時, 既定値は RP_OBS_MSZ）
%   'MarkerFaceColor' 観測点の塗りつぶし色（既定値 [0.3 0.3 0.3]）
%   'DisplayName'   凡例に表示する系列名（既定値 ''）
%   'XLabelStr'     X軸ラベル（既定値 'Return period [yr]'）
%   'YLabelStr'     Y軸ラベル（既定値 'Storm surge height [m]'）
%   'FontSize'      フォントサイズ（既定値は plot_style_config().FONT_SIZE）
%   'FontName'      フォント名（既定値は plot_style_config().FONT_NAME）
%   'FontWeight'    フォントウェイト（既定値は plot_style_config().FONT_WT）
%   'MaxT'          横軸上限 [年]（既定値は plot_style_config().RP_MAX_T）
%   'DrawAxes'      軸設定・グリッドを描画するか（既定値 true）
%                   複数系列を重ねる場合、2回目以降は false にする
%
% 出力:
%   h - この系列のプロットハンドル（凡例作成に利用可）

    cfg = plot_style_config();

    p = inputParser;
    addParameter(p, 'Style', 'line');
    addParameter(p, 'LineColor', 'b');
    addParameter(p, 'LineWidth', cfg.RP_LINE_LW);
    addParameter(p, 'MarkerSize', cfg.RP_OBS_MSZ);
    addParameter(p, 'MarkerFaceColor', [0.3 0.3 0.3]);
    addParameter(p, 'DisplayName', '');
    addParameter(p, 'XLabelStr', 'Return period [yr]');
    addParameter(p, 'YLabelStr', 'Storm surge height [m]');
    addParameter(p, 'FontSize', cfg.FONT_SIZE);
    addParameter(p, 'FontName', cfg.FONT_NAME);
    addParameter(p, 'FontWeight', cfg.FONT_WT);
    addParameter(p, 'MaxT', cfg.RP_MAX_T);
    addParameter(p, 'DrawAxes', true);
    parse(p, varargin{:});
    o = p.Results;

    axes(ax); hold(ax, 'on');

    % ---- データ本体 ----
    if strcmpi(o.Style, 'marker')
        h = plot(ax, T(:)', Y(:)', 'ko', ...
            'MarkerSize', o.MarkerSize, ...
            'MarkerFaceColor', o.MarkerFaceColor);
    else
        h = plot(ax, T(:)', Y(:)', '-', ...
            'Color', o.LineColor, 'LineWidth', o.LineWidth);
    end
    if ~isempty(o.DisplayName)
        h.DisplayName = o.DisplayName;
    end

    % ---- 軸・グリッド（1回だけ描画） ----
    if o.DrawAxes
        set(ax, 'XScale', 'log', ...
            'XTick', cfg.RP_XTICK, 'XTickLabel', cfg.RP_XTICKLABEL, ...
            'Box', 'on', ...
            'FontSize', o.FontSize, 'FontName', o.FontName, ...
            'FontWeight', o.FontWeight, ...
            'LineWidth', cfg.RP_AXIS_LW);
        xlim(ax, [1 o.MaxT]);

        xlabel(ax, o.XLabelStr, 'FontSize', o.FontSize, ...
            'FontName', o.FontName, 'FontWeight', o.FontWeight);
        ylabel(ax, o.YLabelStr, 'FontSize', o.FontSize, ...
            'FontName', o.FontName, 'FontWeight', o.FontWeight);

        grid(ax, 'on');
        set(ax, 'GridAlpha', cfg.RP_GRID_ALPHA);
    end

    hold(ax, 'off');
end
