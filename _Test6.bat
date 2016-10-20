echo off
echo "Testing Sorting"
del \tmp\tmp.* 

echo "Test: Insertion Sort: not same order as schema: string, first element"
java epipog -i tests\6.txt -Scountry:string32,state:string32,city:string32,pop:integer,census:date
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s "city,state" -o city >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\6a.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED ) 

echo "Test: Insertion Sort: not same order as schema: string, second element"
java epipog -s "city,state" -o state >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\6b.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: Insertion Sort: not same order as schema: integer"
java epipog -s "city,pop,census" -o pop >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\6c.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: Insertion Sort: not same order as schema: date"
java epipog -s "city,pop,census" -o census >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\6d.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: Insertion Sort: key not in results"
java epipog -s "city,state" -o pop 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Sort key not in result: pop" stderr >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED  )

echo "Test: Quick Sort: not same order as schema: string, first element"
java epipog -s "city,state" -o city -O quick >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\6a.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED ) 

echo "Test: Quick Sort: not same order as schema: string, second element"
java epipog -s "city,state" -o state -O quick >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\6e.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: Quick Sort: not same order as schema: integer"
java epipog -s "city,pop,census" -o pop -O quick >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\6c.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: Quick Sort: not same order as schema: date"
java epipog -s "city,pop,census" -o census -O quick >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\6f.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: Quick Sort: key not in results"
java epipog -s "city,state" -o pop -O quick 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Sort key not in result: pop" stderr >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED  )

del tmp stdout stderr