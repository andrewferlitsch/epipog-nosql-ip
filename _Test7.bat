echo off
echo "Testing Filter"
del \tmp\tmp.* 

echo "Test: Binary store: single key=value"
java epipog -i tests\7.txt -Scountry:string32,state:string32,city:string32,pop:integer,census:date
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s "country" -f country=Australia >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7a.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: Binary store: single key=value with double quotes"
java epipog -s "country" -f "country=United States" >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7b.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: Binary store: single key=value not the first key"
java epipog -s "*" -f "city=Portland" >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7c.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: Binary store: single key=value integer value"
java epipog -s "*" -f pop=1500000 >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7d.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: Binary store: single key=value long value"
del \tmp\tmp.*
java epipog -i tests\7.txt -Scountry:string32,state:string32,city:string32,pop:long,census:date
java epipog -s "*" -f pop=1500000 >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7d.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: Binary store: single key=value date value"
java epipog -s "*" -f census=2010-01-01 >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7e.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED ) 


del tmp stdout stderr