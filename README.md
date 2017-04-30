# SqliteRE (Regex-Encryption)
Customized version of Sqlite library supporting REGEXP and Encryption for Android.
This project is a mix/merge of three other projects that are listed below.

# How to build the native library
- Point to the directory ```src/main/```
- Run the ```ndk-build``` in the command prompt
- move compiled native library from ```libs``` to ```jniLibs```
# How to use
Building this library project using gradle in command line or from Android Studio will produce ```.aar``` file , copy the sqlite.aar file to the ```libs``` directory of your own project, then add the line below to the dependencies section in the ```build.gradle``` :
```
compile ('com.mobilife.sqlitere:sqlitere@aar')
```
Now you just need to change ```import``` part of your code to ```import com.mobilife.sqlitere.database.sqlite.SQLiteDatabase;``` and anything else will remain exactly how you use normal android sqlite classes.

## Regular Experssion Compare 
you can use REGEXP operator to compare a field with a regex string
```sql
SELECT FirstName FROM Persons WHERE LastName REGEXP '^abc'
```
## Encryption
### PRAGMA key
- example usage: `PRAGMA key='passphrase';`
```java
SQLiteDatabase db = SQLiteDatabase.openOrCreateDatabase(dbfile, null);
db.execSQL("PRAGMA key = 'passphrase'");
```
### PRAGMA rekey
- example usage: `PRAGMA rekey='passphrase';`
```java
SQLiteDatabase db = SQLiteDatabase.openOrCreateDatabase(dbfile, null);
db.execSQL("PRAGMA key = 'current passphrase'");
db.execSQL("PRAGMA rekey = 'new passphrase'");
```
- example of decrypting: `PRAGMA rekey='';`
```java
SQLiteDatabase db = SQLiteDatabase.openOrCreateDatabase(dbfile, null);
db.execSQL("PRAGMA key = 'current passphrase'");
db.execSQL("PRAGMA rekey = ''");
```
### Encrypting a new db - order 
```c
open          // <-- db is still plain text
key           // <-- db is now fully encrypted
use as usual
```

### Opening an encrypted DB - order 
```c
open          // <-- db is fully encrypted
key           // <-- db is still fully encrypted
use as usual  // <-- read/written pages are fully encrypted and only decrypted in-memory
```

### Changing the key - order 
```c
open          // <-- db is fully encrypted
key           // <-- db is still fully encrypted
rekey         // <-- db is still fully encrypted
use as usual  
```

### Decrypting - order 
```c
open              // <-- db is fully encrypted
key               // <-- db is still fully encrypted
rekey with null   // <-- db is now fully decrypted to plain text
use as usual
```

# References
-Android native and java helper classes :

https://sqlite.org/android/doc/trunk/www/index.wiki

-Encryption Module :

https://github.com/rindeal/SQLite3-Encryption

-Regexp Module :

https://github.com/litehelpers/Android-sqlite-native-driver-regexp-pcre

-This project uses sqlite amalgamation v3.12.2 , you can replace it with the lastest version from here :

https://github.com/liteglue/sqlite-amalgamation
