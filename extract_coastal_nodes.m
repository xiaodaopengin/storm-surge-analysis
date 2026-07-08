function [Icoast, coast_lon, coast_lat] = extract_coastal_nodes(mesh_nc, depth_thresh, n_adj_min, n_adj_max)
% extract_coastal_nodes  ADCIRCメッシュ(maxele.nc等)から海岸線付近のノードを抽出する
%
% 使い方:
%   Icoast = extract_coastal_nodes(mesh_nc);
%   Icoast = extract_coastal_nodes(mesh_nc, 500, 1, 4);
%   [Icoast, coast_lon, coast_lat] = extract_coastal_nodes(mesh_nc);
%
% 入力:
%   mesh_nc      - ADCIRC maxele.nc 等のファイルパス（'x','y','element','depth'変数を含む）
%   depth_thresh - 水深しきい値 [m]（デフォルト 500）。この水深以下のノードを「浅水域」とみなす
%   n_adj_min    - あるノードに隣接する浅水域要素数の下限（デフォルト 1）
%   n_adj_max    - あるノードに隣接する浅水域要素数の上限（デフォルト 4）
%                  → 浅水域要素に囲まれすぎていない（=沖合ではなく海岸線に近い）ノードを抽出する条件
%
% 出力:
%   Icoast     - 海岸線付近のノードインデックス（元メッシュのインデックス番号）
%   coast_lon  - （オプション）該当ノードの経度 [-180, 180] にラップ済み
%   coast_lat  - （オプション）該当ノードの緯度
%
% 例:
%   mesh_nc = 'D:\research\data\global_stormsurge\HPB_m001\output\maxele_195101.nc';
%   [Icoast, coast_lon, coast_lat] = extract_coastal_nodes(mesh_nc);

    if nargin < 2 || isempty(depth_thresh), depth_thresh = 500; end
    if nargin < 3 || isempty(n_adj_min),    n_adj_min = 1;      end
    if nargin < 4 || isempty(n_adj_max),    n_adj_max = 4;      end

    ele    = ncread(mesh_nc, 'element')';
    depth  = double(ncread(mesh_nc, 'depth'));

    elevec = reshape(ele, [], 1);
    Id     = find(depth <= depth_thresh);

    n_adj = zeros(length(depth), 1);
    for i = 1:8
        [t1, ~, t3] = intersect(Id, elevec);
        n_adj(t1) = n_adj(t1) + 1;
        elevec(t3) = NaN;
    end

    Icoast = find(n_adj >= n_adj_min & n_adj <= n_adj_max);

    if nargout > 1
        x_m = wrapTo180(double(ncread(mesh_nc, 'x')));
        y_m = double(ncread(mesh_nc, 'y'));
        coast_lon = x_m(Icoast);
        coast_lat = y_m(Icoast);
    end
end
