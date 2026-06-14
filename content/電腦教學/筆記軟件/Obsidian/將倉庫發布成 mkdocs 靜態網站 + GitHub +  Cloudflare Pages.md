
## 架構

儲存庫(Allen Vault)
├─ .obsidian/            儲存庫設定資料夾
├─ docs/                 mkdoc's docs
│   ├─ index.md         mkdoc's 首頁
│   ├─ 電腦教學/        mkdoc's 文件內容
│   │   ├─ 資料庫/
│   │   │   ├─ MS-SQL 資料庫建置/
│   │   │   └─ MS-SQL 資料庫設計/
│   │   ├─ 筆記軟件/
│   │   ├─ 程式語言/
│   │   ├─ AI/
│   │   └─ 框架/
│
├─ mkdocs.yml            mkdoc's 設定檔
├─ requirements.txt
├─ .gitignore
└─ site/                 ← 不需上傳 GitHub，執行 mkdocs build 自動產生。

## 建置方式

### 1.1 


# 第一步：建立 requirements.txt

在：

```
Allen Vault/
```

建立：

```
requirements.txt
```

安裝:

```python
python -m pip install -r requirements.txt
```
內容：

```
mkdocs
mkdocs-material
mkdocs-glightbox
pymdown-extensions
```

如果你有安裝其他外掛，再加入即可。

---

# 第二步：建立 .gitignore

建立：

```
.gitignore
```

內容：

```
site/
.obsidian/
.cache/
.venv/
```

原因：

```
site
```

每次 build 都會重新產生。

```
.obsidian
```

是你個人設定。

通常不需要發布。

---

# 第三步：建立 GitHub Repository

例如：

```
Allen-Vault
```

然後：

```
git init
git add .
git commit -m "Initial Commit"
```

---

連接 GitHub：

```
git remote add origin https://github.com/你的帳號/Allen-Vault.git
git branch -M main
git push -u origin main
```

---

# 第四步：Cloudflare Pages

登入：

```
https://dash.cloudflare.com
```

進入：

```
組件 -> Workers 和 Pages
```



```
建立應用程式
```

![[assets/將倉庫發布成 mkdocs 靜態網站 + GitHub +  Cloudflare Pages/IMG-20260611182944476.png]]

```
想要部署 Pages? 開始使用
```

（在 Upload your static files 下方）

請點：

```
開始使用
```

![[assets/將倉庫發布成 mkdocs 靜態網站 + GitHub +  Cloudflare Pages/IMG-20260611182944490.png]]

# 有兩種部署方式

方式 1： 直接上傳（最快）
因為已經有：

```
Allen Vault
├─ docs
├─ mkdocs.yml
└─ site
```

而且：

```
mkdocs build
```

已成功執行。

所以可以直接選：

```
拖放您的檔案
```

右邊：

```
開始使用
```

---

### 接下來

Cloudflare 會要求：

```
專案名稱
```

例如：

```
allen-vault
```

---

然後上傳：

```
C:\Users\allen\Obsidian Vault\Allen Vault\site
```

裡面的所有內容。

例如：

```
site
├─ index.html
├─ assets
├─ search
├─ 電腦教學
```

⚠ 注意

不要上傳：

```
Allen Vault
```

整個資料夾。

也不要上傳：

```
docs
```

資料夾。

要上傳的是：

```
site
```

裡面的內容。

部署完成後會得到：

```
https://allen-vault.pages.dev
```

方式 2：GitHub 自動部署（推薦）

如果未來會常更新：

```
Obsidian↓新增筆記↓網站自動更新
```

建議選：

```
匯入現有 Git 存放庫
```

---

流程：

```
Allen Vault↓GitHub↓Cloudflare Pages
```

之後每次：

```
git push
```

網站就會自動更新。

不用再：

```
mkdocs build
```

然後手動上傳。

# 第五步：Build 設定

非常重要。

設定：

### Framework preset

選：

```
None
```

---
### Build command

填：

```
mkdocs build
```

---
### Build output directory

填：

```
site
```

---
### Root directory

留空：

```
/
```

---
# 第六步：Python 版本

Environment Variables：

新增：

```
PYTHON_VERSION
```

值：

```
3.11
```

---
# 第七步：Deploy

按：

```
Save and Deploy
```

Cloudflare 會：

```
GitHub   
  ↓
pip install -r requirements.txt   
  ↓
mkdocs build   
  ↓
產生 site   
  ↓
發布網站
```

---
# 發布成功後

你會得到：

```
https://allen-vault.pages.dev
```

例如：

```
https://allen-vault-8hk.pages.dev
```

---
# 如果有自己的網域

假設你目前有：

```
pic.allen5183.synology.me
```

可以新增：

```
docs.allen5183.synology.me
```


Cloudflare Pages：

```
Custom Domains
```

↓

```
docs.allen5183.synology.me
```

Cloudflare 會自動幫你建立 DNS。

之後變成：

```
https://docs.allen5183.synology.me
```

---
# 建議再優化 mkdocs.yml

加入：

```
theme:  
  name: material  
  language: zh-TW  
  
  features:    
    - navigation.tabs    
    - navigation.sections    
    - navigation.expand    
    - search.highlight    
    - search.suggest    
    - content.code.copy
```
效果：
✅ 左側樹狀目錄  
✅ 搜尋提示  
✅ 程式碼複製按鈕  
✅ 響應式手機版

---

# 之後更新流程

未來只要：

```
git add .
git commit -m "新增 MSSQL 教學"
git push
```


Cloudflare Pages 會自動：

```
重新 Build
↓
重新發布
```


完全不需要再手動執行：

```
mkdocs build
```


所以你的 Obsidian 流程會變成：

```
Obsidian    
   ↓
修改筆記    
   ↓
Git Push    
   ↓
Cloudflare Pages    
   ↓
網站自動更新
```

這是目前最適合維護大型技術知識庫（MSSQL、AI、程式語言、Obsidian 教學）的架構。

在 Cloudflare Pages 的部署頁面，要重新上傳有兩種方式：

### 方法 1：手動重新上傳（最快）

點右上角藍色按鈕：

```
建立部署
```

接著：

1. 選擇要部署的環境（通常是 Production）
2. 選擇你的網站檔案資料夾
3. 上傳
4. 等待部署完成

---

### 方法 2：透過 GitHub 自動部署（推薦）

如果你的專案已連接 GitHub：

```
git add .git commit -m "update"git push origin main
```

Cloudflare 會自動偵測到 `main` 分支更新並重新部署。

---

### 確認目前是 Git 還是手動上傳

你的畫面顯示：

```
Source: main
```

這通常代表已連接 Git 倉庫。

請點一下：

```
設定
```

然後看看是否有：

```
Git 儲存庫RepositoryBuild configuration
```

如果有，代表應該直接 `git push`，而不是手動上傳。

要刪除 Cloudflare Pages 專案 `allen-vault`：

### 方法一：從專案內刪除（推薦）

1. 點進 **allen-vault**
2. 點上方的 **設定（Settings）**
3. 拉到頁面最底部
4. 找到：

```
刪除此專案Delete Project
```

或

```
Danger Zone危險區域
```

5. 點擊 **Delete Project**
6. 輸入專案名稱：

```
allen-vault
```

7. 確認刪除

---

### 方法二：從列表頁

在你目前畫面中，`allen-vault` 這一列最右側有：

```
⋯
```

（三個點）

點開後如果新版介面支援，會出現：

```
設定刪除
```

直接選 **刪除** 即可。

---

### 注意

刪除後會同時移除：

- `allen-vault.pages.dev`
- 所有部署紀錄
- 自訂網域設定
- Pages Functions

而且**無法復原**。

如果你只是想重新上傳網站，通常不需要刪除專案，直接進入專案後按：

```
建立部署
```

重新上傳即可。