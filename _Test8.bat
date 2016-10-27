echo off 
echo "Testing Large Files"
del \tmp\tmp.*

echo "Test: Binary, city-zip 25K records"
java epipog -itests\cityzip.csv -S "state:string32,city:string32,postal:integer,latitude:float,longitude:float,number of poi:short"
if %ERRORLEVEL% NEQ 0 ( echo FAILED rc ) else echo PASSED
java epipog -s "city,postal" >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED rc ) else echo PASSED
fc stdout tests\8.cmp >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED fc ) else echo PASSED
java epipog -s "city,postal" -f "state=OR">stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED fc ) else echo PASSED
fc stdout tests\8a.cmp >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED fc ) else echo PASSED

echo "Test: CSV, city-zip 25K records"
del \tmp\tmp.*
java epipog -itests\cityzip.csv -S "state:string32,city:string32,postal:integer,latitude:float,longitude:float,number of poi:short" -d csv
if %ERRORLEVEL% NEQ 0 ( echo FAILED rc ) else echo PASSED
java epipog -s "city,postal" -d csv >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED rc ) else echo PASSED
fc stdout tests\8.cmp >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED fc ) else echo PASSED
java epipog -s "city,postal,state" -f "state=OR" -d csv>stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED fc ) else echo PASSED
fc stdout tests\8b.cmp >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED fc ) else echo PASSED

echo "Test: JSON, city-zip 25K records"
del \tmp\tmp.*
java epipog -itests\cityzip.csv -S "state:string32,city:string32,postal:integer,latitude:float,longitude:float,number of poi:short" -d json
if %ERRORLEVEL% NEQ 0 ( echo FAILED rc ) else echo PASSED
java epipog -s "city,postal" -d json >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED rc ) else echo PASSED
fc stdout tests\8.cmp >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED fc ) else echo PASSED
java epipog -s "city,postal,state" -f "state=OR" -d json>stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED fc ) else echo PASSED
fc stdout tests\8b.cmp >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED fc ) else echo PASSED

del tmp stdout stderr