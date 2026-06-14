
#### 這個軟體可以筆記高亮、換字體顏色之類的嗎？

### 方法一：使用兩個等號

用兩個半形等號讓文字變高亮度

```
`用兩個半形等於可以==讓某些文字==變高亮度`
```

用兩個半形等於可以==讓某些文字==變高亮度

- 參考： `Obsidian` 擴充的 `Markdown` 語法：[Basic formating syntax](https://obsidian.md/help/syntax)

### 方法二：修改 `CSS` 設定

例如變更**粗體**、_斜體_ 或 ~~刪除~~  的樣式以支援顏色。 修改檔案：保管箱(`vault`)根目錄裡的 ==倉庫\.obsidian\snippets\customer.css==：

```css
/* 粗體 */
strong {
  color: red;
}

/* 斜體 */
em {
  color: blue;
  --font-style: normal; /*不要斜體：刪除開頭的減號*/
}

/* 刪除 */
s,del {
  color: green;
  text-decoration: none;
}
```

### 方法三：`HTML` 標籤

#### 3.1. 文字顏色

在 `HTML` 標籤使用 `class` 屬性或 `style`。

例如使用 
- `font` 或 `span` 標籤：

```css
.red {
  color: red;
}

.bg-red {
  background-color: red;
}
```

  H<font color="#f00">ello</font>, World
  Hello, <span class="red">World</span>

- 使用 `style` 行內樣式
  Hello, <font style="color: red">World</span>.

### 3.2. 文字背景色

```html
Hello, <span class="bg-red">World</span>
```

  Hello, <span class="bg-red">World</span>

### 3.3. 整列 `row` 背景色

```html
<table width="100%">
    <tr>
        <td bgcolor=orange>背景色是：orange</td>
    </tr>
</table>
```

  <table width="100%">
    <tr>
        <td bgcolor=orange>背景色是：orange</td>
    </tr>
  </table>

  背景色是： `orange`

## 自行增加的樣式 (`customer.css`)

```css
.red {
  color: red;
}

.bg-red {
  color: white;
  background-color: red;
}

/* 粗體 */
strong {
  color: red;
}

/* 斜體 */
em {
  color: blue;
  --font-style: normal;
}

/* 刪除 */
s,del {
  color: green;
  text-decoration: none;
}
```

## 教學影片

  ![](https://youtu.be/994nPrmkXIA)

tags: #obsidian