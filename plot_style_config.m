function cfg = plot_style_config()
    cfg.FONT_NAME = 'Times New Roman';
    cfg.FONT_SIZE = 12;
    cfg.FONT_WT   = 'normal';
    cfg.OUT_RES   = 300;
    cfg.W2        = 17;

    cfg.MSZ_SURGE_GLOBAL = 5;
    cfg.MSZ_SURGE_REG    = 6;   % WNP等の地域図で共通利用
    cfg.MSZ_WIND_GLOBAL  = 1;
    cfg.MSZ_WIND_REG     = 8;

    % 色パレットもここに集約可能
    cfg.colors_wind = [ ... ];  % 15色配列

    % ---- 散布図テンプレート共通スタイル（plot_scatter_template.m で使用） ----
    % HPB vs HCE 散布図のスタイルに統一（Box on / 1:1線0.5 / GridAlpha 0.3）
    cfg.SCATTER_BOX          = 'on';
    cfg.SCATTER_AXIS_LW      = 0.8;   % 軸枠線の太さ
    cfg.SCATTER_1TO1_LW      = 0.5;   % 1:1基準線の太さ
    cfg.SCATTER_GRID_ALPHA   = 0.3;   % グリッドの濃さ
    cfg.SCATTER_MARKER_ALPHA = 0.45;  % マーカー透明度
    cfg.SCATTER_MARKER_SIZE  = 12;    % マーカーサイズ
end