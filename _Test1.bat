echo off 
echo "Negative Tests: Command Line Arguments"
del \tmp\tmp.*
del \tmp\csv.*

echo Test: No Command Line Args
java epipog 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Usage: epipog <options>" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else echo PASSED

echo Test: no letter follows comma
java epipog - 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Invalid argument, no option letter follows comma" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else echo PASSED

echo Test: Invalid option
java epipog -R 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Invalid option: -R" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else echo PASSED

echo Test: Invalid argument
java epipog dddd 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Invalid argument: ddd" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Missing argument for option -c
java epipog -c 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Missing argument for -c option" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Missing argument for option -C
java epipog -C 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Missing argument for -C option" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Missing argument for option -d
java epipog -d 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Missing argument for -d option" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Missing argument for option -f
java epipog -f 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Missing argument for -f option" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Missing argument for option -F
java epipog -F 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Missing argument for -F option" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Missing argument for option -i
java epipog -i 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Missing argument for -i option" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Missing argument for option -I
java epipog -I 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Missing argument for -I option" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Missing argument for option -o
java epipog -o 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Missing argument for -o option" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Missing argument for option -O
java epipog -O 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Missing argument for -O option" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Missing argument for option -P
java epipog -P 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Missing argument for -P option" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Missing argument for option -s
java epipog -s 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Missing argument for -s option" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Missing argument for option -S
java epipog -S 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Missing argument for -S option" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Missing argument for option -t
java epipog -t 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Missing argument for -t option" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Missing argument for option, another option seen instead
java epipog -c -x 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Missing argument for -c option" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo Test: Not a number for cache argument
java epipog -c foo 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Invalid argument for cache size (-c): foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: Not a valid argument for -d datastore"
java epipog -d foo 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Invalid argument for data store (-d): foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: Not a valid argument for -f filter"
java epipog -f foo -SSTB:string64 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Malformed argument for filter (-f): foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: Invalid Key for -f filter"
java epipog -f foo=2 -SSTB:string64 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Key not found: foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: Not a valid argument for -F format"
java epipog -F foo -i goo -SSTB:string64 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Invalid argument for input format (-F): foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: Not a valid argument for -I index"
java epipog -I foo -SSTB:string64 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Invalid argument for index type (-I): foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: Nonexistent file for -i option"
java epipog -i foo -SSTB:string64 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Unable to open input file: foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: Not a valid argument for -O sort type"
java epipog -O foo -s STB -o STB -S STB:string16 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Invalid argument for sort type (-O): foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: key not found for -o orderby"
java epipog -o foo -s STB -S STB:string16 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Key not found: foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: primary, key not in schema"
java epipog -P foo -SSTB:string16 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Key not found: foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: primary, no schema"
java epipog -P foo 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "No schema" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: schema, key has no data type"
java epipog -S foo 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Schema: key missing data type (-S): foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: schema, invalid data type for key"
java epipog -S foo:goo 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Schema: key has invalid data type (-S): goo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: schema, key already defined"
java epipog -S key1:string16,key1:integer 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Schema: key is defined more than once: key1" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: key not found for -s select"
java epipog -s foo -SSTB:string16 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Key not found: foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: Not a valid argument for -t storage type"
java epipog -t foo 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Invalid argument for storage type (-t): foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

del stdout stderr