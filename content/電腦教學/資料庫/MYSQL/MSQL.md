
# Mac 上使用 MySQL 資料庫

  

## MySQL 資料庫使用與管理

  

- **關於資料庫**

  

  要使一個網站達到互動的效果，不是讓網頁充滿了動畫、音樂，而是當瀏覽者對網頁提出要求時能出現回應的結果。而這樣的效果，大多必須搭配資料庫的使用，讓網頁讀出儲存在資料庫中的資料，顯示在網頁上，也因為每個瀏覽者對於某一個相同的網頁所提出的要求不同，顯示出的結果即不同，這才是真正的互動網站。

  

- **認識資料庫**

  

  資料庫 (Database) 可以說是一些相關資料的集合並進行儲存的地方，我們可以一定的原則與方法新增、編輯、刪除資料的內容，進而搜尋、分析、比對所有資料，取得可用的資訊，產生所需的結果。例如：`Access`、`MySQL`、`SQL Server` 和 `Oracle`。

  

  ![認識資料庫](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-1.png)

  

- **資料表、記錄與欄位**

  

  關聯式資料庫是使用「資料表」（`Tables`）的二維表格儲存資料，每一個資料表使用「欄位」（`Fields`）分類成很多群組，每一個群組是一筆「記錄」（`Records`），例如：通訊錄資料表，如下表所示：

  

![資料表，記錄與欄位](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-2.png)

  

資料表可以使用「索引」（`Index`）將資料系統化的整理，以便在大量資料中快速找到所需的資料或進行排序。

  

例如：在通訊錄資料表使用編號欄位建立主索引鍵，或稱為「主鍵」（`Primary Key`），如此就可以透過編號來加速資料表記錄的搜尋和排序。

  

- **MySQL 資料庫的特色**

  

  早期的資料庫大都屬於操作在單機或是區域網路的系統，雖然在操作上方便，管理上也比較輕鬆，但是談到資料庫本身的效能或是安全性都是相當不利的弱點。

  

  隨著 `Internet` 的興起，開始興起 `Internet` 資料庫的概念，此時資料庫的角色已經化為一個在網際網路上提供資料存取編輯、應用查詢的伺服器了。`MySQL` 資料庫就是這個概念的一個具體表現，在與網站伺服器結合作業後，`MySQL` 資料庫就成為了一個網路型的資料庫系統。

  

- **資料庫的字元集與連線校對(使用命令提示字元介面下使用指令)**

  - 登入

    `mysql –uroot -p`

    (首先在指令模式用 `MySQL` 的 `root` 帳號連接到 `MySQL`)

  

  - 修改使用者密碼

  

    `mysqladmin -u root -p password`

  

    ```conf

    Enter password: ********

    New password: ********

    Confirm new password: ********

    ```

  

    ![mysql-3](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-3.png)

  

  - 忘記 `windows` 平台上的 `MySQL` 密碼

  

    1. 停止 `MySQL` 服務

       - 使用 `mysql` 命令啟動安全模式，跳過權限檢查

  

         ```php

         ```

  

       - 或使用 `nano /etc/my.cnf` 設定檔，來啟動安全模式，跳過權限檢查

  

         `nano /etc/my.cnf`

  

         ```cnf

         [mysqld]

           :

         skip-grant-tables

         ```

  

         >注意如果資料夾名稱不是預設 `c:\xampp`，需修改 `mysql/data/my.ini` 設定

  

    2. 關掉這個命令提示視窗，再開一個新視窗

       ![mysql-4](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-4.png)

  

    3. 執行以下命令

  

       ```sql

       cd C:\xampp\mysql\bin

       mysql

       mysql> use mysql;

       mysql> desc user;

       ```

  

       >查看當前系統用戶相關訊息，在 mysql 資料庫的 user 表中欄位:

  

       欄位名稱|描述

       ------|----

       Host|允許用戶登錄的 ip 位置， % 表示可以遠程

       User|當前資料庫的使用者名稱

       authentication_string|用戶密碼； 在 mysql 5.7.9 以後廢棄了 password 欄位和 password() 函數

       plugin|密碼加密方式

  

       `mysql> select host, user, authentication_string, plugin from mysql.user;`

  

       ![20231227091530](https://raw.githubusercontent.com/allen-5183/window_picture/main/images/20231227091530.png)

       如果當前 `root` 用户 `authentication_string` 欄位下有内容，先將其設置為空；

  

       ```mysql

       mysql> FLUSH PRIVILEGES;

       mysql> ALTER USER root@localhost IDENTIFIED VIA mysql_native_password USING PASSWORD('');

       mysql> ALTER USER root@127.0.0.1 IDENTIFIED VIA mysql_native_password USING PASSWORD('');

       mysql> FLUSH PRIVILEGES;

       mysql> select host, user, authentication_string, plugin from mysql.user;

       ```

  

       ![20231227111521](https://raw.githubusercontent.com/allen-5183/window_picture/main/images/20231227111521.png)

  

       退出 `mysql`

  

       ```mysql

       mysql> quit;

       ```

  

       註解掉 `c:/xampp/mysql/bin/my.ini` 文件的  `skip-grant-tables` 後，重新啟動 `xampp` 的 `mysql`。

  

       登入 `mysql` 使用 `root` 帳號，密碼不需要，進入 `mysql>` 後，重新設定新密碼，如下:

  

       ```mysql

       flush privileges;

       SET PASSWORD FOR root@localhost = PASSWORD("1qaz@wsx");

       flush privileges;

       ```

  

  - 顯示資料庫

  

    ```sql

    mysql –u root -p1qaz@wsx

    mysql> show databases;

    ```

  

    ![顯示資料庫](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-5.png)

  

  - 查詢：

  

    ```sql

    SELECT * FROM `class`.`students`;

    ```

  

    ![查詢](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-6-1.png)

  

- **資料庫的字元集與連線校對(使用 `phpMyAdmin` 管理程式)**

- **登入 `phpMyAdmin` 的管理畫面**

  

  輸入:

  `http://127.0.0.1/phpmyadmin/index.php`

   ![登入 phpMyAdmin 的管理畫面](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-7.png)

  

- `MySQL` 資料庫的字元集與連線校對

  

  `MySQL` 資料庫在 `4.1` 版本後支援 `utf8` 字元編碼來儲存，如此即可解決資料在不同語系文字上儲存與顯示上的問題。所以在 `MySQL` 中讀取或是寫入資料時能指定正確的字元集與連線校對，是維持資料內容正確的重要課題。

  

  **認識字元集與連線校對**：

  字元集 (character set) 是指資料庫中資料文字的編碼方式，而連線校對 (collation) 是資料中字元的排序方式。

  

  **中文衝碼問題：**

  在中文的環境中，我們可以選取 `big5` 繁體中文與 `utf8` 的編碼方式做為操作 `MySQL` 資料庫的字元集。

  

  **建議中文使用的字元集與連線校對：*

  

  在 `MySQL` 資料庫最完美的解決方式還是選擇使用 `utf8` 的方式來進行文字編碼，如此即可將中文字以 `Unicode` 的方式進行儲存，徹底解決衝碼問題。

  

  **MySQL 使用的字元集與連線校對：**

  

  `MySQL` 由資料庫、資料表、資料欄位各個層級中，都可以單獨設定採用的字體集與連線校對方式。若在某一層操作時沒有設定使用字體集與連線校對方式為何，就會繼承上一層的設定來使用，若都沒有設定就會以 `MySQL` 資料庫的預設值來做使用標準。

  

- `mysql` 裡 `utf8_general_ci` 跟 `utf8_unicode_ci` 連線校對的差異

  

  `mysql` 要在兩個 `codepage` 裡面找出來相對應的字元位置在哪裡。對 `utf8_general_ci` 來說，來源 `codepage` 裡面的一個字元只能對應到目標 `codepage` 裡面的一個字元，而 `utf8_unicode_ci` 則可以把來源 `codepage` 裡的一個字元對應到目標 `codepage` 裡的多個字元（或反過來）。

  

  例如德文裡的 `ß` 要轉換成英文的時候如果是用 `utf8_unicode_ci` 轉換會變成正確的 `ss` ，但是如果用 `utf8_general_ci` 的話則會變成單一的 `s` 而已。所以如果可以的話請盡量用 `utf8_unicode_ci` 而不要用 `utf8_general_ci` ，雖然對 `multibyte` 字元來說這兩個都沒差，但是 `utf8` 的網頁誰也不知道哪天會不會有這種字元出現在你的網頁上，所以如果設成 `utf8_unicode_ci` 你就不需要擔心貼上去之後資料在轉換間遺失了。

  

- **新增資料庫**

  

  回到 `phpMyAdmin`，我們將要在 `MySQL` 中建置一個學校班級的資料庫：「class」，並新增一個同學通訊錄資料表：「students」。

  

  ![新增資料庫](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-8.png)

  

  **認識資料表的欄位：**

  

  在資料表新增前，首要的動作是要先規劃資料表中所要使用的欄位。其中設定資料欄位的類型非常重要，使用正確的資料型態才能正確的儲存、應用資料。

  

  **數值型態：**

  可運用來儲存、計算的數值資料欄位，例如會員的編號或是產品的價格等。在 `MySQL` 中的數值欄位依照所儲存的資料所需空間大小有以下的區別：

  

  ![數值型態](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-9.png)

  

  **文字型態：**

  可用來儲存文字類型的資料，如學生姓名、地址等。在 `MySQL` 中文字型態資料有下列幾種格式：

  ![mysql-10](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-10.png)

  

  **日期及時間型態：**

  可用來儲存日期或是時間類型的資料，例如會員的生日、留言的時間等。`MySQL` 中的日期及時間型態有下列幾種格式：

  

  ![日期及時間型態](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-11.png)

  

  ![時間戳記](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-12.png)

  

  **特殊資料型態：**

  還有二個特殊的資料型態，嚴格來說它們都屬於文字型態，但是因為它們的內容只能由固定的選項內挑選，又有人稱它們為「列舉資料型態」，內容如下：

  

  ![特殊資料型態](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-13.png)

  

  **重要的欄位屬性：**

  在建置資料表時，除了要依不同性質的資料選擇適合的欄位型態，有些重要的欄位屬性定義也能在不同的型態欄位中發揮其功能，常用的設定如下：

  

  ![重要的欄位屬性](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-14.png)

  

- 新增資料表

  

  **欄位規劃：**

  以下我們要新增一個同學個人資料表：「students」，以下是這個資料表欄位的規劃：

  

  ![欄位規劃](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-15.png)

  

  **實作如下：**

  ![實作如下](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-16.png)

  

  ![實作如下](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-16-1.png)

  

  ![mysql-18](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-18.png)

  

- 資料新增、資料的新增、瀏覽、編輯與刪除

  ![mysql-19](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-19.png)

  

  ![mysql-20](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-20.png)

  

  ![mysql-21](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-21.png)

  

  ![mysql-22](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-22.png)

  

  **指令輸入：**

  ![mysql-23](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-23.png)

  

  **資料瀏覽：**

  ![mysql-24](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-24.png)

  

  **資料的編輯：**

  ![mysql-25](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-25.png)

  

  **資料的刪除：**

  ![mysql-26](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-26.png)

  

  **新增欄位：**

  ![mysql-27](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-27.png)

  

- 資料庫的備份與還原

  

  在 `MySQL` 資料庫裡備份資料，是十分簡單又輕鬆的事情。在本節中我們將說明如何使用 `phpMyAdmin` 備份 `MySQL` 的資料表，以及資料表匯入還原的動作。

  

  我們可以使用 `phpMyAdmin` 的管理程式選取資料庫中的所有資料表，匯出成一個單獨的文字檔。當資料庫受到損壞或是要將資料搬移到新的 `MySQL` 資料庫時，只要將這個文字檔匯入即可完成。

  

  **資料庫備份：**

  ![mysql-28](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-28.png)

  

  ![mysql-29](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-29.png)

  

  ![mysql-30](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-30.png)

  

  再按「執行」

  

  **資料庫還原：**

  ![mysql-31](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-31.png)

  

  ![mysql-32](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-32.png)

  

  再按「執行」

  ![mysql-33](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-33.png)

  

- **MySQL 資料庫的安全設定**

  

  `MySQL` 資料庫管理系統不同於一般檔案型的資料庫，放置在網路上雖然不會直接被下載，但是只要針對 `MySQL` 服務端口進行攻擊，還是有安全上的顧慮。以下將深入討論 `MySQL` 資料庫在安全性上的設定。

  

  **對於 `MySQL` 資料庫的安全問題：**

  `MySQL` 資料庫是一個存在於網際網路上的資料庫系統，換句話說只要是網際網路上的使用者都可以連接到這個資源，如果沒有權限或其他措施的控管，任何人都可以對 `MySQL` 資料庫予取予求，為所欲為。

  

  **對於 `phpMyAdmin` 資料庫的安全考量：**

  `phpMyAdmin` 是一套網頁介面的 `MySQL` 管理程式，有許多 `PHP` 的程式設計師都會將這套工具直接上傳到他的 `PHP` 網站資料夾裡，那麼管理者只要從遠端透過瀏覽器登入 `phpMyAdmin` 來管理的資料庫了！

  

  **防堵安全漏洞的好建議：**

  無論是 `MySQL` 資料庫本身的權限設定或是 `phpMyAdmin` 管理程式的安全漏洞，為了避免他人透過網路入侵您的資料庫，有幾件事必須要先做的：

  

  1. 修改 `phpMyAdmin` 管理程式的資料夾名稱。最好是修改成一個不容易猜，與管理或是 `MySQL`、`phpMyAdmin 等關鍵字。

  2. 為 `MySQL` 資料庫的管理帳號加上密碼

  3. 養成備份 `MySQL` 資料庫的習慣

  

- **MySQL 的帳號管理**

  

   在 `MySQL` 資料庫中的管理者帳號為：「root」，現在我們就使用 `phpMyAdmin` 來檢視這個帳號的設定。

  

  **檢視帳號設定：**

  ![mysql-34](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-34.png)

  

  **修改帳號的權限：**

  

  每個帳號可以設定對於資料編輯、結構調整，甚至是系統管理的權限。請依照下述步驟檢視目前帳號的權限：

  

  ![mysql-35](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-35.png)

  

  **建立或修改密碼：**

  

  若您的帳號沒有使用密碼或是要修改原來的密碼，請在該頁繼續往下捲動並進行下述步驟：

  ![mysql-36](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-36.png)

  

- 設定 `phpMyAdmin` 的登入方式

  

  `phpMyAdmin` 是許多人在管理、操作 `MySQL` 資料庫最常使用的工具。因為 `phpMyAdmin` 是以網頁的方式存在，無論是管理者或是一般使用者都可以藉由瀏覽器開啟，登入機制的啟用便是防堵沒有帳號權限的人入侵資料庫的最後一道關卡。`phpMyAdmin` 有三種登入認證模式：`config`、`cookie` 及 `http`，以下將說明這三種認證模式的差異與設定方法。

  

  1. `config` 登入認證模式：

  

     若是您的程式是處於本機開發階段，並沒有安全性上的考量，不希望每次使用 `phpMyAdmin` 來管理操作 `MySQL` 資料庫時都要一再輸入帳號、密碼，造成開發時的困擾，您可以將資料庫的帳號、密碼直接寫到 `phpMyAdmin` 的設定檔 `<config.inc.php>` 中，如此在進入 `phpMyAdmin` 時就會直接跳過登入步驟進入管理畫面中。

  

     a. 將 `root` 加入密碼：1234

        ![mysql-37](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-37.png)

  

     b. 開啟「c:\xampp\phpMyAdmin\config.inc.php」

        ![mysql-38](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-38.png)

  

        ![mysql-39](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-39.png)

  

     c. 即可跳過登入步驟進入管理畫面

  

  2. `http` 登入認證模式：

  

     若是您的網站伺服器是使用 `httpd` 的方式來編譯 `PHP` 的程式頁面，即可使用 `http` 登入認證模式，如 `Apache` 伺服器。但若是使用 `CGI` 的方式來使用 `PHP` 程式頁面就不能使用，例如 `IIS` 伺服器。

  

     a. 開啟「c:\xampp\phpMyAdmin\config.inc.php」

        ![mysql-40](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-40.png)

  

     b. 即會顯示對話方塊要求輸入帳號、密碼

        ![mysql-41](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-41.png)

  

  3. `cookie` 登入認證模式：

  

     這是一種在設定上限制最少，使用上也很方便的認證模式。只要是使用者的瀏覽器允許 `cookie` 的使用，即可使用 `cookie` 登入認證模式。

  

     ![mysql-42](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-42.png)

  

     ![mysql-43](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-43.png)

  

---

  

## `SQL` 語法

  

- 結構化查詢語言：SQL

  `SQL` 全名是結構化查詢語言 (Structured Query Language)，是用於資料庫中的標準數據查詢語言。`SQL` 是目前關聯式資料庫系統所使用查詢語法的標準，使用者可以應用 `SQL` 語法對資料庫系統進行資料的存取、編輯、刪除及管理…等動作。`SQL` 語法的內容是利用簡單的英文語句所構成，使用上十分的白話。

  </br>

- 定義資料庫物件語法

  `SQL` 語法在應用上對於 `DDL (Data Definition Language)`：定義資料庫物件使用的語法是很基礎而重要的，其中重要的功能關鍵字有：

  **CREATE**：建立資料庫的物件。

  **ALTER**：變更資料庫的物件。

  **DROP**：刪除資料庫的物件。

  </br>

- 建立資料庫

  `CREATE` 是 `SQL` 指中建立資料庫或資料表的關鍵字，新增資料庫的語法如下：

  

  ```sql

  CREATE DATABASE [IF NOT EXISTS] 資料庫名稱

  [DEFAULT] CHARACTER SET [=] 字元集

  [DEFAULT] COLLATE [=] 連線校對

  ```

  

  ```sql

  CREATE DATABASE mydatabase

  SET CHARACTER SET utf8mb4;

  COLLATE utf8mb4_unicode_ci;

  ```

  

- 建立資料表

  新增資料表的動作更為頻繁而重要，其語法如下：

  

  ```sql

  #變更目前連線的字元集

  SET NAMES utf8mb4;

  CREATE TABLE [IF NOT EXISTS] 資料表名稱

  (欄位名稱 資料型別 [資料屬性]

   [,欄位名稱 資料型別 [資料屬性]]...);

  ```

  

  ```sql

  CREATE TABLE `students` (

    `cID` tinyint(2) UNSIGNED ZEROFILL NOT   NULL,

    `cName` varchar(20) NOT NULL,

    `cSex` enum('F','M') NOT NULL DEFAULT   'F',

    `cBirthday` date NOT NULL,

    `cEmail` varchar(100) DEFAULT NULL,

    `cPhone` varchar(50) DEFAULT NULL,

    `cAddr` varchar(255) DEFAULT NULL

  ) ENGINE=InnoDB DEFAULT CHARSET=utf8   COLLATE=utf8_unicode_ci;

  ```

  

  資料庫或是資料表在新增後，可以使用 `ALTER` 指令語法進行修改。

  

- 修改資料庫

  `ALTER DATABASE` 指令可以修改存在的資料庫結構，基本語法如下：

  

  ```sql

  ALTER DATABASE 資料庫名稱

  [DEFAULT] CHARACTER SET [=] 字元集

  [DEFAULT] COLLATE [=] 連線校對

  ```

  

- 修改資料表欄位

  `ALTER TABLE` 指令可以修改存在的資料表結構，基本語法如下：

  

  ```sql

  ALTER TABLE 資料表名稱

  (欄位名稱 資料型別 [資料屬性]

  CHANGE 原欄位名稱 新欄位名稱 資料型別 [資料屬性]

  [,原欄位名稱 新欄位名稱 資料類別 [資料屬性]]...);

  ```

  

- 新增資料表欄位

  `ALTER TABLE` 指令可以在已存在的資料表中新增資料表欄位，其語法如下：

  

  ```sql

  ALTER TABLE 資料表名稱

  ADD 欄位名稱 資料型別 [資料屬性]

  [,ADD 欄位名稱 資料型別 [資料屬性]]..)

  [FIRST | AFTER 欄位名稱];

  ```

  

  ```sql

  alter table students add cWeight tinyint(3) NOT NULL

  ```

  

- 刪除資料表欄位

  `ALTER TABLE` 指令可以在已存在的資料表中刪除資料表欄位，其語法如下：

  

  ```sql

  ALTER TABLE 資料表名稱

  DROP 欄位名稱;

  ```

  

  ```sql

  truncate table students;

  alter table students drop cHeight;

  ```

  

  >一次只能刪除一個欄位

  

- `DROP`：刪除資料庫及資料表內容

  

  資料庫或是資料表在新增後，可以使用 DROP 指令語法進行修改。

  刪除資料庫與資料表的語法相似，刪除資料庫的語法如下：

  

  ```sql

  DROP DATABASE [IF EXISTS] 資料庫名稱;

  ```

  

  這個刪除資料庫的動作會連同儲存在資料庫中的所有物件，如資料表都一同刪除。刪除資料表的語法如下：

  

  ```sql

  DROP TABLE [IF EXISTS] 資料表名稱;

  ```

  

- **查詢資料庫資料的內容**

  

  `SQL` 語法在應用上對於 `DML(Data Manipulation Language)`：查詢維護資料庫資料內容的語法在使用上是更重要的，無論是查詢資料庫或顯示資料庫的內容，更新或刪除資料庫中的資料，都必須依靠這些指令。其中重要的功能關鍵字有：

  

  1. **SELECT**：查詢選取資料庫中的資料。

  2. **INSERT**：新增資料到資料表中。

  3. **UPDATE**：更改資料表中的資料。

  4. **DELETE**：刪除資料表中的資料。

  

- **SELECT：查詢資料**

  資料的查詢應是資料庫系統最重要的工作了，所以 `SELECT` 可能是 `SQL` 語法中最重要的指令，因為所有查詢資料的動作都必須由這個指令開始。

  

  **SELECT 基本語法：**

  `SELECT` 指令應用於使用者要向資料庫系統查詢資料的時候，其基本的語法格式如下：

  ![mysql-52](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-52.png)

  

  **選取所有的欄位：**

  Ex:

  

  ```SQL

  SELECT * FROM `students`;

  ```

  

  ![mysql-53](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-53.png)

  

  **指定資料表選取欄位：**

  

  基本格式如下：

  

  `SELECT 資料表名稱.欄位名稱　FROM 資料表名稱；`

  

  Ex:

  

  ```sql

  SELECT `students`.`cName` FROM `students`;

  ```

  

  ![mysql-53](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-53-1.png)

  

  **AS:設定選取欄位別名：**

  在選取要顯示的欄位時，可能因為該欄位名稱不易判讀或是套用函式而不易顯示，可使用AS設定顯示時使用的別名，。

  

  其基本的語法格式如下：

  `SELECT 欄位名稱 AS 欄位別名 FROM 資料表名稱；`

  

  Ex:

  

  ```sql

  SELECT `cID` AS `座號`, `cName` AS `姓名` FROM `students`;

  ```

  

  ![mysql-54](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-54.png)

  

  **SELECT DISTINCT:去除重複資料顯示一筆：**

  如果需要知道某個資料表欄位內有哪些不同的值，而每個值出現的次數並不重要時，可以使用SELECT DISTINCT的方式去達成，其基本的語法格式如下：

  

  `SELECT DISTINCT 欄位名稱　FROM 資料表名稱；`

  

  Ex:想知道全班有幾種性別

  

  ```sql

  SELECT DISTINCT `cSex` FROM `students`;

  ```

  

  ![mysql-55](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-55.png)

  

- WHERE：設定篩選條件

  在查詢資料時，並不是每一次都要顯示所有的內容。我們可能會為顯示的資料設定一些條件，來篩選顯示的內容，這就是 `WHERE` 指令的功能。

  

  **WHERE 基本語法：**

  

  WHERE 的基本語法格式為：

  ![mysql-56](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-56.png)

  

  Ex:想要由 `students` 資料表中挑出所有男性的資料

  

  ```sql

  SELECT * FROM `students` WHERE `cSex`='M';

  ```

  

  ![mysql-57](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-57.png)

  

  **比較運算子：**

  

  | =   | !=  | <>  | <       |

  | :-- | :-- | :-- | :------ |

  | >   | <=  | >=  | IS NULL |

  

  **AND、OR、NOT：連接多個條件式：**

  

  Ex: 想要由 `students` 資料表中找出座號大於5的男生

  

  ```sql

  SELECT * FROM `students` WHERE `cID`>5 AND `cSex`='M';

  ```

  

  ![mysql-58](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-58.png)

  

  Ex: 想要由 `students` 資料表中找出座號不大於5的男生

  

  ```sql

  SELECT * FROM `students` WHERE NOT `cID`>5 AND `cSex`='M';

  ```

  

  ![mysql-59](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-59.png)

  

  Ex: 想要由 `students` 資料表中找出座號大於5的男生以外的資料

  

  ```sql

  SELECT * FROM `students` WHERE NOT (`cID`>5 AND `cSex`='M');

  ```

  

  ![mysql-60](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-60.png)

  

- BETWEEN … AND：設定篩選範圍

  

  BETWEEN … AND 基本語法

  BETWEEN … AND設定篩選範圍是加在 WHERE 之後，它的基本語法格式為：

  

  ![mysql-61](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-61.png)

  

  **設定數值篩選範圍：**

  

  EX: 由 `students` 資料表中找出座號大於(含)4且小於(含)6的學生資料

  

  ```sql

  SELECT * FROM `students` WHERE `cID` BETWEEN 4 AND 6;

  ```

  

  ![mysql-62](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-62.png)

  

  也可使用：

  

  ```sql

  SELECT * FROM `students` WHERE `cID`>=4 AND `Cid`<=6;

  ```

  

  **設定日期時間範圍：**

  

  Ex: 想要尋找日期在 1987~1988 之間的學生資料

  

  ```sql

  SELECT * FROM `students` WHERE `cBirthday` BETWEEN '1987-01-01' AND '1988-12-31';

  ```

  

  ![mysql-63](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-63.png)

  

- IN：指定多個篩選值

  

  IN 指定多個篩選值是加在 WHERE 之後，它的基本語法格式為：

  

  ![mysql-64](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-64.png)

  

  若是設定篩選值時，若想要直接由某個欄位指定幾個值來顯示可以使用 IN 進行值的指定。指定的值必須放置在「( )」左右括號中，每個值之間以「,」逗號區隔。

  

  Ex:想要由 `students` 資料表中找出座號為 1,3,5,7,9的學生資料：

  

  ```sql

  SELECT * FROM `students` WHERE `cID` =1 OR `cID` =3 OR  `cID` =5 OR  `cID` =7 OR `cID` =9;

  SELECT * FROM `students` WHERE `students`.`cID` IN (1,3,5,7,9)

  ```

  

  ![mysql-65](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-65.png)

  

- LIKE：設定字串比對的篩選值

  

  **萬用字元的使用：**

  

  在文字資料中常要找以某些文字開頭、某些文字結尾，或是字串中包含哪些文字的內容，此時即可以使用 LIKE 運算子，並搭配以下萬用字元來進行查詢：

  

  ![mysql-66](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-66.png)

  

  Ex: 想要由 `students` 資料表中，出電話號碼是「0918」開頭的學生資料

  

  ```sql

  SELECT * FROM `students` WHERE `students`.`cPhone` LIKE '0918%';

  ```

  

  ![mysql-67](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-67.png)

  

  Ex: 想要由 `students` 資料表中，找出學生的名字中有「林」這個字的學生資料。

  

  ```sql

  SELECT * FROM `students` WHERE `students`.`cName` LIKE '%林%'

  ```

  

  ![mysql-68](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-68.png)

  

- ORDER BY：設定查詢結果的排序

  

  `ORDER BY` 的功能是用來設定欄位，進行排序查詢結果，它的基本語法如下：

  ![mysql-69](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-69.png)

  

  **其中排序方式有二種：**

  

  1. **ASC**：遞增排序，由小排到大，也是未指定時預設的排序方法。

  2. **DESC**：遞減排序，由大排到小。

  

  Ex: 想要由 `students` 資料表所有同學的資料依生日遞減排序

  

  ```sql

  SELECT * FROM `students` ORDER BY `students`.`cBirthday` DESC;

  ```

  

  ![mysql-70](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-70.png)

  

  Ex: 想要由 `students` 資料表所有同學的資料依性別遞增排序，再依生日遞減排序

  

  ```sql

  SELECT * FROM `students` ORDER BY `students`.`cSex` ASC, `students`.`cBirthday` DESC;

  ```

  

  ![mysql-71](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-71.png)

  

- LIMIT：設定查詢顯示的筆數

  

  `LIMIT` 可以設定查詢後由哪一筆開始顯示，並顯示多少筆數，它的基本語法如下：

  ![mysql-72](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-72.png)

  

  `LIMIT` 是由查詢後的結果再進行擷取資料的動作，如果與 `ORDER BY` 進行排序搭配可以輕易取得最前的 10 筆資料或是最後的 10 筆資料的結果。也因為如此，`LIMIT` 在使用時必須放置在 `ORDER BY` 之後。

  

  ```sql

  SELECT * FROM `students` ORDER BY `students`.`cSex` ASC, `students`.`cBirthday` DESC LIMIT 5;

   SELECT * FROM `students` WHERE 1 LIMIT 5,5;

  ```

  

## MySQL 常用函式

  

- `MySQL` 資料庫系統本身提供了許多函式可供使用者搜尋資料時進行相關的處理，以下將分成幾個較常使用的函式類別加以介紹。

  

- 算術運算子與數學函式 面對數值資料欄位，可以使用算術運算子及數學函式對於欄位的值進行處理成為 查詢結果。為了以下的範例說明，我們將要在「students」資料表新增二個欄位：

「身高」、「體重」，其格式內容如下：

  

- ![mysql-76](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-76.png)

  

- 新增結果如下：

  ![mysql-77](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-77.png)

  

  Ex:計算每個學生的標準體重，其公式為 `(身高-70)x0.6`，並顯示一欄計算目前體重 與標準體重的差距。

  

  ```sql

  SELECT `cID` AS `座號`, `cName` AS `姓名`, `cHeight` AS `身高`, `cWeight` AS `體重`, (`cHeight` - 70) * 0.6 AS `標準體重`, (`cWeight` - (`cHeight` - 70)*0.6) AS `差距`

  FROM `students`

  ```

  

  ```sql

  SELECT `S`.`cID` AS `座號`, `S`.`cName` AS `姓名`, `S`.`cHeight` AS `身高`, `S`.`cWeight` AS `體重`, (`S`.`cHeight` - 70) * 0.6 AS `標準體重`, (`S`.`cWeight` - (`S`.`cHeight` - 70)*0.6) AS `差距`

  FROM `students` AS S;

  ```

  

  ![mysql-78](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-78.png)

  

  **數學函數：**

  

  |函數名稱(參數列) |

  | :---------------- |

  | ABS(數值)            |

  | POW(基數, 次方數)    |

  | SQRT(數值)           |

  | PI()                 |

  | ROUND(數值,小數位數) |

  

  Ex1: 每個學生的 `BMI` 值，其公式為:體重除以身高的平方(BMI=kg/$m^{2}$)

  

  ![mysql-79](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-79.png)

  

  ```sql

  SELECT cID as `座號`, cName as `姓名`, cHeight as `身高`, cWeight as `體重`,   round ( ( cWeight / pow(cHeight /100, 2) )  ,2) as `BMI值` FROM `students` WHERE 1

  ```

  

  EX2: 延續上一題, 找出前三名 `BMI` 最大值的同學。

  

  ```sql

  SELECT `cID` AS `座號`, `cName` AS `姓名`, `cHeight` AS `身高`, `cWeight` AS `體重`, ROUND((`cWeight` / POW((`cHeight` / 100),2)),2) AS `BMI值` FROM `students` ORDER BY `BMI值` DESC LIMIT 3;

  ```

  

  ![20230830142518](https://raw.githubusercontent.com/allen-5183/window_picture/main/images/20230830142518.png)

  

  EX3: 找出不符合 `BMI` 標準的同學(18.5<= BMI值 <24)

  

  ![20230830143111](https://raw.githubusercontent.com/allen-5183/window_picture/main/images/20230830143111.png)

  

  ```sql

  SELECT `cID` AS `座號`, `cName` AS `姓名`,   `cHeight` AS `身高`, `cWeight` AS `體重`,   ROUND((`cWeight` / POW((`cHeight` / 100),2)),  2) AS `BMI值`

  FROM `students`

  WHERE NOT ( ROUND((`cWeight` / POW  ((`cHeight` / 100),2)),2) >=18.5 AND ROUND  ((`cWeight` / POW((`cHeight` / 100),2)),2) <   24)

  ORDER BY `BMI值` DESC    ;

  ```

  

  ```sql

  SELECT `cID` AS `座號`, `cName` AS `姓名`, `cHeight` AS `身高`, `cWeight` AS `體重`, ROUND((`cWeight` / POW((`cHeight` / 100),2)),2) AS `BMI值`

  FROM `students`

  WHERE ( ROUND((`cWeight` / POW((`cHeight` / 100),2)),2) <18.5 OR ROUND((`cWeight` / POW((`cHeight` / 100),2)),2) >= 24)

  ORDER BY `BMI值` DESC ;

  ```

  

  EX4: 找出不符合 `BMI` 標準的同學(18.5 <= BMI值 <24),使用兩層搜尋

  

  ![20230830143206](https://raw.githubusercontent.com/allen-5183/window_picture/main/images/20230830143206.png)

  

  ```sql

  SELECT * FROM (SELECT `cID` AS `座號`, `cName` AS `姓名`, `cHeight` AS `身高`, `cWeight` AS `體重`, ROUND((`cWeight` / POW((`cHeight` / 100),2)),2) AS `BMI值` FROM `students`) AS T

  WHERE T.`BMI值` < 18.5 OR T.`BMI值` >=24 ORDER BY T.`BMI值`DESC

  ```

  

  **日期時間函式**

  `MySQL` 可以使用日期時間函式處理資欄位或是語法中相關的部份，常用的函式，如下:

  ![mysql-80](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-80.png)

  

  Ex: 篩選出生日日期在星期二的同學：

     （利用 DAYNAME()函數得到「cBirthday」欄位的星期名）

  

  ```sql

  SELECT * FROM `students` WHERE DAYNAME(`cBirthday`) = 'Tuesday';

  ```

  

  ![mysql-81](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-81.png)

  

  Ex:篩選大於 20 歲的同學

  

  ```sql

  SELECT * FROM `students` WHERE YEAR(NOW()) - YEAR(`cBirthday`) > 20;

  ```

  

  ![mysql-82](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-82.png)

  

  **統計函式**

  `MySQL` 的 `SQL` 語法還提供許多統計函式，可以總計出一些資料表中的彙整資料。為了以下的範例說明，我們要在「class」資料庫中再加入一個儲存成績的資料表：「scorelist」，以下是這個資料表欄位的規劃：

  ![mysql-83](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-83.png)

  

  - `SUM()`:合計值

    EX1: 想要算出全班國文、英文及數學總分

  

    ```sql

    SELECT SUM(`score`) FROM `scorelist` WHERE 1;

    ```

  

    ![全班國文、英文及數學總分](https://raw.githubusercontent.com/allen-5183/mac/main/images/sum-2.png)

  

    EX2: 想要算出全班國文總分

  

    ```sql

    SELECT SUM(`score`) FROM `scorelist` WHERE `course`='國文';

    ```

  

    ![全班國文總分](https://raw.githubusercontent.com/allen-5183/mac/main/images/sum-1.png)

  

  - `AVG()`:平均值

  

    EX: 想要算出全班國文的平均分數

  

    ```sql

    SELECT AVG(`score`) FROM `scorelist` WHERE `course`='國文';

    ```

  

    ![全班國文的平均分數](https://raw.githubusercontent.com/allen-5183/mac/main/images/avg-1.png)

  

  - `COUNT()`:計次

  

    EX: 由 `students` 資料表統計全班人數

  

    ```sql

    SELECT COUNT(`students`.`cID`) FROM `students` WHERE 1;

    ```

  

    ![全班國文的平均分數](https://raw.githubusercontent.com/allen-5183/mac/main/images/count-1.png)

  

  - `MAX()`、`MIN()`:最大值、最小值

  

    EX1: 找出全班國文最高分

  

    ```sql

    SELECT MAX(`scorelist`.`score`) FROM `scorelist` WHERE `course`='國文';

    ```

  

    EX2: 找出全班數學最低分

  

    ```sql

    SELECT MIN(`scorelist`.`score`) FROM `scorelist` WHERE `course`='數學';

    ```

  

  **GROUP BY:分組排列**

    EX: 想要顯示每個學生的總分

  

    ```sql

    SELECT `cID`, SUM(`score`) FROM `scorelist` GROUP BY `cID`;

    ```

  

    ![20230830145807](https://raw.githubusercontent.com/allen-5183/window_picture/main/images/20230830145807.png)

  

  **HAVING:GROUP BY**的條件式

    若希望對 `GROUP BY` 的敘述加上條件式的限制，就不能使用 WHERE的方法，而是用 HAVING

  

    EX: 想要顯示座號1到5號同學的分數總計

  

    ```sql

    SELECT `cID`, SUM(`score`) FROM `scorelist` GROUP BY `cID` HAVING `cID` <=5;

    ```

  

    ![20230830145839](https://raw.githubusercontent.com/allen-5183/window_picture/main/images/20230830145839.png)

  

- **新增、更新、刪除**

  

  查詢雖然是資料庫中重要的功能，但是新增、更新與刪除資料的動作，才是維護資料庫內容的主要核心功能，以下將說明 SQL 語法中新增、更新與刪除資料的指令與語法。

  

- INSERT:新增資料

  可以使用 `INSERT` 語法為資料表新增資料，其基本語法如下：

  ![mysql-73](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-73.png)

  

  EX: 新增繼續新增 3 位同學進入 `students` 資料表，

  

  | 座號 | 姓名  | 性別 | 生日       | 電子郵件     | 電話       | 地址 | 身高 | 體重 |

  | :--- | :---- | :--- | :--------- | :----------- | :--------- | :--- | :--- | :--- |

  |      | Bill1 | 男   | 1988-02-10 | Bill1@bb.com | 0925932221 | 台北 | 176  | 89   |

  |      | Bill2 | 男   | 1988-02-10 | Bill2@bb.com | 0925932222 | 新竹 | 170  | 81   |

  |      | Bill3 | 男   | 1988-02-10 | Bill3@bb.com | 0925932223 | 桃園 | 172  | 84   |

  

  **新增一筆資料:**

  

  ```sql

  INSERT INTO `students` (`cName`,`cSex`,`cBirthday`,`cEmail`,`cPhone`,`cAddr`,`cHeight`,`cWeight`) VALUES('Bill1','M','1988-02-10','Bill1@bb.com','0925932221','台北','176','89')

  ```

  

  **新增多筆資料(以「,」加以區隔):**

  

  ```sql

  INSERT INTO `students` (`cName`,`cSex`,`cBirthday`,`cEmail`,`cPhone`,`cAddr`,`cHeight`,`cWeight`) VALUES ('Bill2','M','1988-02-10','Bill2@bb.com','0925932223','台北','170','81'),('Bill3','M','1988-02-10','Bill3@bb.com','0925932223','台北','172','84')

  ```

  

- `UPDATE`:更新資料

  

  可以使用 `UPDATE` 語法為資料表更新資料，其基本語法如下：

  

  ```sql

  UPDATE 資料表名稱

  SET 欄位名稱1 = 值1, 欄位名稱2= 值2,....

  WHERE 條件式

  ```

  

  `UPDATE` 更新資料的動作可以一次更動多筆資料的內容，所以 `WHERE` 後加上的條件式十分重要，只要符合條件的資料內容即會進行更新的動作，要特別注意。

  

  EX: 要修改座號為 11 同學的身高體重

  

  ```sql

  UPDATE `students` SET `cHeight`=174, `cWeight`=92 WHERE `cID`=11

  ```

  

- `DELETE`:刪除資料

  

  可以使用 `DELETE` 語法為資料表刪除資料，其基本語法如下：

  

  ```sql

  DELETE FROM 資料表名稱

  WHERE 條件式

  ```

  

  `DELETE` 刪除資料的動作可以一次刪除多筆資料的內容，所以 `WHERE` 後加上的條件式十分重要，只要符合條件的資料內容即會進行刪除的動作，要特別注意。

  

  EX: 刪除座號大於(等於) 11 的同學的資料

  

  ```sql

  DELETE FROM `students` WHERE `cID`>=11;

  ```

  

- 多資料表關聯查詢

  

  除了在一個資料表中選取欄位進行查詢，我們也可以在多個資料表中之中選取不 同的欄位，進行查詢的動作。這樣的查詢方式是必頇有前提的，那就是資料表之 間要有一欄可以指定相關或是建立關聯。

  

  **結合資料表的查詢**

  結合資料表的基本語法,若要結合二個資料表的基本語法如下:

  

  ```sql

  SELECT 顯示欄位,...

  FROM 資料表A, 資料表B

  WHERE 資料表A.相關欄位 = 資料表B.相關欄位

  ```

  

  ![mysql-87](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-87.png)

  

  ![mysql-88](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-88.png)

  

  下面兩張資料表，在 `class` 資料庫中 `students` 資料表與 `scorelist` 資料表，分別記錄著學生的個人資料及成績。在這兩個資料表中可以使用 `cID` 欄位結合並進行查詢。

  

  EX: 顯示出學生座號、姓名及其國文成績的查詢

  

  ```sql

  SELECT `students`.`cID`, `students`.`cName`,`scorelist`.`course`, `scorelist`.`score` FROM `students`, `scorelist`WHERE `students`.`cID` = `scorelist`.`cID` and `scorelist`.`course` = '國文'

  ```

  

  ![mysql-89](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-89.png)

  

  Ex: 想要顯示同學的座號、姓名、總分及總平均的查詢，並顯示總分由大至小的順位

  

  ```sql

  SELECT `students`.`cID` AS `座號`, `students`.`cName` as `姓名`, SUM(`scorelist`.`score`) as `總分`, AVG(`scorelist`.`score`) as `總平均` FROM `students`, `scorelist` WHERE `students`.`cID` = `scorelist`.`cID` GROUP BY `students`.`cID` ORDER BY `總分` DESC;

  ```

  

  ![mysql-90](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-90.png)

  

- 使用 `JOIN` 結合資料表

  **JOIN  的基本語法**

  若要 `JOIN` 語法結合二個資料表的基本語法如下：

  

  ```sql

  SELECT 顯示欄位...

  FROM 資料表A[INNER] JOIN 資料表B

  ON 資料表A.相關欄位 = 資料表B.相關欄位

  ```

  

  另一個方式為：

  

  ```sql

  SELECT 顯示欄位...

  FROM 資料表A[INNER] JOIN 資料表B

  USING(相關欄位);

  ```

  

  無論何種方式結合資料表，會顯示的資料必頇在兩邊資料表有資料，只要有一方法有，即不會出現在結果中。例如有一個學生沒有登錄成績，就不會顯示結果中， 如此很容易有漏失資訊的情況。

  

  Ex: 顯示出學生座號、姓名及其國文成績的查詢，使用 `JOIN`：

  

  ```sql

  SELECT `students`.`cID` as `座號`, `students`.`cName` as `姓名` , `scorelist`.`score` as `國文成績` FROM `students` JOIN `scorelist` ON `students`.`cID` = `scorelist`.`id` WHERE `scorelist`.`course` = '國文';

  ```

  

  ![20230830151322](https://raw.githubusercontent.com/allen-5183/window_picture/main/images/20230830151322.png)

  

  **LEFT JOIN、RIGHT JOIN 語法**

  

  ```sql

  SELECT  顯示欄位..

  FROM  資料表 A LEFT|RIGHT JOIN 資料表 B

  ON A.相關欄位＝B.相關欄位

  ```

  

  EX: 希望可以列出全班同學每個人的成績總分與平均。

  

  使用結合資料表基本語法：

  

  ```sql

  SELECT `students`.`cID`, `students`.`cName`, SUM(`scorelist`.`score`), AVG(`scorelist`.`score`) FROM `students`, `scorelist` WHERE `students`.`cID` = `scorelist`.`cID` GROUP BY `students`.`cID`, `students`.`cName`;

  ```

  

  ![mysql-94](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-94.png)

  

  使用 `JOIN` 基本語法:

  

  ```sql

  SELECT `students`.`cID`, `students`.`cName`, SUM(`scorelist`.`score`), AVG(`scorelist`.`score`) FROM `students` JOIN `scorelist` ON `students`.`cID` = `scorelist`.`cID` GROUP BY `students`.`cID`;

  ```

  

  ![join-1](https://raw.githubusercontent.com/allen-5183/mac/main/images/join-1.png)

  

  使用 `LEFT JOIN`：

  

  ```sql

  SELECT `students`.`cID`, `students`.`cName`, SUM(`scorelist`.`score`), AVG(`scorelist`.`score`) FROM `students` LEFT JOIN `scorelist` ON `students`.`cID` = `scorelist`.`cID` GROUP BY `students`.`cID`, `students`.`cName`;

  ```

  

  ![mysql-95](https://raw.githubusercontent.com/allen-5183/mac/main/images/mysql-95.png)

  

  **練習：**

  

  **DATABASE:** `MYDARABASE`

  **TABLE:** `STUDENT`

  | SNO      | SNAME    |

  | :------- | :------- |

  | CHAR(10) | CHAR(10) |

  | 1001     | JOHN

  | 1002     | MARY

  | 1003     | TOM

  | 1004     | JERRY

  

  ![20230831065228](https://raw.githubusercontent.com/allen-5183/window_picture/main/images/20230831065228.png)

  

  <br/>

  

  **TABLE:** `GRADE`

  | GID | SNO      | COURSE   | SCORE |

  | :-- | :------- | :------- | :---- |

  | INT | CHAR(10) | CHAR(10) | INT   |

  | 1   | 1001     | CHI      | 70    |

  | 2   | 1002     | ENG      | 80    |

  | 3   | 1002     | MATH     | 90    |

  | 4   | 1003     | CHI      | 80    |

  | 5   | 1003     | ENG      | 70    |

  | 6   | 1003     | MATH     | 60    |

  | 7   | 1005     | CHI      | 50    |

  

  ![20230831065400](https://raw.githubusercontent.com/allen-5183/window_picture/main/images/20230831065400.png)

  

  1. 使用 `JOIN`： 取交集，2 邊都有的部分.

     解答:

  

     ```sql

     SELECT `student`.`SNO`, `student`.`SNAME`, `grade`.`COURSE`,`grade`.`SCORE`

     FROM `student` JOIN `grade`

     ON `student`.`SNO` = `grade`.`SNO`;

     ```

  

     ![20240612104813](https://raw.githubusercontent.com/allen-5183/picture/main/pic/20240612104813.png)

  

     ![inner-join](https://raw.githubusercontent.com/allen-5183/mac/main/images/innerjoin.gif)

  

  2. 使用 `LEFT JOIN`：

     解答:

  

     ```sql

     SELECT `student`.`SNO`, `student`.`SNAME`, `grade`.`COURSE`,`grade`.`SCORE`

     FROM `student` LEFT JOIN `grade`

     ON `student`.`SNO` = `grade`.`SNO`;

     ```

  

     ![mydatabase-2](https://raw.githubusercontent.com/allen-5183/mac/main/images/mydatabase_2.png)

  

     ![left-join](https://raw.githubusercontent.com/allen-5183/mac/main/images/leftjoin.gif)

  

  3. 使用 `RIGHT JOIN`：

     解答:

  

     ```sql

     SELECT `student`.`SNO`, `student`.`SNAME`, `grade`.`COURSE`,`grade`.`SCORE`

     FROM `student` RIGHT JOIN `grade`

     ON `student`.`SNO` = `grade`.`SNO`;

     ```

  

     ![mydatabase-3](https://raw.githubusercontent.com/allen-5183/mac/main/images/mydatabase_3.png)

  

     ![right-join](https://raw.githubusercontent.com/allen-5183/mac/main/images/rightjoin.gif)

  

  4. 使用 `FULL JOIN`

     解答:

  

     ```sql

     SELECT * FROM `student` LEFT JOIN `grade`

     ON `student`.`SNO` = `grade`.`SNO`

     UNION ALL

     SELECT * FROM `student` RIGHT JOIN `grade`

     ON `student`.`SNO` = `grade`.`SNO`

     ```

  

     - `LEFT JOIN`

       ![20230831072420](https://raw.githubusercontent.com/allen-5183/window_picture/main/images/20230831072420.png)

  

     - `RIGHT JOIN`

       ![20230831072458](https://raw.githubusercontent.com/allen-5183/window_picture/main/images/20230831072458.png)

  

     - `UNION ALL`

       ![20230831072623](https://raw.githubusercontent.com/allen-5183/window_picture/main/images/20230831072623.png)

  

  5. 使用 `FULL OUTER JOIN`

  

     ```sql

     SELECT `student`.`SNO`, `student`.`SNAME`, `grade`.`COURSE`, `grade`.`SCORE`

     FROM `student` FULL OUTER JOIN `grade`

     ON `student`.`SNO` = `grade`.`SNO`;

  

     ---或

     SELECT * FROM `student`

     FULL OUTER JOIN `grade`

     ON `student`.`SNO` = `grade`.`SNO`;

     ```

  

     >`FULL OUTER JOIN` 產生 `student` 表和 `grade` 表的聯集，但須注意的是，對於沒有匹配的記錄，則會以 `NULL` 為值。可以使用 `IF NULL` 判斷，因 `MySQL 不支持 FULL OUT JOIN`，使用 `Union` 模擬，

  

     ```sql

     SELECT * FROM `student` LEFT JOIN `grade`

     ON `student`.`SNO` = `grade`.`SNO`

     UNION ALL

     SELECT * FROM `student` RIGHT JOIN `grade`

     ON `student`.`SNO` = `grade`.`SNO`

     WHERE `student`.`SNO` IS NULL OR `grade`.`SNO` IS NULL;

     ```

  

   >A inner join B 取交集。

   >A left join B 取 A 全部，B 没有對應的值為 null。

   >A right join B 取 B 全部 A 没有對應的值為 null。

   >A full outer join B 取并集，彼此没有對應的值為 null。

   > 對應條件在 on 後面貼寫

  

---

  

## Q&A

  

Q1. `cmd` 窗口中文亂碼

A1:

  

- 臨時修改，只作用於當前打開的窗口，進入 `cmd` 窗口後，直接執行`chcp 65001`，執行完後，`cmd` 的編碼格式就是 `UTF-8`。

  

- 永久修改，修改註冊表。

  在運行中輸入 `regedit`,找到`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Command Processor`，然後右鍵-`新增`，選擇 `字串值`，`名稱` 列填寫 `autorun`, 數值數據填寫 `chcp 65001`(注意中間帶有空格)。

  

> 950 繁體中文(Big5)、65001 Unicode (UTF-8)