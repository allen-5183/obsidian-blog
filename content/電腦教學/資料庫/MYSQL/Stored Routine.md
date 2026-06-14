
## 前言

`Stored Routine`（儲存常式）是 `MySQL` 的統稱。

官方文件通常寫：

```sql
Stored Routines
```
指的是：

```sql
Procedure + Function
```

**Procedure**
`Stored Procedure`（儲存程序）是 `Stored Routine` 的其中一種。

特性：

- 可以有 `IN` / `OUT` 參數
- 可以執行多個 `SQL`
- 可以控制 `Transaction`
- 不一定回傳值
- 用 `CALL` 執行

例如: 
```sql
CREATE PROCEDURE add_dept(
    IN p_deptno INT,
    IN p_dname VARCHAR(20)
)
BEGIN
    INSERT INTO dept
    VALUES (p_deptno,p_dname);
END;
```
  
執行:

```sql
CALL add_dept(10,'HR');
``````

**Function**

`Function` 也是 `Stored Routine`。
但它比較像程式語言中的**函式**。

必須：

```sql
RETURN 某個值
```
例如:
```sql
CREATE FUNCTION get_bonus(
    salary INT
)
RETURNS INT
BEGIN
    RETURN salary * 0.1;
END;
```

使用 :

```sql
SELECT get_bonus(50000);
```

結果：

```yaml
5000
```


**兩者都屬於： `Stored Routine`**，差異

| 項目                  | `Procedure` | `Function` |
| ------------------- | ----------- | ---------- |
| 屬於 `Stored Routine` | ✅           | ✅          |
| 必須回傳值               | ❌           | ✅          |
| `RETURN`            | 可有可無        | 必須         |
| 呼叫方式                | `CALL`      | `SELECT`   |
| 可出現在 `SQL` 表達式      | ❌           | ✅          |
| `OUT` 參數            | ✅           | ❌          |
| 適合                  | 流程處理        | 計算邏輯       |
## Stored Routines 的應用

在資料庫管理系統的應用中，不論是一般或網頁的應用程式，它們在執行查詢與維護資料的時候，都必須使用 `SQL` 敘述請資料庫執行各種不同的工作。
一些比較複雜的應用程式需求，經常會發生需要處理類似下列一組工作的情況:

![[assets/Pasted image 20260609161354.png]]

`SQL` 敘述的特點是一次只能執行一件工作，所以要完成上列的工作，就必須執行好幾個 `SQL` 敘述。如果經常執行這一組工作，就可以考慮把這些要執行的敘述建立為 「Stored procedure」元件。

![[assets/Pasted image 20260609162047.png]]

把這一組工作建立為 `Stored procedure` 元件，以後需要執行這些工作的時候，就可以呼叫 (`call`) 這個建立好的 `Stored procedure` 元件:
![[assets/Pasted image 20260609162309.png]]

要建立人口數比 「USA」多的國家表格時，只要傳入指定的國家代碼就可以了:
![[assets/Pasted image 20260609162439.png]]

`Stored procedure` 是 `Stored routines` 其中一種元件，可以視需要在資料庫建立許多不同用途的 `Stored pricedure` 元件。它可以包含需要執行的一組工作，也可以依照需求設定參數資料，例如上例範例的國家代碼。呼叫這些建立好的 `Stored procedure` 可以幫你省掉很多繁複的工作，請資料庫一次完成所有需要執行的敘述。

`Stored routines` 另外提供一種 「 Stored functions」元件，除了 `MySQL` 資料庫提供許多各種不同的函式外，你也可以建立自己得函式，這種函式稱為 `Stored functions`。 例如下列的範例:
![[assets/Pasted image 20260609163222.png]]
你可以自己建立一個名稱為 「ROUND2」的 `Stored functions`，這個函式固定將一個指定的數值四捨五入到小數兩位:
![[assets/Pasted image 20260609163423.png]]

建立好需要的 `Stored function` 元件以後，它的用途就跟你在使用 `MSQL`提供的函式一樣:
![[assets/Pasted image 20260609163605.png]]

你可以在資料庫中建立許多需要的 `Srtored functions`，把一些比較複雜工作建立為 ` Stored functions` 元件以後，就可以跟使用 `MySQL` 提供的函式一樣來使用它們，同樣可以簡化許多繁複的工作。

	`MySQL` 資料庫管理系統把 `Stored procedures` 與 `Stored functions` 合稱為 ` Stored routines`。 `Stored procedures` 通常會簡稱為 「procedures」，`Stored function` 通常會簡稱為 「functions」。
	
### Stored Procedures 介紹

`Stored procrdures` 元件是一種可以建立、維護與刪除的資料庫元件。表格元件是用來儲存資料用的，索引元件是儲存索引與增加效率用的，而 `Stored procedures` 元件是用來 「儲存程序」用的。程序表示一組特定的工作，如果在使用資料庫的過程中，經常需要執行一組同樣的工作，你就可以考慮把執行工作需要的敘述建立為 `Stored procedures` 元件。下列是建立 `Stored procedures` 元件的基本語法。
![[assets/Pasted image 20260609170135.png]]

下列是刪除 `Stored procedured` 元件的基本語法:
![[assets/Pasted image 20260609173228.png]]

下列是呼叫 `Stored procedured` 元件的基本語法:
![[assets/Pasted image 20260609173554.png]]

### Stored Functions 介紹

如果 `MySQL` 提供的函式無法完成你的工作，或是想要改善一些比較複雜的工作，你可以自己建立需要的 `Stored functions` 元件。跟 `Stored procedures` 一樣，它也是一種用來 「儲存程序」的元件，不過建立好的 `Stored procedures` 元件要使用 「CALL」呼叫，也就是請資料庫執行儲存在 `Stored procedures` 中的工作。要使用建立好的 `Stored functions` 元件，就跟使用 `MySQL` 提供的函式一樣的用法。下列是建立 `Stored functions` 元件的基法語法:
![[assets/Pasted image 20260609174351.png]]

下列是刪除`Stored functions` 元件的基法語法: 
![[assets/Pasted image 20260609174433.png]]

## 在 MySQL Workbench 管理 Stored routines

`Stored routines` 元件中可以包含許多要執行的 `SQL` 敘述，在後續的說明中，它也可以包含宣告與設定變數，還有控制執行流程的指令。所以 `Stored routines` 元件其實就是有一點類似開發應用程式用的程式語言，不過它不會像程式語言那麼複雜，而且大部分都是跟資料庫相關的 `SQL` 敘述。

### SQL Script、DELIMITER 與 Stored routines

建立需要的 `stored routines` 元件使用 「CREATE PROCEDURE」或  「CREATE FUNCTION」敘述，雖然它們跟其它的 `SQL` 敘述一樣，也是請資料庫執行一件工作，不過 `Stored routines` 通常會包含許多需要的敘述，所以通常會使用 「SQL script」來執行建立 `Stored routine` 的工作。

`SQL script` 是一個包含許多 `SQL` 敘述的檔案，你可以把想要執行的 `SQL` 敘述都集中在一個檔案。以建立範例資料庫的 「cmd.sql」檔案來說，它的內容會像這樣:
![[assets/Pasted image 20260609180742.png]]

`MySQL` 使用分號作為預設的 「delimiter」，`MySQL` 在執行檔案中的敘述時，以 `delimiter` 來分辨一個 `SQL` 敘述的範圍。 `MySQL` 提供的 「DELIMITER」
指令，可以修改預設的 `delimiter` 符號:
![[assets/Pasted image 20260609181106.png]]

一般的應用通常不會去修改預設的 `delimiter` 符號，可是在建立 `Stored routines` 元件的 `SQL script` 檔案就需要使用了。下列是建立 `Stores procedure` 元件的基本內容 :
![[assets/Pasted image 20260609181526.png]]

現在準備建立一個的 `Stored procedure` 元件，在 「MySQL Workbench」中選擇功能表 「File -> New Query Tab」，輸入下列建立 `procedure` 的敘述:
![[assets/Pasted image 20260609182011.png]]

完成建立 `procedure` 的敘述以後，選擇 `MySQL Workbench` 功能表 「Query -> Execute(All or Selection)」，執行以後如果沒有發生任何錯誤，就可以在 `Stored Procedures` 目錄下看到新建立的 `procedure` 元件:
![[assets/Pasted image 20260609181923.png]]

上列範例所建立的 「show_countries」 `procedure` 元件，只有包含一個查詢國家資料的敘述，如果一個 `procedure` 元件執行的工作只是這樣的話，就不需要建立 `procedure` 元件。所以 `procedure` 元件通常會包含許多要執行的敘述，這時候就一定要使用 「BEGIN」與 「END」。下列是建立包含多個敘述的 `Stored procedure` 元件基本架構:
![[assets/Pasted image 20260609182956.png]]

下列的 「my_world_count」 `procedure` 元件，它可以一次查詢國家、語言與城市三個表格的數量:
![[assets/Pasted image 20260609183223.png]]

使用 `SQL script` 建立 `function` 元件，同樣要使用 「DELIMITER」關鍵字設定 `delimiter`。「CREATE FUNCTION」的語法另外包含 「RETURNWS」與「RETURNW」兩個關鍵字。下列是建立 ` Stored functions` 元件的基本內架構:
![[assets/Stored Routine/IMG-20260609194226531.png]]

以下列的 「my_date」 `stored function` 來說，它會傳回 「年/月/日 時:分:秒 星期」格式的日期時間資料:
![[assets/Stored Routine/IMG-20260609194447550.png]]

如果 `function` 元件包含許多要執行的敘述，也一定要使用 「BEGIN」與 「BED」。 下列是建立包含多個敘述的 `Stored functions` 元件基本架構:
![[assets/Stored Routine/IMG-20260609194721974.png]]

下列的 「my_date2」`Stored function` 元件，因為包含多個需要執行的敘述，所以一定要使用 「BEGIN」與 「BED」。
![[assets/Stored Routine/IMG-20260609194924057.png]]

### 管理 Stored Procedure

除了使用 `SQL script` 建立需要的 `Stored Procedures`，你也可以使用 `MySQL Workbench` 提供的功能來管理 ` Stored Procedures`。 如果需要建立新的 `procedure` 元件:
![[assets/Stored Routine/IMG-20260609195234675.png]]

`MySQL Workbench` 會幫你建立一個基本的 `procedure` 樣板:
![[assets/Stored Routine/IMG-20260609195334059.png]]

完成這個 `procedure` 的內容以後，選擇 `Apply` 按鈕:
![[assets/Stored Routine/IMG-20260609195431879.png]]

`MySQL Workbench` 顯示準備執行的內容，它會自動為你加入一些需要的敘述，例如 `USE` 與 `DELIMETER` 敘述。 選擇 「Apply」按鈕執行建立 `precedure` 的工作:
![[assets/Stored Routine/IMG-20260609195702471.png]]

如果沒有任何錯誤，`MySQL Workbench` 已經建立好 `procedure` 元件，選擇 「Finish」 按鈕:
![[assets/Stored Routine/IMG-20260609195831286.png]]

在 `Stored Procedures` 目錄下可以看到新建立的 `procedure` 元件:
![[assets/Stored Routine/IMG-20260609195928435.png]]

如果需要修改或刪除已經建立好的 `procedure`，同樣可以在 `MySQL Workbench` 執行需要的工作:
![[assets/Stored Routine/IMG-20260609200047368.png]]

### 管理 Stored Functions

你也可以使用 `MySQL Workbecnch` 管理 ` Stored functions`。如果需要建立新的 `function` 元件:
![[assets/Stored Routine/IMG-20260609200216630.png]]

`MySQL Workbench` 會幫你建立一個基本的 `function` 樣板:
![[assets/Stored Routine/IMG-20260609200309308.png]]

完成這個 ` function` 的內容以後，選擇 「Apply」 按鈕 :
![[assets/Stored Routine/IMG-20260609200418804.png]]

`MySQL Workbench` 顯示準備執行的內容，它會自動為你加入一些需要的敘述，例如 `USE` 與 `DELEMITER` 敘述。 選擇 「Apply」按鈕執行建立 `function` 的工作:
![[assets/Stored Routine/IMG-20260609200640519.png]]

如果沒有任何錯誤，`MySQL  Workbench` 已經建立好 `function` 元件，選擇 「Finish」按鈕:
![[assets/Stored Routine/IMG-20260609200820924.png]]

在 `Function` 目錄下可以看到新建立的 `function` 元件 :
![[assets/Stored Routine/IMG-20260609200907896.png]]

如果需要修改或刪除已經建立好的 `function`，同樣可以在 `MySQL Workbench` 執行需要的工作:
![[assets/Stored Routine/IMG-20260609201027573.png]]

## Stored Routines 的參數

`Stored routines` 可以使用參數(`parameters`)讓使用者傳送資料給它使用，`procedures` 與 `functions` 都可以依照需要決定參數的個數與型態。

### 1. Stored Functions 的參數

   `Function` 參數的決定會比 `procedure` 簡單，`function` 的參數用來接收需要使用的資料。 你必須決定每一個參數的名稱和型態，再依照自己決定的順序定義在 `function` 中:
    ![[assets/Stored Routine/IMG-20260609201538990.png]]

  以下列一個提供合計功能的 `function` 來說，它需要兩個 「INT」型態的整數參數:
   ![[assets/Stored Routine/IMG-20260609201751611.png]]

  在呼叫 「my_summary」的時候，依照參數的定義，指向兩個要合計的整數數值，這個 `function` 會將兩個傳入的整數數值加起來後回傳給你:
  ![[assets/Stored Routine/IMG-20260609202043819.png]]

  在呼叫 `function` 的時候，一定要依照參數的定義，傳送正確個數的參數資料:
  ![[assets/Stored Routine/IMG-20260609202245747.png]]

  除了參數的個數外，你也要遵守參數型態的規定:
  ![[assets/Stored Routine/IMG-20260609202334906.png]]

  一個 `function` 的定義不一定需要參數，以下例的範例來說，呼叫 「。y_date」時不需要傳送任何參數資料，不過無論是否需要參數，在呼叫 `function` 時，名稱後面的左右括號是不可以省略的:
  ![[assets/Stored Routine/IMG-20260609202629065.png]]
    
### 2. Stored Procedures 的參數

  `Procedure` 參數的定義與 `function` 大致上相同，除了必須決定每一個參數的名稱、型態與順序，你還需要決定每一個參數的用途:
   ![[assets/Stored Routine/IMG-20260609202837897.png]]

   下列是 `procedure` 參數用途的說明:
   - `IN`: 「輸入、input」用的參數。這種參數與 `function` 中的參數完全一樣，在呼叫 `procedure` 時傳送資料給 `procedure` 使用。
   - `OUT`: 「輸出、output」用的參數。在呼叫 `procedure` 時，不能接收傳送的資料，不過 `procedure` 在執行的時候，可以設定這種參數的值，新的值在執行完成後，可以回傳給呼叫的地方使用。
   - `INOUT`: 「輸入與輸出、 input 與 output」用的參數。同時具有 「IN」與 「OUT」兩種用途。

   下例是說明這三種用途參數的範例:
   ![[assets/Stored Routine/IMG-20260609203631090.png]]

   呼叫 `procedure` 時一定要依照定義的參數個數與型態來傳送資料:
   ![[assets/Stored Routine/IMG-20260609203744568.png]]

  如果違反參數用途上的規定就會發生錯誤:
  ![[assets/Stored Routine/IMG-20260609203845033.png]]

  所以在呼叫 `procedure` 的時候，「OUT」與 「INOUT」 參數必須指定變數名稱，這是因為 「OUT」與 「INOUT」參數在執行完成後會回傳資料，使用變數名稱才可以接收 `procedure` 回傳的資料:
  ![[assets/Pasted image 20260609205041.png]]
  
  執行 `procedure` 以後，指定給 「OUT」與 「INOUT」的變數名稱，就會儲存在 `procedure` 中設定的值:
  ![[assets/Pasted image 20260609205009.png]]
  
  如果在呼叫 `
