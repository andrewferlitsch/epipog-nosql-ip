echo off 
echo "Negative Tests: Command Line Arguments"
del \tmp\tmp.*
del \tmp\csv.*

echo Test: No Command Line Args
java query 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Usage: query <options>" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else echo PASSED

echo Test: no letter follows comma
java query - 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Invalid argument, no option letter follows comma" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else echo PASSED

echo Test: Invalid option
java query -R 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Invalid option: -R" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else echo PASSED

echo Test: Invalid argument
java query dddd 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Invalid argument: ddd" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Missing argument for option -c
java query -c 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Missing argument for -c option" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Missing argument for option -C
java query -C 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Missing argument for -C option" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Missing argument for option -d
java query -d 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Missing argument for -d option" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Missing argument for option -f
java query -f 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Missing argument for -f option" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Missing argument for option -F
java query -F 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Missing argument for -F option" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Missing argument for option -i
java query -i 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Missing argument for -i option" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Missing argument for option -I
java query -I 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Missing argument for -I option" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Missing argument for option -o
java query -o 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Missing argument for -o option" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Missing argument for option -O
java query -O 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Missing argument for -O option" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Missing argument for option -P
java query -P 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Missing argument for -P option" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Missing argument for option -s
java query -s 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Missing argument for -s option" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Missing argument for option -S
java query -S 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Missing argument for -S option" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Missing argument for option -t
java query -t 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Missing argument for -t option" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Missing argument for option, another option seen instead
java query -c -x 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Missing argument for -c option" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Not a number for cache argument
java query -c foo 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Invalid argument for cache size (-c): foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: Not a valid argument for -d datastore"
java query -d foo 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Invalid argument for data store (-d): foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: Not a valid argument for -f filter"
java query -f foo -SSTB:string64 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Malformed argument for filter (-f): foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: Invalid Key for -f filter"
java query -f foo=2 -SSTB:string64 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Key not found: foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: Not a valid argument for -F format"
java query -F foo -i goo -SSTB:string64 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Invalid argument for input format (-F): foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: Not a valid argument for -I index"
java query -I foo -SSTB:string64 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Invalid argument for index type (-I): foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: Nonexistent file for -i option"
java query -i foo -SSTB:string64 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Unable to open input file: foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: Not a valid argument for -O sort type"
java query -O foo -s STB -o STB -S STB:string16 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Invalid argument for sort type (-O): foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: key not found for -o orderby"
java query -o foo -s STB -S STB:string16 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Key not found: foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: primary, key not in schema"
java query -P foo -SSTB:string16 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Key not found: foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: primary, no schema"
java query -P foo 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "No schema" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: schema, key has no data type"
java query -S foo 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Schema: key missing data type (-S): foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: schema, invalid data type for key"
java query -S foo:goo 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Schema: key has invalid data type (-S): goo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: schema, key already defined"
java query -S key1:string16,key1:integer 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Schema: key is defined more than once: key1" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: key not found for -s select"
java query -s foo -SSTB:string16 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Key not found: foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: Not a valid argument for -t storage type"
java query -t foo 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Invalid argument for storage type (-t): foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

del stdout stderr