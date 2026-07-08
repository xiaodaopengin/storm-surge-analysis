function layout = layout_config(varargin)
% layout_config  地図・カラーバーのレイアウト設定
%
% 使い方:
%   layout = layout_config();                              % デフォルト値
%   layout = layout_config('cb_wind_gap_global', 0.03, ...
%                           'lat_ticks', [-60 -30 0 30 60]); % 一部だけ上書き
%
% 呼び出し側の使用例（plot_combined 内）:
%   L = layout_config();
%   h_cm = w_cm * (lat_range/lon_range) * L.h_scale + L.h_offset;
%   h_cm = max(h_cm, L.h_min);
%   ...
%   lat_ticks = L.lat_ticks(L.lat_ticks >= lims(3) & L.lat_ticks <= lims(4));
%   setm(ax, ..., 'PLineLocation', L.parallel_line_spacing, ...);
%   ...
%   set(ax, 'Position', [ax_pos_orig(1), ax_pos_orig(2)+L.ax_dy, ...
%                        ax_pos_orig(3)*L.ax_w_scale, ax_pos_orig(4)*L.ax_h_scale]);

    p = inputParser;

    % ---------------- 図全体サイズ ----------------
    addParameter(p, 'W2', 17);          % 図の幅 [cm]（2カラム幅）
    addParameter(p, 'h_scale', 0.6);    % 高さ = W2*(lat_range/lon_range)*h_scale + h_offset
    addParameter(p, 'h_offset', 5.0);   % 高さのオフセット [cm]
    addParameter(p, 'h_min', 9);        % 高さの下限 [cm]

    % ---------------- 地図軸(ax)の位置調整 ----------------
    % 地図を上に寄せて、下部にsurgeカラーバー用の余白を確保する
    addParameter(p, 'ax_dy', 0.12);        % 上方向シフト量（Position(2)への加算）
    addParameter(p, 'ax_w_scale', 0.92);   % 幅の縮小率
    addParameter(p, 'ax_h_scale', 0.88);   % 高さの縮小率

    % ---------------- 緯度の表示設定 ----------------
    addParameter(p, 'lat_ticks', [-45 -30 -15 0 15 30 45]);  % 緯線を引く緯度
    addParameter(p, 'parallel_line_spacing', 15);             % PLineLocation（経線間隔[deg]）
    addParameter(p, 'meridian_label_global', 'off');          % GLOBAL図で経度ラベルを出すか
    addParameter(p, 'meridian_label_regional', 'on');         % 地域図で経度ラベルを出すか

    % ---------------- Windカラーバー（右・縦） ----------------
    addParameter(p, 'cb_wind_gap_global', 0.02);      % 地図右端とのすき間（GLOBAL）
    addParameter(p, 'cb_wind_gap_regional', 0.02);    % 地図右端とのすき間（地域図）
    addParameter(p, 'cb_wind_width', 0.02);           % カラーバー幅
    addParameter(p, 'cb_wind_y_offset_global', 0.00);     % 縦位置オフセット（GLOBAL）
    addParameter(p, 'cb_wind_y_offset_regional', -0.02);  % 縦位置オフセット（地域図）
    addParameter(p, 'cb_wind_unit_x', 1.5);           % 単位ラベル[%]等のx位置（カラーバー座標系）
    addParameter(p, 'cb_wind_unit_y_offset', 0.7);    % 単位ラベルのy位置オフセット（n_bins+この値）

    % ---------------- Surgeカラーバー（下・横） ----------------
    addParameter(p, 'cb_surge_y_offset_global', -0.04);   % 地図下端とのすき間（GLOBAL）
    addParameter(p, 'cb_surge_y_offset_regional', -0.10); % 地図下端とのすき間（地域図）
    addParameter(p, 'cb_surge_x_margin', 0.02);       % 左右マージン
    addParameter(p, 'cb_surge_height', 0.025);        % カラーバー高さ
    addParameter(p, 'cb_surge_unit_x_offset', 0.7);   % 単位ラベルのx位置オフセット（n_bins+この値）
    addParameter(p, 'cb_surge_unit_y', 0.5);          % 単位ラベルのy位置（カラーバー座標系, 0〜1）

    % ---------------- 目盛り・ラベルのフォントサイズ ----------------
    addParameter(p, 'tick_fontsize_offset', -4);   % 基準fsizeからの差分（目盛り数字）
    addParameter(p, 'unit_fontsize_offset', -2);   % 基準fsizeからの差分（[%]等の単位ラベル）

    parse(p, varargin{:});
    layout = p.Results;
end
