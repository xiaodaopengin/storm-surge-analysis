# plot_scatter_template

論文用の散布図を統一スタイルで描画するための MATLAB 汎用テンプレート関数です。

## 標準スタイル（統一済み）

- 軸枠線: `Box on`, `LineWidth 0.8`
- 1:1 基準線: `k--`, `LineWidth 0.5`
- グリッド: `GridAlpha 0.3`
- マーカー: `MarkerEdgeColor none`（縁取りなし）

これらは `HPB_vs_HCE_correlation` スクリプトのスタイルに合わせて統一しています。
今後、新しい散布図を作る際は本テンプレートを呼び出すことで
スタイルの不統一（Box未指定、1:1線の太さ違いなど）を防げます。

## ファイル構成

- `plot_scatter_template.m` : 本体関数
- `example_usage.m` : 使用例（ダミーデータで動作確認可能）

## 使い方

```matlab
f = paper_figure(8, 8);
ax = gca;

% 1系列目（軸・1:1線・グリッドも同時に描画）
h1 = plot_scatter_template(ax, obs, model1, ...
    'MarkerColor', 'b', 'DisplayName', 'd4PDF', 'MaxLim', 2.5);

% 2系列目以降（DrawAxes=false で重複描画を防ぐ）
h2 = plot_scatter_template(ax, obs, model2, ...
    'MarkerColor', 'r', 'DisplayName', 'd4PDFv2', ...
    'MaxLim', 2.5, 'DrawAxes', false);

legend([h1 h2], 'Location', 'southeast');
exportgraphics(f, 'out.png', 'Resolution', 300);
```

詳細なオプションは `help plot_scatter_template` を参照してください。

## 変更履歴

- v1.0 (2026-07-09): Obs vs Model overlay 散布図の枠線・1:1線・グリッドスタイルを
  HPB vs HCE 散布図に統一する形でテンプレート化。
