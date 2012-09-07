ホームページ
============

ファイル構成は以下の通り。

|ファイル名   |                                       |
|-------------|---------------------------------------|
|bfs          |分子機能シミュレーション研究チーム     |
|cbp          |粒子系生物物理研究チーム               |
|tms          |理論分子科学研究室                     |
|tutorial.pdf |ブラビオ株式会社作成の編集手順ファイル |

ファイルのダウンロード
----------------------
ダウンロードは以下のコマンドを使用してください。

    git clone git@github.com:sugitalab/hp.git

ホームページ編集方法
--------------------
tutorial.pdfを読むこと

### テンプレートを編集する場合

**CAUTION**
必ずAdobe Dreamweaverを使用してください。

Dreamweaver CS6 
メニューバー > サイト > 新規サイト または サイトの管理
を選び、ローカルサイトフォルダーを  
/path/to/hp/bfs (または、cbp、tms)  
と選択し、サイト名を付けて（名称未設定サイトのままでも良い）保存する。  
ファイルのウィンドウ（見つからなければメニューバー > ウィンドウ > ファイル を選択）からTemplatesフォルダの中の該当テンプレートを選択し、編集する。

**グレーアウトしている箇所は、編集できません。**
上位のテンプレートを編集する必要がありますので、3行目の

    <!-- InstanceBegin template="/Templates/en_index.dwt" codeOutsideHTMLIsLocked="false" -->

を手がかりに編集すべきテンプレートファイルを選択してください。  
表示をコードとデザイン（メニューバー > 表示 > コードとデザイン）とすると編集しやすいと思います。

**サイトの選択をしていない場合、各ページのパスが設定されていないため、テンプレートが反映されません。**

### テンプレート以外のドキュメントを編集する場合

できるだけAdobe Dreamweaverを使用してください。

#### Dreamweaverを使う場合
上記サイトの設定は必要ありません。
ページを選択し、編集してください。  
**グレーアウトしている箇所は編集できません。**  
テンプレートを編集する必要がありますので、3行目の

    <!-- InstanceBegin template="/Templates/en_index.dwt" codeOutsideHTMLIsLocked="false" -->

を手がかりに編集すべきテンプレートファイルを選択してください。
テンプレートを編集する場合は、上記「テンプレートを編集する場合」に従ってください。

表示をコードとデザイン（メニューバー > 表示 > コードとデザイン）とすると編集しやすいと思います。

#### Dreamweaverを使わない場合

編集可能な箇所は、

    <!-- InstanceBeginEditable name="contents" --> 

と

    <!-- InstanceEndEditable --> 

で囲まれた箇所です。
それ以外の箇所を編集した場合、**ページ全体のレイアウトに影響する場合がありますので注意してください。**

