# plot_scatter_template 導入手順（パッチ適用ガイド）

このディレクトリには、散布図テンプレート機能を追加するための
パッチファイル `0001-plot_scatter_template.patch` が含まれています。
以下の手順でリポジトリに取り込んでください。

## 追加・変更されるファイル

| ファイル | 種別 | 内容 |
|---|---|---|
| `plot_style_config.m` | 変更 | 散布図用の共通スタイル既定値（`SCATTER_*`）を追加 |
| `plot_scatter_template.m` | 新規 | 汎用散布図テンプレート関数本体 |
| `example_scatter_template_usage.m` | 新規 | 使用例スクリプト |

## 手順

### 1. パッチファイルをリポジトリのルートに置く

`storm-surge-analysis` フォルダの直下（`.git` フォルダがある場所）に
`0001-plot_scatter_template.patch` をコピーします。

### 2. パッチを適用する

ターミナル（Git Bash / WSL / macOS・Linuxのターミナルなど）で、
リポジトリのルートに移動して以下を実行します。

```bash
cd /path/to/storm-surge-analysis
git am 0001-plot_scatter_template.patch
```

成功すると、以下のようなメッセージが表示されます。

```
Applying: 散布図テンプレート追加: plot_scatter_template
```

### 3. 適用されたか確認する

```bash
git log --oneline -1
```

以下のように表示されていればOKです。

```
c31d195 散布図テンプレート追加: plot_scatter_template
```

ファイルが増えているかも確認できます。

```bash
git status
ls plot_scatter_template.m example_scatter_template_usage.m
```

### 4. GitHubへpush する

```bash
git push origin main
```

これでGitHub上のリポジトリに反映されます。

---

## うまくいかない場合

### `git am` がエラーになる（コンフリクトなど）

一度中断してやり直せます。

```bash
git am --abort
```

その後、パッチを使わず「個別ファイルをそのまま配置する方法」に切り替えてください
（下記参照）。

### 個別ファイルを直接配置する方法（代替手段）

パッチの代わりに、以下3ファイルをダウンロードして
リポジトリ直下にそのまま配置しても同じ結果になります。

- `plot_style_config.m`（既存ファイルを上書き）
- `plot_scatter_template.m`（新規追加）
- `example_scatter_template_usage.m`（新規追加）

配置後：

```bash
git add plot_style_config.m plot_scatter_template.m example_scatter_template_usage.m
git commit -m "散布図テンプレート追加: plot_scatter_template"
git push origin main
```

---

## 動作確認（MATLAB）

適用後、MATLABで以下を実行するとサンプル図が生成されます。

```matlab
example_scatter_template_usage
```

`example_scatter_template.png` が出力されれば正常に動作しています。
