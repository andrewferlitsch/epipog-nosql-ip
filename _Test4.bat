echo off
echo "Testing Data Types"
del \tmp\tmp.* 
del \tmp\csv.*
del \tmp\psv.*
del \tmp\bin.*

echo "Test: binary store, integer,float,date,time"
java epipog -i tests\4.txt -Smoney:integer,temp:float,date:date,time:time -d binary -F psv
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s money,time,date,temp >stdout
find "20,12:03,2016-10-02,6.2" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )

echo "Test: csv store, integer,float,date,time"
del \tmp\tmp.*
java epipog -i tests\4.txt -Smoney:integer,temp:float,date:date,time:time -d csv -F psv
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s money,time,date,temp -d csv >stdout
find "20,12:03,2016-10-02,6.2" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: psv store, integer,float,date,time"
del \tmp\tmp.*
java epipog -i tests\4.txt -Smoney:integer,temp:float,date:date,time:time -d psv -F psv
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s money,time,date,temp -d psv >stdout
find "20,12:03,2016-10-02,6.2" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: json store, integer,float,date,time"
del \tmp\tmp.*
java epipog -i tests\4.txt -Smoney:integer,temp:float,date:date,time:time -d json -F psv
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s money,time,date,temp -d json >stdout
find "20,12:03,2016-10-02,6.2" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: binary store, hex numbers and leading zeros"
del \tmp\tmp.*
java epipog -i tests\4a.txt -Smoney:integer,temp:float,date:date,time:time -d binary -F psv
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s money,time,date,temp -d binary >stdout
find "66,11:00,2016-10-01,7.6" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: csv store, hex numbers and leading zeros"
del \tmp\tmp.*
java epipog -i tests\4a.txt -Smoney:integer,temp:float,date:date,time:time -d csv -F psv
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s money,time,date,temp -d csv >stdout
find "66,11:00,2016-10-01,7.6" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: psv store, hex numbers and leading zeros"
del \tmp\tmp.*
java epipog -i tests\4a.txt -Smoney:integer,temp:float,date:date,time:time -d psv -F psv
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s money,time,date,temp -d psv >stdout
find "66,11:00,2016-10-01,7.6" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: json store, hex numbers and leading zeros"
del \tmp\tmp.*
java epipog -i tests\4a.txt -Smoney:integer,temp:float,date:date,time:time -d json -F psv
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s money,time,date,temp -d json >stdout
find "66,11:00,2016-10-01,7.6" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: binary store, hex numbers and leading zeros, case insensitive"
del \tmp\tmp.*
java epipog -i tests\4b.txt -Smoney:integer,temp:float,date:date,time:time -d binary -F psv
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s money,time,date,temp -d binary >stdout
find "66,11:00,2016-10-01,7.6" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: csv store, hex numbers and leading zeros, case insensitive"
del \tmp\tmp.*
java epipog -i tests\4b.txt -Smoney:integer,temp:float,date:date,time:time -d csv -F psv
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s money,time,date,temp -d csv >stdout
find "66,11:00,2016-10-01,7.6" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: psv store, hex numbers and leading zeros, case insensitive"
del \tmp\tmp.*
java epipog -i tests\4b.txt -Smoney:integer,temp:float,date:date,time:time -d psv -F psv
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s money,time,date,temp -d psv >stdout
find "66,11:00,2016-10-01,7.6" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: json store, hex numbers and leading zeros, case insensitive"
del \tmp\tmp.*
java epipog -i tests\4b.txt -Smoney:integer,temp:float,date:date,time:time -d json -F psv
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s money,time,date,temp -d json >stdout
find "66,11:00,2016-10-01,7.6" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: PSV, incorrect data type for integer"
del \tmp\tmp.*
java epipog -i tests\4c.txt -Smoney:integer,temp:float,date:date,time:time -d binary -F psv 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Incorrect value for data type: ab" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: PSV, incorrect data type for short"
del \tmp\tmp.*
java epipog -i tests\4c.txt -Smoney:short,temp:float,date:date,time:time -d binary -F psv 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Incorrect value for data type: ab" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: PSV, incorrect data type for long"
del \tmp\tmp.*
java epipog -i tests\4c.txt -Smoney:long,temp:float,date:date,time:time -d binary -F psv 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Incorrect value for data type: ab" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: PSV, incorrect data type for float"
del \tmp\tmp.*
java epipog -i tests\4d.txt -Smoney:long,temp:float,date:date,time:time -d binary -F psv 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Incorrect value for data type: 6.x" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: PSV, incorrect data type for double"
del \tmp\tmp.*
java epipog -i tests\4d.txt -Smoney:long,temp:double,date:date,time:time -d binary -F psv 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Incorrect value for data type: 6.x" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: PSV, incorrect data type for time"
del \tmp\tmp.*
java epipog -i tests\4e.txt -Smoney:long,temp:double,date:date,time:time -d binary -F psv 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Incorrect value for time data type: 12.03" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: PSV, incorrect data type for date"
del \tmp\tmp.*
java epipog -i tests\4f.txt -Smoney:long,temp:double,date:date,time:time -d binary -F psv 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Incorrect value for date data type: 2016-20-02" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: CSV, incorrect data type for string16"
del \tmp\tmp.*
java epipog -i tests\4g.txt -Scountry:string16,state:string16 -F csv 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Value too long for string16 data type: United States of America" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: CSV, incorrect data type for string32"
del \tmp\tmp.*
java epipog -i tests\4g.txt -Scountry:string32,state:string16 -F csv 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Value too long for string32 data type: United Kingdom of Great Britain and Northern Ireland" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: CSV, incorrect data type for string64"
del \tmp\tmp.*
java epipog -i tests\4h.txt -Scountry:string64,state:string16 -F csv 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Value too long for string64 data type: " stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: CSV, incorrect data type for string128"
del \tmp\tmp.*
java epipog -i tests\4i.txt -Scountry:string128,state:string16 -F csv 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Value too long for string128 data type: " stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: CSV, incorrect data type for char"
del \tmp\tmp.*
java epipog -i tests\4j.txt -Sname:string16,status:char -F csv 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Value too long for char data type: " stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )

echo "Test: CSV, char data type"
del \tmp\tmp.*
java epipog -i tests\4k.txt -Sfield1:char,field2:integer -F csv -d csv
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s "*" -d csv >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
find "c,12" stdout >stderr
IF %ERRORLEVEL% NEQ 0 (  echo FAILED stdout ) else ( echo PASSED )

echo "Test: JSON, char data type"
del \tmp\tmp.*
java epipog -i tests\4k.txt -Sfield1:char,field2:integer -F csv -d json
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s "*" -d json >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
find "c,12" stdout >stderr
IF %ERRORLEVEL% NEQ 0 (  echo FAILED stdout ) else ( echo PASSED )

echo "Test: binary, char data type"
del \tmp\tmp.*
java epipog -i tests\4k.txt -Sfield1:char,field2:integer -F csv 
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s "*" >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
find "c,12" stdout >stderr
IF %ERRORLEVEL% NEQ 0 (  echo FAILED stdout ) else ( echo PASSED )

del tmp stdout stderr