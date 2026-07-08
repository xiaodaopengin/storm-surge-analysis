function cmap = colormap_config(varargin)
% colormap_config  風速・高潮のビン境界／ラベル／色設定
%
% 使い方:
%   cmap = colormap_config();                       % デフォルト値を使用
%   cmap = colormap_config('edges_wind', myEdges, 'ticks_wind', myTicks);
%   cmap = colormap_config('edges_surge', myEdges2, 'ticks_surge', myTicks2);

    n_bins = 15;

    % ---- デフォルト値 ----
    default_edges_wind = [-Inf -97.5 -82.5 -67.5 -52.5 -37.5 -22.5 -7.5 ...
                            7.5 22.5 37.5 52.5 67.5 82.5 97.5 Inf];
    default_ticks_wind = {'<-97.5','-82.5','-67.5','-52.5','-37.5','-22.5','-7.5', ...
                           '0','7.5','22.5','37.5','52.5','67.5','82.5','>97.5'};

    default_edges_surge = [-Inf -39 -33 -27 -21 -15 -9 -3 3 9 15 21 27 33 39 Inf];
    default_ticks_surge = {'<-39','-33','-27','-21','-15','-9','-3', ...
                            '3','9','15','21','27','33','39','>39'};

    % ---- 引数パース（未指定ならデフォルト） ----
    p = inputParser;
    addParameter(p, 'edges_wind',  default_edges_wind);
    addParameter(p, 'ticks_wind',  default_ticks_wind);
    addParameter(p, 'edges_surge', default_edges_surge);
    addParameter(p, 'ticks_surge', default_ticks_surge);
    addParameter(p, 'label_wind',  'Wind speed difference (HCE - HPB) [m/s]');
    addParameter(p, 'label_surge', 'Storm surge difference (HCE - HPB) [m]');
    parse(p, varargin{:});

    edges_wind  = p.Results.edges_wind;
    ticks_wind  = p.Results.ticks_wind;
    edges_surge = p.Results.edges_surge;
    ticks_surge = p.Results.ticks_surge;

    % ---- 長さの整合性チェック（ビン数 = edges数 - 1）----
    assert(numel(edges_wind)-1 == numel(ticks_wind), ...
        'edges_wind (n=%d) と ticks_wind (n=%d) の数が一致しません。edges数-1 = ticks数 である必要があります。', ...
        numel(edges_wind), numel(ticks_wind));
    assert(numel(edges_surge)-1 == numel(ticks_surge), ...
        'edges_surge (n=%d) と ticks_surge (n=%d) の数が一致しません。', ...
        numel(edges_surge), numel(ticks_surge));

    cmap.n_bins       = n_bins;
    cmap.edges_wind   = edges_wind;
    cmap.ticks_wind   = ticks_wind;
    cmap.label_wind   = p.Results.label_wind;
    cmap.edges_surge  = edges_surge;
    cmap.ticks_surge  = ticks_surge;
    cmap.label_surge  = p.Results.label_surge;

    % ---- Wind colors: 紺(負) → 白(0) → 茶(正) ----
    cmap.colors_wind = [
        0.0200 0.0200 0.2000; 0.0300 0.0500 0.3000; 0.0500 0.1000 0.4000;
        0.1000 0.1800 0.5000; 0.1800 0.3000 0.5800; 0.3500 0.4500 0.6500;
        0.6500 0.7200 0.7800; 0.9400 0.9400 0.9400; 0.8000 0.7200 0.6200;
        0.7000 0.5500 0.4000; 0.6000 0.4000 0.2500; 0.5000 0.2800 0.1200;
        0.4000 0.1800 0.0500; 0.3000 0.1000 0.0200; 0.2000 0.0500 0.0000];

    % ---- Surge colors: jetベース ----
    jet_full = jet(512);
    jet_idx  = round(linspace(50, 462, n_bins));
    colors_surge = jet_full(jet_idx, :);
    cmap.colors_surge = colors_surge * 0.85 + 0.15;
end