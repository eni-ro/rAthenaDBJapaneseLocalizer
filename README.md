# rAthenaDB Japanese Localizer
rAthenaとItemDBとMobDBの登録名を、クライアント/Aurigaのデータを利用して日本語化するだけのツールです  

## 環境
* Ruby  
[公式ダウンロードページ](https://www.ruby-lang.org/ja/downloads/)下部にWindows向けバイナリの配布先リンク有り  
[RubyInstaller](https://rubyinstaller.org/)あたりをインストールしておけば問題なく動くはず  
* GTK3  
Rubyインストール後にコマンドプロンプトで以下のコマンドを打ってインストール  
`gem install gtk3`  

## 使用方法
1. rAthenaボタンを押して置換対象のファイルを選択する
2. Aurigaボタンを押して対応するAurigaの設定ファイルを選択する
3. Applyを選択すると1で選択したファイルが更新される  
元のファイルは.bakを付けて1世代だけバックアップされる

## ファイル対応関係
### MobDB
mobdb_localizer.rbで以下のファイルを選択する
|rAthena|Auriga|
|---|---|
|.\db\re\mob_db.txt|.\db\mob_db.txt|

### ItemDB
itemdb_localizer.rbでidnum2itemdisplaynametable.txtをファイルを選択する  
idnum2itemdisplaynametable.txtは[GrfEditor](https://rathena.org/board/files/file/2766-grf-editor/)を使用してdata.grfから抽出しておく  
|rAthena|Auriga|
|---|---|
|.\db\re\item_db_equip.yml<br>.\db\re\item_db_etc.yml<br>.\db\re\item_db_usable.yml|data\idnum2itemdisplaynametable.txt|
