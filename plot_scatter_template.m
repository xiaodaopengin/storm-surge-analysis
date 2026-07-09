function h = plot_scatter_template(ax, x, y, varargin)
% plot_scatter_template  論文用・散布図の標準テンプレート
%
% HPB vs HCE 散布図（scatter_HPB_vs_HCE_correlation）のスタイルに統一した
% 汎用散布図関数。Box on / 1:1線(LineWidth 0.5) / GridAlpha 0.3 /
% 軸枠線太さ 0.8 を標準スタイルとして固定しているので、論文図のスタイルを
% 常に統一できる。スタイルの既定値は plot_style_config() から取得する。
%
% 使い方（単一系列）:
%   cfg = plot_style_config();
%   f = paper_figure(cfg.W2/2, cfg.W2/2);
%   plot_scatter_template(gca, obs, model, 'MarkerColor', 'b', ...
%       'DisplayName', 'Model A');
%
% 使い方（複数系列を重ねる）:
%   cfg = plot_style_config();
%   f = paper_figure(8, 8);
%   ax = gca;
%   h1 = plot_scatter_template(ax, obs, model1, ...
%       'MarkerColor', 'b', 'DisplayName', 'd4PDF');
%   h2 = plot_scatter_template(ax, obs, model2, ...
%       'MarkerColor', 'r', 'DisplayName', 'd4PDFv2', 'DrawAxes', false);
%   legend([h1 h2], 'Location', 'southeast');
%
% 入力:
%   ax  - axes ハンドル（あらかじめ paper_figure 等で作成しておく）
%   x   - 横軸データ（例: 観測値）
%   y   - 縦軸データ（例: モデル値）
%
% Name-Value オプション:
%   'MaxLim'        軸の最大値（省略時は x, y の最大値から自動計算）
%   'MinLim'        軸の最小値（既定値 0）
%   'MarkerColor'   マーカー色（既定値 'b'）
%   'MarkerSize'    マーカーサイズ（既定値は plot_style_config().SCATTER_MARKER_SIZE）
%   'MarkerAlpha'   マーカー透明度（既定値は plot_style_config().SCATTER_MARKER_ALPHA）
%   'DisplayName'   凡例に表示する系列名（既定値 ''）
%   'XLabelStr'     X軸ラベル（既定値 'Observation [m]'）
%   'YLabelStr'     Y軸ラベル（既定値 'Model [m]'）
%   'FontSize'      フォントサイズ（既定値は plot_style_config().FONT_SIZE）
%   'FontName'      フォント名（既定値は plot_style_config().FONT_NAME）
%   'FontWeight'    フォントウェイト（既定値は plot_style_config().FONT_WT）
%   'DrawAxes'      軸設定・1:1線・グリッドを描画するか（既定値 true）
%                   複数系列を重ねる場合、2回目以降は false にする
%   'Show1to1'      1:1 線を描画するか（既定値 true）
%   'AnnotateStats' R・RMSEを自動計算してテキスト表示するか（既定値 false）
%
% 出力:
%   h - この系列の scatter ハンドル（凡例作成に利用可）
%
% 例:
%   rng(1);
%   obs = rand(200,1)*2; model = obs + 0.15*randn(200,1);
%   f = paper_figure(8, 8);
%   plot_scatter_template(gca, obs, model, 'MarkerColor', 'b', ...
%       'DisplayName', 'Model A', 'MaxLim', 2.5, 'AnnotateStats', true);

    cfg = plot_style_config();

    p = inputParser;
    addParameter(p, 'MaxLim', []);
    addParameter(p, 'MinLim', 0);
    addParameter(p, 'MarkerColor', 'b');
    addParameter(p, 'MarkerSize', cfg.SCATTER_MARKER_SIZE);
    addParameter(p, 'MarkerAlpha', cfg.SCATTER_MARKER_ALPHA);
    addParameter(p, 'DisplayName', '');
    addParameter(p, 'XLabelStr', 'Observation [m]');
    addParameter(p, 'YLabelStr', 'Model [m]');
    addParameter(p, 'FontSize', cfg.FONT_SIZE);
    addParameter(p, 'FontName', cfg.FONT_NAME);
    addParameter(p, 'FontWeight', cfg.FONT_WT);
    addParameter(p, 'DrawAxes', true);
    addParameter(p, 'Show1to1', true);
    addParameter(p, 'AnnotateStats', false);
    parse(p, varargin{:});
    o = p.Results;

    axes(ax); hold(ax, 'on');

    valid = isfinite(x) & isfinite(y);
    xv = x(valid); yv = y(valid);

    if isempty(o.MaxLim)
        max_lim = max([xv(:); yv(:)], [], 'omitnan') * 1.05;
    else
        max_lim = o.MaxLim;
    end

    % ---- 散布図本体 ----
    h = scatter(ax, xv, yv, o.MarkerSize, 'filled', ...
        'MarkerFaceColor', o.MarkerColor, ...
        'MarkerFaceAlpha', o.MarkerAlpha, ...
        'MarkerEdgeColor', 'none');
    if ~isempty(o.DisplayName)
        h.DisplayName = o.DisplayName;
    end

    % ---- 統計量の注記（任意） ----
    if o.AnnotateStats && numel(xv) > 1
        rmse = sqrt(mean((yv - xv).^2));
        r    = corr(xv(:), yv(:));
        txt  = sprintf('%s: R=%.2f, RMSE=%.2f [m]', o.DisplayName, r, rmse);
        text(ax, 0.03*max_lim, 0.97*max_lim, txt, ...
            'BackgroundColor', 'w', 'EdgeColor', 'none', ...
            'FontSize', o.FontSize-2, 'FontName', o.FontName, ...
            'VerticalAlignment', 'top');
    end

    % ---- 軸・1:1線・グリッド（1回だけ描画） ----
    if o.DrawAxes
        if o.Show1to1
            % ★ 標準スタイル: 1:1線は LineWidth 0.5（plot_style_config().SCATTER_1TO1_LW）
            plot(ax, [o.MinLim max_lim], [o.MinLim max_lim], ...
                'k--', 'LineWidth', cfg.SCATTER_1TO1_LW);
        end

        axis(ax, 'square');
        xlim(ax, [o.MinLim max_lim]);
        ylim(ax, [o.MinLim max_lim]);

        xlabel(ax, o.XLabelStr, 'FontSize', o.FontSize, ...
            'FontName', o.FontName, 'FontWeight', o.FontWeight);
        ylabel(ax, o.YLabelStr, 'FontSize', o.FontSize, ...
            'FontName', o.FontName, 'FontWeight', o.FontWeight);

        grid(ax, 'on');
        % ★ 標準スタイル: グリッドの濃さ（plot_style_config().SCATTER_GRID_ALPHA）
        set(ax, 'GridAlpha', cfg.SCATTER_GRID_ALPHA);

        % ★ 標準スタイル: Box on + 軸線太さ（plot_style_config().SCATTER_AXIS_LW）
        set(ax, 'Box', cfg.SCATTER_BOX, ...
            'FontSize', o.FontSize, ...
            'FontName', o.FontName, ...
            'FontWeight', o.FontWeight, ...
            'LineWidth', cfg.SCATTER_AXIS_LW);
    end

    hold(ax, 'off');
end
