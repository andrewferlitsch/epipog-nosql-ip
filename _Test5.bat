echo off
echo "Testing Indexing"
del \tmp\tmp.* 

echo "Test: Linked List, one primary, binary store"
java epipog -i tests\5.txt -Scountry:string32,state:string32,city:string32 -Pcountry
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s "*" >stdout
find "United States,Washington,Seattle" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Calgary" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "United States,Oregon,Portland" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Banff" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )

echo "Test: Linked List, one primary, binary store, reload - all duplicates"
java epipog -i tests\5.txt -Scountry:string32,state:string32,city:string32 -Pcountry
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s "*" >stdout
find "United States,Washington,Seattle" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Calgary" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "United States,Oregon,Portland" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Banff" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )

echo "Test: Linked List, one primary, binary store, second file with some duplicates"
java epipog -i tests\5a.txt -Scountry:string32,state:string32,city:string32 -Pcountry
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s "*" >stdout
find "United States,Washington,Camas" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Calgary" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "Australia,Northwest Territories,Humpty Doo" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "United States,Oregon,Portland" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Banff" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )
find "United States,Washington,Seattle" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )

echo "Test: Linked List, one primary, csv store"
del \tmp\tmp.* 
java epipog -i tests\5.txt -Scountry:string32,state:string32,city:string32 -Pcountry -d csv
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s "*" -d csv >stdout
find "United States,Washington,Seattle" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Calgary" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "United States,Oregon,Portland" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Banff" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )

echo "Test: Linked List, one primary, csv store, reload all duplicates"
java epipog -i tests\5.txt -Scountry:string32,state:string32,city:string32 -Pcountry -d csv
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s "*" -d csv >stdout
find "United States,Washington,Seattle" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Calgary" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "United States,Oregon,Portland" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Banff" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )

echo "Test: Linked List, one primary, csv store, second file with some duplicates"
java epipog -i tests\5a.txt -Scountry:string32,state:string32,city:string32 -Pcountry -d csv
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s "*" -d csv >stdout
find "United States,Washington,Camas" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Calgary" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "Australia,Northwest Territories,Humpty Doo" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "United States,Oregon,Portland" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Banff" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )
find "United States,Washington,Seattle" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )

echo "Test: Linked List, one primary, psv store"
del \tmp\tmp.* 
java epipog -i tests\5.txt -Scountry:string32,state:string32,city:string32 -Pcountry -d psv
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s "*" -d psv >stdout
find "United States,Washington,Seattle" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Calgary" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "United States,Oregon,Portland" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Banff" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )

echo "Test: Linked List, one primary, psv store, reload all duplicates"
java epipog -i tests\5.txt -Scountry:string32,state:string32,city:string32 -Pcountry -d psv
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s "*" -d psv >stdout
find "United States,Washington,Seattle" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Calgary" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "United States,Oregon,Portland" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Banff" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )

echo "Test: Linked List, one primary, psv store, second file with some duplicates"
java epipog -i tests\5a.txt -Scountry:string32,state:string32,city:string32 -Pcountry -d psv
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s "*" -d psv >stdout
find "United States,Washington,Camas" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Calgary" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "Australia,Northwest Territories,Humpty Doo" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "United States,Oregon,Portland" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Banff" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )
find "United States,Washington,Seattle" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )

echo "Test: Linked List, one primary, json store"
del \tmp\tmp.* 
java epipog -i tests\5.txt -Scountry:string32,state:string32,city:string32 -Pcountry -d json
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s "*" -d json >stdout
find "United States,Washington,Seattle" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Calgary" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "United States,Oregon,Portland" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Banff" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )

echo "Test: Linked List, one primary, json store, reload all duplicates"
java epipog -i tests\5.txt -Scountry:string32,state:string32,city:string32 -Pcountry -d json
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s "*" -d json >stdout
find "United States,Washington,Seattle" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Calgary" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "United States,Oregon,Portland" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Banff" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )

echo "Test: Linked List, one primary, json store, second file with some duplicates"
java epipog -i tests\5a.txt -Scountry:string32,state:string32,city:string32 -Pcountry -d json
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s "*" -d json >stdout
find "United States,Washington,Camas" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Calgary" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "Australia,Northwest Territories,Humpty Doo" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "United States,Oregon,Portland" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Banff" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )
find "United States,Washington,Seattle" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )

echo "Test: Linked Index, two primary, binary store"
del \tmp\tmp.* 
java epipog -i tests\5.txt -Scountry:string32,state:string32,city:string32 -Pcountry,state 
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s "*" >stdout
find "United States,Washington,Seattle" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "United States,Oregon,Salem" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Calgary" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,British Columbia,Vancouver" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "United States,Oregon,Portland" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Banff" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )

echo "Test: Linked Index, two primary, csv store"
del \tmp\tmp.* 
java epipog -i tests\5.txt -Scountry:string32,state:string32,city:string32 -Pcountry,state -d csv
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s "*" -d csv >stdout
find "United States,Washington,Seattle" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "United States,Oregon,Salem" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Calgary" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,British Columbia,Vancouver" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "United States,Oregon,Portland" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Banff" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )

echo "Test: Linked Index, two primary, psv store"
del \tmp\tmp.* 
java epipog -i tests\5.txt -Scountry:string32,state:string32,city:string32 -Pcountry,state -d psv
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s "*" -d psv >stdout
find "United States,Washington,Seattle" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "United States,Oregon,Salem" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Calgary" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,British Columbia,Vancouver" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )
find "United States,Oregon,Portland" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )
find "Canada,Alberta,Banff" stdout >tmp
if %ERRORLEVEL% NEQ 1 ( echo FAILED stdout ) else ( echo PASSED  )

echo "Test: Linked Index, retain primary keys in schema"
del \tmp\tmp.* 
java epipog -i tests\5.txt -Scountry:string32,state:string32,city:string32 -Pcountry
if %ERRORLEVEL% NEQ 0 ( echo FAILED rc ) else ( echo PASSED  )
java epipog -i tests\5.txt
if %ERRORLEVEL% NEQ 0 ( echo FAILED rc ) else ( echo PASSED  )
java epipog -s "*" >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED rc ) else ( echo PASSED  )
fc stdout tests\5.cmp >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED  )

del tmp stdout stderr
