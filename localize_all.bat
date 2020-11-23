SET rAthena_PATH=E:\ROEmu\rAthena
SET Auriga_PATH=E:\ROEmu\AurigaOriginal

copy /Y %rAthena_PATH%\db\re\item_db_equip.yml %rAthena_PATH%\db\re\item_db_equip_jpn.yml
copy /Y %rAthena_PATH%\db\re\item_db_etc.yml %rAthena_PATH%\db\re\item_db_etc_jpn.yml
copy /Y %rAthena_PATH%\db\re\item_db_usable.yml %rAthena_PATH%\db\re\item_db_usable_jpn.yml

itemdb_localizer.rb --nobackup %rAthena_PATH%\db\re\item_db_equip_jpn.yml idnum2itemdisplaynametable.txt
itemdb_localizer.rb --nobackup %rAthena_PATH%\db\re\item_db_etc_jpn.yml idnum2itemdisplaynametable.txt
itemdb_localizer.rb --nobackup %rAthena_PATH%\db\re\item_db_usable_jpn.yml idnum2itemdisplaynametable.txt

mobdb_localizer --nobackup %rAthena_PATH%\db\re\mob_db.txt %Auriga_PATH%\db\mob_db.txt

pause
