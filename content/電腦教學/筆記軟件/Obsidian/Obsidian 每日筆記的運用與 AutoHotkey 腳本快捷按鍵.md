# 目錄

承襲 `Roam Rsearch`，`Obsidian` 將 `Daily Notes`(每日筆記)獨立成單獨的按鈕，在啟用後就能在左側邊欄點擊(`Settings`→`Plugins`→`Daily Notes`)，以建立以日期為檔名的 `.md` 檔。

- [[#啟用|啟用]]
- [[#檔名格式|檔名格式]]
- [[#每日筆記的作用|每日筆記的重要]]
- [[#用AutoHotkey產生日期連結文字|用AutoHotkey產生日期連結文字]]

##  啟用

設定裡同時可設定專屬的每日筆記存放資料夾與樣板檔名，設定了樣板後，點擊 `Daily Notes` 按鈕後會以設定好的檔名產生樣板內容的檔案。

- 日期格式: 自訂
- 自訂格式: `YYYY--MM-DD_ddd`     例: `2026-06-06_週六`
- 新檔案儲存目錄: `每日筆記`
- 模板檔案位置:   `模板/每日筆記.md`

![[assets/Obsidian 每日筆記的運用與 AutoHotkey 腳本快捷按鍵/Pasted image 20260606143951.png]]
![[assets/Obsidian 每日筆記的運用與 AutoHotkey 腳本快捷按鍵/Pasted image 20260606150922.png]]

## 檔名格式

檔名(亦即內部連結名稱)的格式可以在設定裡指定，我是使用「**YYYY-MM-DD_ddd**」的格式，因此會產生「2020-07-03_Fri」、「2020-07-04_Sat」這樣的檔名，加上星期幾會起到部份記憶的作用。

## 每日筆記的作用

通常我們可以如上來使用每日筆記：
- 早上到公司後必辦事項清單
- 待辦事項
- 預訂今天要完成的任務
- 本日工作記錄
- 健康紀錄，如喝了多少水
- 工作效率紀錄，專心工作的分鐘數
- 不勝枚舉，自由發揮

## 用AutoHotkey產生日期連結文字

- 輸入 `d0` 產生本日日期連結，如 `[[2026-06-06_週六]]`
- 輸入 `d+1` 產生明日日期連結，`d+2` 是後天
- 輸入 `d-1` 產生昨日日期連結，`d-2` 是前天
- 按〔Ctrl+q〕顯示日期選擇對話窗，選好按〔OK〕產生日期連結字串

在資料夾: 每日筆記 下，建立一個新筆記的索引檔 **筆記總覽** ，裡面先輸入一 **內部連接**:

```yaml
- [[2026-06-06_週六]]
```
用 `Ctrl` + `Shift` + `click` 這個連結，就可以開啟 `2026-06-06_週六` 筆記。

使用 `Autohotkey` 來加速輸入以上內容。

▼ AutoHotkey 腳本
   [AutoHotkey Scripts for obsidian.md](https://gist.github.com/emisjerry/39e3dee49b4237267d12d45244991187)  

  `obsidian.ahk`
   
```markdown
;; Scripts for obsidian.md|
;; http://jdev.tw/blog|
;; v0.1 2020/07/02 jerry|
#SingleInstance Force|

:O*:d0::|
;; 0409 language code for USA|
FormatTime, vToday,L0x0409, yyyy-MM-dd_ddd|
send [[%vToday%]]|
return|

:O*:d+1::|
sendDate(1)|
return|

:O*:d+2::|
sendDate(2)|
return|

:O*:d-1::|
sendDate(-1)|
return|

:O*:d-2::|
sendDate(-2)|
return|

; 由Obsidian網站找到的腳本，我做了點小修改，以產生USA格式|
; Date picker|
defaultdate := %A_YYYY%%A_MM%%A_DD%|

^q::|
Gui, Add, Text, x10 y15 w60 h20, StartDate:|
Gui, Add, DateTime, x+10 y10 wp20 h20 vStartDate Choose%defaultdate% Section,|

Gui, Add, Text, x10 y55 w70 h20 , StartTime:|
Gui, Add, DateTime, x+10 y50 wp hp vStartTime Choose%defaultdate%000000 1, HH:mm ;time|

Gui, Add, Button, x10 y90 w60 h20 Default, &OK|
Gui, Show, w220 h130, AHK-Scheduler|
Return|


ButtonOK:|
Gui, submit, Hide|
defaultdate = %StartDate%|
FormatTime, StartDate, %StartDate% L0x0409, yyyy-MM-dd_ddd|

Send [[%StartDate%]]|
Gui, Destroy|
return|

GuiClose:|
Gui Destroy|
return|

GuiEscape:|
Gui Destroy|
return|

sendDate(iDay) {|
;; 0409 language code for USA|
iDate := A_Now|
;; iToday += 1, Days|
EnvAdd, iDate, %iDay%, Days|
FormatTime, iDate,%iDate% L0x0409, yyyy-MM-dd_ddd|
send [[%iDate%]]|
    return iDate|
    }|
```
   
▼ 下載 [obsidian-ahk.exe](https://drive.google.com/file/d/1qSnFQKukwv5g2o8VLXUV10hIvQkqUfWT/view?usp=sharing)



- [[#樣板範例|樣板範例]]
  以下是一些來自 `Obsidian` 論壇或 `Roam Research` 用戶的一些分享，各位可據此聯想、參考，以建立自己的每日筆記樣板：
  
  ```yaml
  - [[tasks]]
    - [] 任務1
    - [] 任務2

  - [[daily habits]]
  - [[tracking]]
  - [[journal]]
  ```


  ```yaml
  ## Start-of-Day Reflections

  ### I am grateful for...
  1.
  2.
  3.

  ### What would make today great?
  1.
  2.
  3.

  ### Affirmation
  _I am..._

  ---

  ## Schedule

  *### Meetings*

  *### Work blocks*

  --- 

  ## Work Log

  ---

  ## Assorted Thoughts

  ---

  ## End-of-Day Reflections

  ### What did I learn?

  ### What am I working on?

  ### What am I struggling with?
  #### Is there help I can get from others?
  ```  

```yaml
## Todays Priorities
1 -
2 -
3 -

## How are you?
## Yesterday’s Notes
#ate:
#drank:
#slept:
#exercised:
#highlights:
#reflections:

## Greatful For?
## Today’s Thoughts
## Things I found today
## Thinking ahead
```


```yaml
## Organizing the day

#### Highlight of the day
- [x] #tags, [links](), **formatting** supported
- [x] item 2

#### Think of TODOs for today
- [ ]  item 1

#### Summary of the day

## Hourly notes
```

↓`Roam Reasearch` 的語法，必須修改成 `Obsidian` 支援的寫法

```yaml
> [The daily template I use for Roam Research https://roamresearch.com/ · GitHub](https://gist.github.com/jborichevskiy/51508eebc810ae8105be45beac4e16ac)

- Weekly Agenda (created on a different day, and embedded with `/Block Reference`)
- [[Morning Questions]]
    - {{[[slider]]}} How many hours of sleep did I get?
    - What's one thing top of mind today?
    - What's the one thing I need to get done today to make progress?
    - Review #[[Index: Questions]] #values
- Agenda
    - {{[[TODO]]}} Morning walk #goal-health #habit
    - {{[[TODO]]}} Check calendar for scheduled events 
    - {{[[TODO]]}} Morning focus hour
        - {{[[TODO]]}} Read 30 minutes #goal-learning #habit
    - {{[[TODO]]}} Review Readwise.io 
    - {{[[TODO]]}} 10 minutes meditation #goal-health #habit
    - {{[[TODO]]}} Workout or run #goal-health #habit
    - {{[[TODO]]}} Evening focus hour
        - {{[[TODO]]}} Do 7 - 30 - 90 review
    - {{[[TODO]]}} read for pleasure, watch something, go for a walk
- [[Evening Questions]] 
    - List three things I'm grateful for #habit #gratitude 
    - What made me happy today?
    - What made me sad?
    - Where there any signs of my day going to shit that I could recognize?
    - What prevented me from reaching my goals today?
    - What am I looking forward to?
```

- [[#教學影片|教學影片]]

  ![](https://youtu.be/Gt0E0TOmdZg)

tags: #obsidian
