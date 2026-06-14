
## 架構

Obsidian Vault
↓
Quartz
↓
GitHub
↓
Cloudflare Pages
↓
公開網站

---

# 第 1 步：確認環境

## Git

```bash
git --version
```

## Node.js

```bash
node -v
npm -v
```

建議使用 Node.js LTS 版本。

---

# 第 2 步：建立 GitHub Repository

Repository Name：

```text
obsidian-blog
```

類型：

```text
Public
```

---

# 第 3 步：建立 Quartz

```bash
cd %USERPROFILE%
git clone https://github.com/jackyzha0/quartz.git
cd quartz
npm install
npx quartz create
```

初始化完成後：

```bash
npx quartz plugin install --from-config
```

若使用：

```text
Symlink an existing folder
```

會造成 `Quartz` 資料夾下的 `content` 會  `JUNCTION` 到 `%Userprofile%/Obsidian Valut/Allen Valut`，致使資料無法正常上傳到 `GitHub`。

請檢查 `.gitignore` 是否忽略 `.quartz/`。

---

# 第 3-1 步：檢查 Git Remote

```bash
git remote -v
```

確認：

```text
origin https://github.com/你的帳號/obsidian-blog.git
```

若錯誤：

```bash
git remote set-url origin https://github.com/你的帳號/obsidian-blog.git
```

---

# 第 3-2 步：GitHub PAT 權限

若使用 Personal Access Token：

至少勾選：

```text
repo
workflow
```

切勿把 Token 寫入文件或提交到 GitHub。

---

# 第 3-3 步：檢查 Embedded Git Repository

部署前：

```bash
git status
```

若出現：

```text
warning: adding embedded git repository
```

表示有 Plugin 內含 `.git`。

檢查：

```bash
git submodule status
```

或：

```bash
dir .quartz\plugins
```

---

# 第 3-4 步：移除 Plugin 內部 .git

例如：

```bash
rmdir /s /q .quartz\plugins\alias-redirects\.git
```

所有 Plugin 都應移除其內部 `.git`。

---

# 第 4 步：啟動 Quartz

```bash
npx quartz build --serve
```

成功後：

```text
http://localhost:8080
```

---

# 第 5 步：接入 Obsidian Vault

將 Vault 內容放入：

```text
quartz/content
```

例如：

```text
content/
├─ AI
├─ Obsidian
└─ index.md
```

---

# 第 6 步：首頁

建立：

```text
content/index.md
```

---

# SPA 中文路徑問題

修改：

```text
quartz.config.ts
```

將：

```ts
enableSPA: true
```

改為：

```ts
enableSPA: false
```

---

# 第 7 步：發布到 GitHub

```bash
git init
git add .
git commit -m "first publish"
git branch -M main
git push -u origin main
```

---

# 第 8 步：Cloudflare Pages

Framework Preset：

```text
None
```

Build Command：

```bash
npx quartz build
```

Build Output Directory：

```text
public
```

Root Directory：

```text
空白
```

Environment Variables：

```text
無
```

---

# 第 8-1 步：Cloudflare 常見錯誤

## 錯誤

```text
Could not resolve ../../.quartz/plugins
```

原因：

```text
.quartz/plugins 未被提交到 GitHub
```

---

## 錯誤

```text
No url found for submodule path
```

原因：

```text
Plugin 被當成 Git Submodule
```

解法：

1. 刪除 Plugin 內部 `.git`
2. 重新 Commit
3. Push 到 GitHub
4. 刪除 Cloudflare Pages 專案
5. 重新建立 Pages 專案

---

# 本次實際踩坑紀錄

## 問題 1：Remote 指向 Quartz 官方 Repo

症狀：

```text
403 Permission denied
```

解法：

```bash
git remote set-url origin https://github.com/你的帳號/obsidian-blog.git
```

---

## 問題 2：PAT 權限不足

症狀：

```text
refusing to allow a Personal Access Token to create or update workflow
```

解法：

增加：

```text
workflow
```

權限。

---

## 問題 3：Plugin 被當成 Submodule

症狀：

```text
warning: adding embedded git repository
```

Cloudflare：

```text
No url found for submodule path
```

原因：

Plugin 目錄內存在 `.git`。

---

## 問題 4：Cloudflare 快取舊部署資訊

即使 GitHub 已修正仍失敗。

解法：

```text
刪除 Pages 專案
重新建立
```

---

# 第 9 步：日後更新網站

```bash
git add .
git commit -m "update notes"
git push
```

Cloudflare 會自動重新部署。
幾十秒後網站更新。

---

# 部署成功檢查清單

- Git Remote 正確
- GitHub PAT 權限正確
- Plugin 無 .git
- git submodule status 無異常
- Cloudflare Build Command = npx quartz build
- Build Output Directory = public
- Root Directory 留空
- GitHub Push 成功
- Cloudflare Deploy Success


## 新增、修改、刪除筆記後，建議固定照以下流程

1. 在 Obsidian 修改筆記
    例如：
   - 新增筆記
   - 修改筆記
   - 刪除筆記
   - 新增圖片

    完成後存檔。

2. 執行 `C:\Users\allen\quartz\publish.bat`，內容如下:

    ```yaml
    @echo off

    echo ====================
    echo Sync Vault  
    echo ====================  
  
    robocopy "C:\Users\allen\Obsidian Vault\Allen Vault" "C:\Users\allen\quartz\content" /MIR /XD "C:\Users\allen\Obsidian Vault\Allen Vault\.obsidian"

    echo ====================  
    echo Quartz Build  
    echo ====================  

    cd C:\Users\allen\quartz  
    call npx quartz build

    echo ====================  
    echo Git Push
    echo ====================
    git add .
    git commit -m "update"
    git push

    pause 
    ```

## Quartz 專案架構

```yaml
myblog/
├── content/
│   ├── index.md
│   ├── CTF/
│   │   ├── index.md
│   │   ├── Nmap常用命令.md
│   │   └── assets/
│   ├── Linux/
│   │   └── index.md
│   ├── Docker/
│   │   └── index.md
│   ├── 数据库/
│   │   └── index.md
│   ├── 工具教程/
│   │   └── index.md
│   └── 随笔/
│       └── index.md
├── quartz/
├── quartz.config.yaml
├── quartz/
│   └── static/
│       └── icon.png
├── .github/
│   └── workflows/
│       └── deploy.yml
├── .gitignore
└── package.json
```

## Quartz 網站加入圖片放大、縮小

### 功能

- 黑色背景
- 圖片放大
- 滑鼠滾輪縮放
- 拖曳移動
- `ESC` 關閉

### 步驟 1

打開：

```
C:\Users\allen\quartz\quartz\components\Head.tsx
```

找到 </HEAD> 在前面加入：

```HTML
<link  rel="stylesheet"  href="https://cdnjs.cloudflare.com/ajax/libs/viewerjs/1.11.7/viewer.min.css"/><script src="https://cdnjs.cloudflare.com/ajax/libs/viewerjs/1.11.7/viewer.min.js"></script><script src="/static/viewer-init.js"></script>
```

---

### 步驟 2

把：

```
C:\Users\allen\quartz\quartz\components\scripts\viewer.inline.ts
```

編輯成：

```js
document.addEventListener("DOMContentLoaded", initViewer)document.addEventListener("nav", initViewer)function initViewer() {  const article = document.querySelector("article")  if (!article) return  const oldViewer = (article as any)._viewer  if (oldViewer) {    oldViewer.destroy()  }  ;(article as any)._viewer = new (window as any).Viewer(article, {    toolbar: true,    navbar: false,    title: false,    movable: true,    zoomable: true,    rotatable: true,    scalable: true,  })}
```

---

### 步驟 3

重新發布

```
publish.bat
```

---

## 步驟 4

部署完成後

F12 → Console

輸入：

```
typeof Viewer
```

應該會變成：

```
"function"
```

---

## Quartz 修改字體與布景

1. 樣式引用檔:  `C:\Users\allen\auartz\quartz\styles\base.scss`
   加入 `@use "./custom.scss";`

   ```css
   @use "sass:map";

   @use "./variables.scss" as *;
   @use "./syntax.scss";
   @use "./callouts.scss";
   @use "./custom.scss";
        :
   ```


### 1. 字體

修改 `C:\Users\allen\quartz\quartz\styles\custom.scss`

```css
:root {  
  --bodyFont: "Microsoft JhengHei", sans-serif;  
  --headerFont: "Microsoft JhengHei", sans-serif;  
  --codeFont: "Consolas", monospace;  
}

body {  
   font-size: 18px;  
   line-height: 1.8;  
}  
  
h1,h2,h3,h4,h5 {  
   font-weight: 700;  
}  
  
.page-title {  
   font-size: 2rem;  
}
```

### 2. 修改整體字體大小

修改 `C:\Users\allen\quartz\quartz\styles\custom.scss`

```css
:root {
  --bodyFont: "Microsoft JhengHei", sans-serif;
  --headerFont: "Microsoft JhengHei", sans-serif;
}

body {
  font-size: 18px;
}
```

### 3. 改成 Obsidian 風格

修改 `C:\Users\allen\quartz\quartz\styles\custom.scss`

```css
body {
  font-size: 18px;
  line-height: 1.8;
}

h1,h2,h3,h4,h5 {
  font-weight: 700;
}

.page-title {
  font-size: 2rem;
}
```

### 4. 修改配色

修改 `C:\Users\allen\quartz\quartz\styles\custom.scss`

```css
:root[saved-theme="light"] {
  --light: #ffffff;
  --lightgray: #f5f5f5;
  ...
}
```

  要改成類似 `Obsidian Dark`

```css
:root[saved-theme="dark"] {
  --light: #1e1e1e;
  --lightgray: #2d2d2d;
  --gray: #999;
  --dark: #e0e0e0;
  --secondary: #8ab4f8;
}
```

---

## 使用 quartz-themes

### 1. 設定檔

 `quartz.config.yaml`

```css
:
- source:
    name: quartz-themes
    repo: github:saberzero1/quartz-themes
    subdir: plugin
  enabled: true
  options:
    theme: default
```

### 2. 查詢所有 Theme 名稱

執行：

```bash
cd C:\Users\allen\quartz\.quartz\plugins\quartz-themes
# 列出所有 themes
dir /b src\themes\*.json
# 列出所有含有 obsidian 的主題：
dir /b src\themes\*obsidian*.json

dir /b src\themes\*tokyo*.json

dir /b src\themes\*nord*.json
```

即可列出全部主題。

## 3. 如何切換 Theme

修改：

```
.quartz\quartz.config.yaml
```

中的：

```
options:  theme: default
```

例如改成：

```
options:  theme: obsidian
```



window.innerWidth   1920
getComputedStyle(document.querySelector("#quartz-body")).gridTemplateColumns  220px 1450px 250px

@media (min-width: 1400px) {

  html body .page #quartz-body {
    grid-template-columns:
      200px
      minmax(1000px, 1fr)
      200px !important;
  }
}


## 新增 favicon 網站圖標

準備一個圖示檔：

```yaml
icon.png
```

放到：

```yaml
quartz/static/icon.png
```

然後本地測試：

`npx quartz build --serve`

瀏覽器打開：

`http: //localhost:8080`

若圖示沒立刻變化，按：

`Ctrl + F5`

或用無痕視窗查看。

確認沒問題後：

`Ctrl + P` → `Git`：提交並同步

## ## 新增 Google Analytics 存取統計

### 1. 開啟 `Google Analytics`

打開： `https://analytics.google.com/`

建立帳號和媒體資源。
如果它問商家資訊：
- 業界類別：互聯網與電信
- 業務規模：小型- 1至10名員工

選擇資料來源時選擇： 網站Web
網站網址填寫注意：
- 左邊選擇https: //
- 右邊只填你的使用者名稱.github .io

例如：

mooi-max.github.io

不要再寫在右邊或。`http://` `https://`

資料流名稱可以寫： 不錯的博客

創建完成後，複製： `衡量ID/Measurement ID`
格式是： `G-XXXXXXXXXX`

### 2. 修改 Quartz 配置

打開： `quartz.config.ts`
找到：

分析：{
  提供者：“合理的”，
},

或者：

分析： null ，

改成：

分析： 

```yaml
{
  provider : "google" ,  tagId:  "G-XXXXXXXXXX" ,
}
```

 > 把`G-XXXXXXXXXX` 換成你自己的衡量ID。
 
本地測試：

`npx quartz build --serve`

沒報錯後同步：
`Ctrl + P` → `Git`：提交並同步

等 `GitHub Actions` 部署成功後，打開網站，再去 `Google Analytics` 的即時報告查看是否有存取記錄。

## ## SEO 優化

### 1. 站點標題

	在`quartz.config.ts`中設定：

	pageTitle:  "Mooi 的網路安全與技術筆記" ,

### 2. 基本網址

確認：

baseUrl:  "你的用戶名.github.io" ,

例如：
baseUrl:  "nice-max.github.io" ,

### 3. 首頁描述

打開： `content/index.md`

頂部寫：

```yaml
---
title: 首頁
description:  Mooi 的個人技術筆記，記錄 CTF、網路安全、Linux、Docker、資料庫、工具教學和學習複盤。
---
```
--- 
### 4. 文章描述

每篇文章頂部建議寫：

```yaml
---
title:  Nmap常用指令
description: 記錄 Nmap 在 CTF 和靶機測試中的常用掃描指令、參數說明和實戰用法。
date:  2026-04-29
標籤: 
  -  CTF 
  -  Nmap 
  - 資訊收集
```

### 5. 圖片 alt
   不要寫：

   ```yaml
   ![](assets/1.png)
   ```
   
   建議寫：

   ```yaml
   [Nmap 掃描結果示例](assets/nmap-scan-result-01.png)
   ```

---

## 代碼塊樣式優化

打開： `quartz/styles/custom.scss`

保留： 

```yaml
@use **"./base.scss"**;

// put your custom CSS here!
```

在底部添加：

```yaml
/* ==============================

   Code Block Style_

   簡潔代碼塊樣式

   ============================== */

:not(pre) > code {

  padding: 0.18rem 0.42rem;

  margin: 0 0.08rem;

  border-radius: 6px;

  font-size: 0.88em;

  font-family:

    "JetBrains Mono",

    "Cascadia Code",

    "Fira Code",

    "Consolas",

    "Menlo",

    monospace;

    background: color-mix(in srgb, var(--secondary) 12%, transparent);

    color: var(--secondary);

    border: 1px solid color-mix(in srgb, var(--secondary) 18%, transparent);

    white-space: break-spaces;

}

pre {

  position: relative !important;

  margin: 1.35rem 0;

  padding: 1.15rem 3.4rem 1.15rem 1.15rem !important;

  min-height: 3.2rem;

  border-radius: 14px;

  overflow-x: auto;

  overflow-y: visible !important;

  font-size: 0.92rem;

  line-height: 1.7;

  font-family:

    "JetBrains Mono",

    "Cascadia Code",

    "Fira Code",

    "Consolas",

    "Menlo",

    monospace;

    background: #1f2933 !important;

    color: #e5e7eb;

    border: 1px solid rgba(148, 163, 184, 0.22);

    box-shadow:

    0 10px 24px rgba(0, 0, 0, 0.14),

    inset 0 1px 0 rgba(255, 255, 255, 0.04);

}

pre code {

  display: block;

  padding: 0 !important;

  margin: 0 !important;

  font-size: inherit;

  line-height: inherit;

  font-family: inherit;

  background: transparent !important;

  color: inherit;

  border: none !important;

  white-space: pre;

  tab-size: 2;

}

pre span {

  font-family: inherit;

}

pre::-webkit-scrollbar {

  height: 8px;

}

pre::-webkit-scrollbar-track {

  background: rgba(255, 255, 255, 0.05);

  border-radius: 999px;

}

pre::-webkit-scrollbar-thumb {

  background: rgba(148, 163, 184, 0.48);

  border-radius: 999px;

}

pre::-webkit-scrollbar-thumb:hover {

  background: rgba(148, 163, 184, 0.78);

}
```

以後寫代碼塊時建議寫語言名：

```bash

nmap -sC -sV 192.168.56.105

```
```sql
select * from student;
```

```python
print("hello")
```

## 網站背景優化

繼續修改： `quartz/styles/custom.scss`

在底部添加：

```html
/* ==============================
   Mooi Blog - Simple Background
   暗色：科技賽博朋克
   亮色：明亮暖白
   ============================== */

html,
body {
  min-height: 100%;
}

body {
  background-attachment: fixed;
  background-repeat: no-repeat;
  background-position: center top;
}

/* 暗色模式：深藍黑 + 藍紫科技光暈 */
:root[saved-theme="dark"] body {
  background:
    radial-gradient(circle at 15% 10%, rgba(34, 211, 238, 0.18), transparent 28rem),
    radial-gradient(circle at 85% 12%, rgba(168, 85, 247, 0.2), transparent 30rem),
    radial-gradient(circle at 50% 105%, rgba(59, 130, 246, 0.12), transparent 32rem),
    linear-gradient(135deg, #050816 0%, #08111f 45%, #111827 100%);
}

/* 亮色模式：明亮暖白，不帶藍色光感 */
:root[saved-theme="light"] body {
  background:
    radial-gradient(circle at 16% 10%, rgba(255, 255, 255, 0.95), transparent 28rem),
    radial-gradient(circle at 86% 12%, rgba(255, 247, 237, 0.55), transparent 30rem),
    radial-gradient(circle at 50% 105%, rgba(250, 250, 250, 0.92), transparent 32rem),
    linear-gradient(135deg, #ffffff 0%, #fafafa 50%, #f6f6f4 100%);
}

/* 暗色模式：正文區域輕微玻璃卡片感 */
:root[saved-theme="dark"] article {
  background: rgba(8, 13, 28, 0.56);
  border-radius: 16px;
  border: 1px solid rgba(148, 163, 184, 0.14);
  box-shadow: 0 14px 36px rgba(0, 0, 0, 0.22);
}

/* 亮色模式：正文區域乾淨白色卡片感 */
:root[saved-theme="light"] article {
  background: rgba(255, 255, 255, 0.78);
  border-radius: 16px;
  border: 1px solid rgba(148, 163, 184, 0.14);
  box-shadow: 0 14px 34px rgba(15, 23, 42, 0.06);
}

/* 暗色模式：標題輕微科技光效 */
:root[saved-theme="dark"] article h1 {
  text-shadow: 0 0 22px rgba(34, 211, 238, 0.12);
}

/* 亮色模式：標題保持清爽 */
:root[saved-theme="light"] article h1 {
  text-shadow: none;
}
```

保存後本地測試： `npx quartz build --serve`

## 圖片管理規範

建議：
1. 圖片儘量壓縮
2. 檔案名用英文或拼音
3. 不要用空格和特殊符號
4. 每個目錄使用 assets 資料夾

推薦：
content/CTF/assets/nmap-scan-01.png
content/Docker/assets/docker-network-01.png
content/Linux/assets/linux-permission-01.png

不推薦：
截圖 2026-04-29 這個很重要！！！.png

## 自訂功能變數名稱說明

不買功能變數名稱也可以正常使用：
https://你的用戶名.github.io/

如果以後想買功能變數名稱，功能變數名稱不能只叫： `mooi`
必須是完整功能變數名稱，例如：

```yaml
mooi.top
mooi.icu
mooi.dev
mooi.blog
```

如果買的是根功能變數名稱，例如： `mooi.top`
需要在 `GitHub Pages` 填寫 `Custom domain`，並在功能變數名稱服務商添加 `DNS` 解析。
如果使用子功能變數名稱，例如： `blog.mooi.top`
`DNS` 中添加 `CNAME` 指向：
你的用戶名.github.io

## 隱藏特定筆記

### 方法 1：同步時直接排除（推薦）

你目前是用：

```
robocopy "C:\Users\allen\Obsidian Vault\Allen Vault" "C:\cloud1\project\quartz\content" /MIR
```

改成：

```
robocopy ^"C:\Users\allen\Obsidian Vault\Allen Vault" ^"C:\cloud1\project\quartz\content" ^/MIR ^/XD ".obsidian" "模板" "每日筆記"
```

這樣：

```
Obsidian├─ 每日筆記├─ 模板└─ 電腦教學
```

同步到 Quartz 後變成：

```
content└─ 電腦教學
```

網站自然就不會出現。

---

### 方法 2：使用 draft（較不推薦）

在資料夾內所有筆記加：

```
---draft: true---
```

Quartz 不會發布。

但是：

```
每日筆記模板
```

資料夾本身仍可能出現在 Explorer。

---

### 方法 3：Quartz 直接忽略資料夾（推薦）

編輯：

```
quartz.config.ts
```

加入：

```
ignorePatterns: [  "**/.obsidian/**",  "**/模板/**",  "**/每日筆記/**",]
```

例如：

```
configuration: {  pageTitle: "Allen 技術筆記",  ignorePatterns: [    "**/.obsidian/**",    "**/模板/**",    "**/每日筆記/**",  ],}
```

然後：

```
npx quartz build
```

或

```
npx quartz build --serve
```

---

### 方法 4：只隱藏 Explorer

如果你想：

```
網址仍可開啟但左側不顯示
```

修改：

```
quartz/components/Explorer.tsx
```

增加過濾：

```
const hiddenFolders = [  "模板",  "每日筆記",]
```

不過每次升級 Quartz 都可能被覆蓋。

--- 

### 建議架構

同步命令改成：

### 方法 1：robocopy 排除子資料夾（推薦）

假設 Obsidian Vault 結構：

```
電腦教學
├─ 筆記軟件
│  ├─ Obsidian
│  └─ Logseq
├─ 資料庫
└─ 程式語言
```

同步時改成：

```
robocopy ^
"C:\Users\allen\Obsidian Vault\Allen Vault" ^
"C:\cloud1\project\quartz\content" ^
/MIR ^
/XD ".obsidian" ^ 
"電腦教學\筆記軟件"
```

這樣 Quartz 會看到：

```
電腦教學
├─ 資料庫
└─ 程式語言
```

而不會看到：

```
電腦教學\筆記軟件
```

### 方法 2：Quartz ignorePatterns（推薦）

在 `quartz.config.ts` 中：

```yaml
configuration: {  
  ignorePatterns: [ 
    "**/電腦教學/筆記軟件/**",
  ],
}
```

或更寬鬆：

```yaml
configuration: {  
  ignorePatterns: [    
    "**/筆記軟件/**",  
  ],
}
```

之後重新建置：

```bash
npx quartz build
```

---

### 方法 3：只隱藏 Explorer 顯示

如果你希望：

```
網址仍可直接開啟但左側目錄不要顯示
```

則需要修改 Quartz 的 `Explorer.tsx`，過濾：

```
const hiddenFolders = [  "筆記軟件"]
```

但這種方式較麻煩，而且 Quartz 升級後可能失效。


```yaml
robocopy ^
"C:\Users\allen\Obsidian Vault\Allen Vault" ^
"C:\cloud1\project\quartz\content" ^
/MIR ^
/XD ".obsidian" "模板" "每日筆記" "私人筆記" "Archive"
```

