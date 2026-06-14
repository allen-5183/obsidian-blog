## 使用者變數

`MySQL` 資料庫伺服器提供一種簡易的儲存資料方式，稱為 「使用者變數、user variable」。使用者變數儲存一些簡單的資料，例如數字或字串，它們可以在後續的操作中使用。 下列是設定使用者變數的語法:

![[assets/Prepared Statements/IMG-20260608232912264.png]]

下列的敘述設定兩個儲存字串資料的使用者變數:
![[assets/Prepared Statements/IMG-20260609093948751.png]]

設定好使用者變數以後，可以在 「SELECT」敘述中查詢它們儲存的內容:
![[assets/Prepared Statements/IMG-20260609095316097.png]]

如果你需要設定多個變數的話，可以在一個 `SET` 敘述中設定多個需要的使用者變數:

```sql
SET @my_region = 'Eastern Asia', @my_region2 = 'Middle Asia'

```
使用查詢可以確認上列的敘述已經設定好的兩個使用者變數:

```sql
SELECT @my_region, @my_region2
```

使用 `SELECT` 敘述也可以設定需要的使用者變數，不過要特別注意指定的符號只能使用 `「:=」`:

![[assets/Prepared Statements/IMG-20260609101822530.png]]

下列的敘述設定兩個儲存整數資料的使用者變數，因為是使用 SELECT 敘述，所以設定好使用者變數以後，也會顯示設定的使用者變數內容:
![[assets/Prepared Statements/IMG-20260609102117020.png]]

再使用查詢敘述確認上列的敘述已經設定好的兩個使用者變數:
![[assets/Prepared Statements/IMG-20260609102318344.png]]

已經設定好的使用者變數，可以使用在大部分的敘述中，例如下列的範例使用變數來設定查詢敘述的條件設定:
![[assets/Prepared Statements/IMG-20260609102534284.png]]

使用 `SELECT` 敘述設定使用者變數的方式，也可以直接把查詢敘述傳回的資料儲存起來:
![[assets/Prepared Statements/IMG-20260609103006760.png]]

上述範例執行後所設定的使用者變數，也可以在後續的敘述中:
![[assets/Prepared Statements/IMG-20260609103208957.png]]

你也可以拿使用者變數來執行需要的運算:
![[assets/Prepared Statements/IMG-20260609103303430.png]]

`「LIMIT」` 子句指定的數字不可以使用變數。

## Prepared statements 的應用

一個資料庫在建立好並開始使用以後，資料庫伺服器就會接收各種不同的敘述來執行工作。 以查詢敘述來說，有一些敘述可能大部分的內容是差不多的，資料庫伺服器每次接收到敘述時，這時要依照流程執行一些同樣的工作。

以查詢敘述來說，有一些敘述可能大部份的內容都是一樣的，只有在條件的設定上會不一樣

![[assets/Prepared Statements/IMG-20260609104511086.png]]

```sql
SELECT Code, Name, GNP FROM country WHERE Code = 'USA' 
SELECT Code, Name, GNP FROM country WHERE Code = 'JPN'
```

如果有 「許多要執行的敘述，可是內容卻相似」的情況，可以用 「Prepared statements」改善資料庫的效率。首先，要把這種敘述先準備好:

```sql
PREPARE my_country FROM 'SELECT Code, Name, GNP FROM country WHERE Code = ?'
```
![[assets/Prepared Statements/IMG-20260609105331996.png]]

伺服器已經準備好的敘述就成為 「預存程序」，後續要使用這種敘述前，要先設定好 `prepared statement` 需要的資料，上列範例中，因為 `prepared statement` 的內容中有一個問號，所以要先設定好一個資料，也就是國家的代碼。然後再請伺服器執行指定的 `prepared statement`，伺服器就會傳回執行後的結果了。

```sql
SET @my_code = 'USA' 
EXECUTE my_country USING @my_code 

SET @my_code = 'JPN' 
EXECUTE my_country USING @my_code
```
![[assets/Prepared Statements/IMG-20260609110436255.png]]

## 建立、執行與移除 Prepared Statements

如果有 「許多要執行的敘述，可是內容卻相似的」的情形，就可以考慮請伺服器把這種敘述建立為 `prepared statement`。下列是建立 `prepared statement` 的語法:
![[assets/Pasted image 20260609113842.png]]

如果經常需要查詢某個國家的代碼、名稱與 `GNP` 的話，可以建立一個下列的 `prepared statement`。敘述中的問號是 「參數標記(parmeter marker)」，表示執行這個 `prepared statement` 需要一個參數資料:
![[assets/Pasted image 20260609114225.png]]

建立好需要的 prepared starement 以後，必須使用 `EXECUTE` 來執行它:
![[assets/Pasted image 20260609114330.png]]

執行一個 `prepared statement` 並不一定需要傳送資料給它，要依據 `prepared statement` 包含的敘述中有沒有問號來決定。如果有問號的話，一個問號就需先設定好一個使用者變數，然後再使用 `「USING」` 傳送資料給 `prepared statement` 使用:
![[assets/Pasted image 20260609114706.png]]

後續要執行這個查詢時，只要依照同樣的步驟就可以查詢其它的國家資料:
![[assets/Pasted image 20260609114818.png]]

如果一個 `prepared statement` 已經不需要了，可以使用下列的語法，從伺服器中刪除指定的 `prepared ststement`:
![[assets/Pasted image 20260609114958.png]]

下列的敘述執行以後會刪除名稱為 「my_country」 的 prepared statement:
![[assets/Pasted image 20260609120112.png]]

## Prepared Statements的參數

在建立 `prepared statement` 時，會依據敘述的需求設定參數標記，這些參數標記也決定執行 `prepared statement` 時，需要傳多少參數資料給它才可以正確的執行。以下列新增紀錄的敘述來說，它就使用了三個參數標記，依照順序為部門編號、名稱與地點:
![[assets/Pasted image 20260609120134.png]]

根據 `prepared statement` 使用的參數標記，在執行 `prepared statement` 時一定要傳送正確的參數資料，否則會產生錯誤訊息:
![[assets/Pasted image 20260609120306.png]]

下列的範例先把要新增部門的編號、名稱與地點資料設定為使用者變數，在執行 「new_dept」 時傳送給它使用:
![[assets/Pasted image 20260609120517.png]]

如果傳送的參數數量不對的話，就會產生錯誤訊息:
![[assets/Pasted image 20260609120613.png]]

如果傳送的使用者變數不存在的話，會自動使用 「NULL」 值代替。
![[assets/Pasted image 20260609120727.png]]

## 有效範圍

所有使用者變數與 `prepared statements` 都是某一個用戶端專屬的:
![[assets/Pasted image 20260609120739.png]]

如果用戶端離線以後，他所設定的使用者變數與 `prepared statement` 都會被清除:
![[assets/Pasted image 20260609120944.png]]

所以建立 `prepared statement` 時，不可以指定它是屬於哪一個資料庫，否則會有錯誤訊息:

```sql
PREPARE world.my_city FROM 'SELECT * FROM city'
```
