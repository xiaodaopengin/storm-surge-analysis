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
end