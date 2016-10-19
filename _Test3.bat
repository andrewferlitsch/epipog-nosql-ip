echo off
echo "Testing Basic Select"
del \tmp\tmp.* 
del \tmp\csv.*
del \tmp\psv.*
del \tmp\bin.*

echo "Test: binary store, select all, no schema"
del \tmp\tmp.*
java query -s "*" 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "No Schema" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: binary store, select all, with schema"
java query -i tests\3.txt -F csv -Scountry:string16,state:string16,city:string16,pop:integer
java query -s "*" >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
find "United States,Oregon,Portland,1000000" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: binary store, select nonexistent column"
java query -s foo 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Key not found: foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: binary store, select one column"
java query -s city >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
find "Vancouver" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: binary store, select two columns"
java query -s state,city >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
find "Washington,Vancouver" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: binary store, change column order"
java query -s state,pop,city >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
find "Washington,200000,Vancouver" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: csv store, select all, with schema"
del \tmp\tmp.*
java query -i tests\3.txt -F csv -Scountry:string16,state:string16,city:string16,pop:integer -d csv
java query -s "*" -d csv >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
find "United States,Oregon,Portland,1000000" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: csv store, select nonexistent column"
java query -s foo -d csv 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Key not found: foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: csv store, select one column"
java query -s city -d csv >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
find "Vancouver" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: csv store, select two columns"
java query -s state,city -d csv >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
find "Washington,Vancouver" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: csv store, change column order"
java query -s state,pop,city -d csv >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
find "Washington,200000,Vancouver" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: psv store, select all, with schema"
del \tmp\tmp.*
java query -i tests\3.txt -F csv -Scountry:string16,state:string16,city:string16,pop:integer -d psv
java query -s "*" -d psv >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
find "United States,Oregon,Portland,1000000" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: psv store, select nonexistent column"
java query -s foo -d psv 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Key not found: foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: psv store, select one column"
java query -s city -d psv >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
find "Vancouver" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: psv store, select two columns"
java query -s state,city -d psv >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
find "Washington,Vancouver" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: psv store, change column order"
java query -s state,pop,city -d psv >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
find "Washington,200000,Vancouver" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: json store, select all, with schema"
del \tmp\tmp.*
java query -i tests\3.txt -F csv -Scountry:string16,state:string16,city:string16,pop:integer -d json
java query -s "*" -d json >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
find "United States,Oregon,Portland,1000000" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: json store, select nonexistent column"
java query -s foo -d json 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Key not found: foo" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: json store, select one column"
java query -s city -d json >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
find "Vancouver" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: json store, select two columns"
java query -s state,city -d json >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
find "Washington,Vancouver" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: json store, change column order"
java query -s state,pop,city -d json >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
find "Washington,200000,Vancouver" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: binary store, invalid collection"
java query -s city -C foo 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "No schema" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: binary store, named collection"
del \tmp\tmp.*
del \tmp\bin.*
java query -i tests\3.txt -F csv -Scountry:string16,state:string16,city:string16,pop:integer -C bin
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java query -s city -C bin >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
find "Salem" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: csv store, named collection"
del \tmp\csv.*
java query -i tests\3.txt -F csv -Scountry:string16,state:string16,city:string16,pop:integer -C csv -d csv
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java query -s city -C csv -d csv >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
find "Salem" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: psv store, named collection"
del \tmp\psv.*
java query -i tests\3.txt -F csv -Scountry:string16,state:string16,city:string16,pop:integer -C psv -d psv
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java query -s city -C psv -d psv >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
find "Salem" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: json store, named collection"
del \tmp\json.*
java query -i tests\3.txt -F csv -Scountry:string16,state:string16,city:string16,pop:integer -C json -d json
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java query -s city -C json -d json >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
find "Salem" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

del tmp stdout stderr