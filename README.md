# sqlitere
Customized version of Sqlite library supporting REGEXP and Encryption for Android.
This project is a mix/merge of three other projects that are listed below.

This project uses lastest version of sqlite amalgamation v3.12.2 , you can replace it with the lastest version from here :
https://github.com/liteglue/sqlite-amalgamation

# Usages
## Regular Experssion Compare 
you can use REGEXP operator to compare a field with a regex string
```sql
SELECT FirstName FROM Persons WHERE LastName REGEXP '^abc'
```
## Encryption
### PRAGMA key
- example usage: `PRAGMA key='passphrase';`

### PRAGMA rekey
- example usage: `PRAGMA rekey='passphrase';`
- example of decrypting: `PRAGMA rekey='';`

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
