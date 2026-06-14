
## 前言

`Obsidian` 的面板開啟在固定的區域，當開啟多個水平面板時，每個面板 `Panel` 的寬度會減少而不會出現水平捲軸。

## 預設佈景主題使用 Custom CSS

### 方法 1：開啟 CSS Snippets

進入：

```
設定→ 外觀 (Appearance)
```

往下捲動到：

```
CSS 片段 (CSS Snippets)
```

會看到：

```
📂 開啟 snippets 資料夾
```

按下去。

---
### 方法 2：手動建立 CSS

Obsidian Vault 目錄下會有：

```
.vscode.obsidian
```

在：

```
.obsidian/snippets/
```

建立：

```
custom.css
```

![[電腦教學/筆記軟件/Obsidian/assets/Obsidian 水平捲動面板的設定方法/Pasted image 20260605210955.png]]

例如：

```css
/* Andy Matuschak Mode */

.workspace-split.mod-root {
    overflow-x: auto !important;
}

.workspace-leaf,
.workspace-tabs {
    min-width: 650px !important;
}

.workspace-split.mod-vertical {
    overflow-x: auto !important;
}
```

---

### 方法 3：啟用 CSS

建立完成後：

```
設定→ 外觀→ CSS 片段
```

按：

```
重新載入 CSS 片段
```

然後把：

```
custom.css
```

右側開關打開。

---

![[電腦教學/筆記軟件/Obsidian/assets/Obsidian 水平捲動面板的設定方法/Pasted image 20260605233719.png]]

---
## 變更預設樣式使用 Custom CSS

開啟 `Community Themes`

 外觀 (`Appearance`) → 主題 (`Themes`)  → 管理 (`Manage`)

![[電腦教學/筆記軟件/Obsidian/assets/Obsidian 水平捲動面板的設定方法/Pasted image 20260605212141.png]]

**假設** 選擇了 `Solarized` 的 `theme`， 會在  `倉庫\.obsidian\themes` 下產生與布景主題同名稱的資料夾 `Solarized`，資料夾下會生成 `theme.css`。

將下面 `css` 添加到 `theme.css` 的最後面。

```css
/* Andy Matuschak Mode */

.workspace-split.mod-root {
    overflow-x: auto !important;
}

.workspace-leaf,
.workspace-tabs {
    min-width: 650px !important;
}

.workspace-split.mod-vertical {
    overflow-x: auto !important;
}
```

![[assets/Obsidian 水平捲動面板的設定方法/Pasted image 20260605234838.png]]


## 總結

透過水平捲動面板的方法，讓同一篇筆記要接續閱讀時更容易閱讀。


## 補充

1. 讓筆記字體變大
    方法一:  使用 `Ctrl` + `i` 鍵 與 `Ctrl` + `=` 
    方法二:  設定 > 外觀 > 視窗框架樣式 > `Obsidian` 框架 
    ![[assets/Obsidian 水平捲動面板的設定方法/Pasted image 20260606122127.png]]
    ![[assets/Obsidian 水平捲動面板的設定方法/Pasted image 20260606122457.png]]
    
## 教學影片

  ![](https://youtu.be/rQhIxz27Gek)

tags: #obsidian