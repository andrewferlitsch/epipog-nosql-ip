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

echo "Test: Binary store: single key=bad value for integer"
java epipog -s "*" -f pop=xxx0000 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Invalid argument for find clause (-f): xxx0000" stderr >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED stderr ) else ( echo PASSED )  

echo "Test: Binary store: single key=bad value for date"
java epipog -s "*" -f census=2015-0x-c 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Invalid argument for find clause (-f): 2015-0x-c" stderr >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED stderr ) else ( echo PASSED )

echo "Test: Binary store: single key=value short value"
del \tmp\tmp.*
java epipog -i tests\7a.txt -Sperson:string16,start:time,count:short
java epipog -s "*" -f count=6 >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7f.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: Binary store: single key=value time value"
del \tmp\tmp.*
java epipog -i tests\7a.txt -Sperson:string16,start:time,count:short
java epipog -s "*" -f start=11:18 >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7g.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: CSV store: single key=value"
del \tmp\tmp.*
java epipog -i tests\7.txt -Scountry:string32,state:string32,city:string32,pop:integer,census:date -d csv
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s "country" -f country=Australia -d csv >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7a.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: CSV store: single key=value with double quotes"
java epipog -s "country" -f "country=United States" -d csv >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7b.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: CSV store: single key=value not the first key"
java epipog -s "*" -f "city=Portland" -d csv >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7c.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: CSV store: single key=value integer value"
java epipog -s "*" -f pop=1500000 -d csv >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7d.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: CSV store: single key=value long value"
del \tmp\tmp.*
java epipog -i tests\7.txt -Scountry:string32,state:string32,city:string32,pop:long,census:date -d csv
java epipog -s "*" -f pop=1500000 -d csv >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7d.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: CSV store: single key=value date value"
java epipog -s "*" -f census=2010-01-01 -d csv >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7e.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED ) 

echo "Test: CSV store: single key=bad value for integer"
java epipog -s "*" -f pop=xxx0000 -d csv 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Invalid argument for find clause (-f): xxx0000" stderr >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED stderr ) else ( echo PASSED )  

echo "Test: CSV store: single key=bad value for date"
java epipog -s "*" -f census=2015-0x-c -d csv 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Invalid argument for find clause (-f): 2015-0x-c" stderr >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED stderr ) else ( echo PASSED )

echo "Test: CSV store: single key=value short value"
del \tmp\tmp.*
java epipog -i tests\7a.txt -Sperson:string16,start:time,count:short -d csv
java epipog -s "*" -f count=6 -d csv >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7f.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: CSV store: single key=value time value"
del \tmp\tmp.*
java epipog -i tests\7a.txt -Sperson:string16,start:time,count:short -d csv
java epipog -s "*" -f start=11:18 -d csv >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7g.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: JSON store: single key=value"
del \tmp\tmp.*
java epipog -i tests\7.txt -Scountry:string32,state:string32,city:string32,pop:integer,census:date -d json
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s "country" -f country=Australia -d json >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7a.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: JSON store: single key=value with double quotes"
java epipog -s "country" -f "country=United States" -d json >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7b.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: JSON store: single key=value not the first key"
java epipog -s "*" -f "city=Portland" -d json >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7c.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: JSON store: single key=value integer value"
java epipog -s "*" -f pop=1500000 -d json >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7d.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: JSON store: single key=value long value"
del \tmp\tmp.*
java epipog -i tests\7.txt -Scountry:string32,state:string32,city:string32,pop:long,census:date -d json
java epipog -s "*" -f pop=1500000 -d json >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7d.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: JSON store: single key=value date value"
java epipog -s "*" -f census=2010-01-01 -d json >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7e.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED ) 

echo "Test: JSON store: single key=bad value for integer"
java epipog -s "*" -f pop=xxx0000 -d json 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Invalid argument for find clause (-f): xxx0000" stderr >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED stderr ) else ( echo PASSED )  

echo "Test: JSON store: single key=bad value for date"
java epipog -s "*" -f census=2015-0x-c -d json 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Invalid argument for find clause (-f): 2015-0x-c" stderr >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED stderr ) else ( echo PASSED )

echo "Test: JSON store: single key=value short value"
del \tmp\tmp.*
java epipog -i tests\7a.txt -Sperson:string16,start:time,count:short -d json
java epipog -s "*" -f count=6 -d json >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7f.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: JSON store: single key=value time value"
del \tmp\tmp.*
java epipog -i tests\7a.txt -Sperson:string16,start:time,count:short -d json
java epipog -s "*" -f start=11:18 -d json >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7g.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: Binary store: single key<value, integer"
del \tmp\tmp.*
java epipog -i tests\7.txt -Scountry:string32,state:string32,city:string32,pop:integer,census:date
java epipog -s "*" -f "pop<150000" >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7h.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: Binary store: single key<value, date"
java epipog -s "*" -f "census<2012-01-01" >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7i.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: Binary store: single key<value, string"
java epipog -s "*" -f "state<D" >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7j.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: Binary store: single key<value long value"
del \tmp\tmp.*
java epipog -i tests\7.txt -Scountry:string32,state:string32,city:string32,pop:long,census:date
java epipog -s "*" -f "pop<150000" >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7h.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: Binary store: single key<value short value"
del \tmp\tmp.*
java epipog -i tests\7a.txt -Sperson:string16,start:time,count:short
java epipog -s "*" -f "count<6" >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7k.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: Binary store: single key<value time value"
del \tmp\tmp.*
java epipog -i tests\7a.txt -Sperson:string16,start:time,count:short
java epipog -s "*" -f"start<11:18" >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7l.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: CSV store: single key<value, integer"
del \tmp\tmp.*
java epipog -i tests\7.txt -Scountry:string32,state:string32,city:string32,pop:integer,census:date -d csv
java epipog -s "*" -f "pop<150000" -d csv >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7h.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: CSV store: single key<value, date"
java epipog -s "*" -f "census<2012-01-01" -d csv >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7i.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: CSV store: single key<value, string"
java epipog -s "*" -f "state<D" -d csv >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7j.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: CSV store: single key<value long value"
del \tmp\tmp.*
java epipog -i tests\7.txt -Scountry:string32,state:string32,city:string32,pop:long,census:date -d csv
java epipog -s "*" -f "pop<150000" -d csv >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7h.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: CSV store: single key<value short value"
del \tmp\tmp.*
java epipog -i tests\7a.txt -Sperson:string16,start:time,count:short -d csv
java epipog -s "*" -f "count<6" -d csv >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7k.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: CSV store: single key<value time value"
del \tmp\tmp.*
java epipog -i tests\7a.txt -Sperson:string16,start:time,count:short -d csv
java epipog -s "*" -f "start<11:18" -d csv >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7l.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: JSON store: single key<value, integer"
del \tmp\tmp.*
java epipog -i tests\7.txt -Scountry:string32,state:string32,city:string32,pop:integer,census:date -d json
java epipog -s "*" -f "pop<150000" -d json >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7h.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: JSON store: single key<value, date"
java epipog -s "*" -f "census<2012-01-01" -d json >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7i.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: JSON store: single key<value, string"
java epipog -s "*" -f "state<D" -d json >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7j.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: JSON store: single key<value long value"
del \tmp\tmp.*
java epipog -i tests\7.txt -Scountry:string32,state:string32,city:string32,pop:long,census:date -d json
java epipog -s "*" -f "pop<150000" -d json >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7h.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: JSON store: single key<value short value"
del \tmp\tmp.*
java epipog -i tests\7a.txt -Sperson:string16,start:time,count:short -d json
java epipog -s "*" -f "count<6" -d json >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7k.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: JSON store: single key<value time value"
del \tmp\tmp.*
java epipog -i tests\7a.txt -Sperson:string16,start:time,count:short -d json
java epipog -s "*" -f "start<11:18" -d json >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
fc stdout tests\7l.cmp >tmp
IF %ERRORLEVEL% NEQ 0 (  echo FAILED cmp ) else ( echo PASSED )

echo "Test: singe key/value where, no schema"
del \tmp\tmp.*
java epipog -s "*" -f "start<11:18" -d json 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "No Schema" stderr >stdout
IF %ERRORLEVEL% NEQ 0 (  echo FAILED stderr ) else ( echo PASSED )

del tmp stdout stderr