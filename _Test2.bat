echo off
echo "Testing Basic Insert for SV inputs"
del \tmp\tmp.* 
del \tmp\csv.*

echo "Test: Empty file, no records"
echo "" >data
java epipog -i data 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "No schema" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else echo PASSED

echo "Test: Simple CSV input, fails no schema"
del \tmp\tmp.*
java epipog -i tests\2.txt -F csv 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "No schema" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else echo PASSED

echo "Test: Simple CSV input, not in schema"
java epipog -i tests\2.txt -F csv -Sfoo:string16,goo:string16,hoo:string16 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Key not found: country" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else echo PASSED

echo "Test: Simple CSV input, schema specified"
del \tmp\tmp.*
java epipog -i tests\2.txt -F csv -Scountry:string16,state:string16,city:string16
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s country >stdout
find "United States" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else echo PASSED

echo "Test: Simple CSV input, schema retained"
java epipog -i tests\2.txt -F csv 
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s country >stdout
find "United States" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else echo PASSED

echo "Test: Simple CSV input, schema specified, case insensitive"
del \tmp\tmp.*
java epipog -i tests\2.txt -F csv -SCountry:string32,State:string32,City:string32
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s country >stdout
find "United States" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else echo PASSED

echo "Test: Simple CSV input, case insensitive on heading"
java epipog -i tests\2a.txt -F csv 
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s country >stdout
find "United States" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: Simple CSV input, trim spacing in heading"
java epipog -i tests\2b.txt -F csv 
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s country >stdout
find "United States" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: Simple CSV input, double quotes in heading"
java epipog -i tests\2c.txt -F csv 
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s country >stdout
find "United States" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: Simple CSV input, double quotes in rows"
java epipog -i tests\2d.txt -F csv 
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s country >stdout
find "United States" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: Simple CSV input, commas in rows"
java epipog -i tests\2e.txt -F csv 
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s country >stdout
find "United States" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: Simple CSV input, less headings than columns"
java epipog -i tests\2f.txt -F csv 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Number of columns in row incorrect" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else echo PASSED

echo "Test: Simple CSV input, less columns than headings"
java epipog -i tests\2g.txt -F csv 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Number of columns in row incorrect" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else echo PASSED

echo "Test: Simple PSV input, fails no schema"
del \tmp\tmp.*
java epipog -i tests\2h.txt -F psv 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "No schema" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else echo PASSED

echo "Test: Simple PSV input, not in schema"
java epipog -i tests\2h.txt -F psv -Sfoo:string32,goo:string32,hoo:string32 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Key not found: country" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else echo PASSED

echo "Test: Simple PSV input, schema specified"
del \tmp\tmp.*
java epipog -i tests\2h.txt -F psv -Scountry:string32,state:string32,city:string32
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s country >stdout
find "United States" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else echo PASSED

echo "Test: Simple PSV input, schema retained"
java epipog -i tests\2h.txt -F psv 
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s country >stdout
find "United States" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else echo PASSED

echo "Test: Simple PSV input, schema specified, case insensitive"
del \tmp\tmp.*
java epipog -i tests\2h.txt -F psv -SCountry:string32,State:string32,City:string32
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s country >stdout
find "United States" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else echo PASSED

echo "Test: Simple PSV input, case insensitive on heading"
java epipog -i tests\2i.txt -F psv 
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s country >stdout
find "United States" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: Simple PSV input, trim spacing in heading"
java epipog -i tests\2j.txt -F psv 
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s country >stdout
find "United States" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: Simple PSV input, double quotes in heading"
java epipog -i tests\2k.txt -F psv 
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s country >stdout
find "United States" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: Simple PSV input, double quotes in rows"
java epipog -i tests\2l.txt -F psv 
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s country >stdout
find "United States" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: Simple PSV input, commas in rows"
java epipog -i tests\2m.txt -F psv 
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s country >stdout
find "United States" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: Simple PSV input, less headings than columns"
java epipog -i tests\2n.txt -F psv 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Number of columns in row incorrect" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else echo PASSED

echo "Test: Simple PSV input, less columns than headings"
java epipog -i tests\2o.txt -F psv 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Number of columns in row incorrect" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else echo PASSED

echo "Test: Simple TSV input, fails no schema"
del \tmp\tmp.*
java epipog -i tests\2p.txt -F tsv 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "No schema" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else echo PASSED

echo "Test: Simple TSV input, not in schema"
java epipog -i tests\2p.txt -F tsv -Sfoo:string32,goo:string32,hoo:string32 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "Key not found: country" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else echo PASSED

echo "Test: Simple TSV input, schema specified"
del \tmp\tmp.*
java epipog -i tests\2p.txt -F tsv -Scountry:string32,state:string32,city:string32
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s country >stdout
find "United States" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else echo PASSED

echo "Test: Simple TSV input, schema retained"
java epipog -i tests\2p.txt -F tsv 
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s country >stdout
find "United States" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else echo PASSED

echo "Test: Simple TSV input, schema specified, case insensitive"
del \tmp\tmp.*
java epipog -i tests\2p.txt -F tsv -SCountry:string32,State:string32,City:string32
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s country >stdout
find "United States" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else echo PASSED

echo "Test: Simple CSV input, no heading, get from retained schema"
java epipog -i tests\2s.txt -F csv -n
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s country >stdout
find "United States" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

echo "Test: Simple CSV input, no heading, no retained schema"
del \tmp\tmp.*
java epipog -i tests\2t.txt -F csv -n 2>stderr
IF %ERRORLEVEL% NEQ 1 (  echo FAILED rc ) else ( echo PASSED )
find "No schema" stderr >stdout
if %ERRORLEVEL% NEQ 0 ( echo FAILED stderr ) else ( echo PASSED )


echo "Test: Simple CSV input, commas in rows, JSON store"
del \tmp\tmp.*
java epipog -i tests\2e.txt -F csv -d json -Scountry:string32,state:string32,city:string32
IF %ERRORLEVEL% NEQ 0 (  echo FAILED rc ) else ( echo PASSED )
java epipog -s country -d json >stdout
find "United States, The" stdout >tmp
if %ERRORLEVEL% NEQ 0 ( echo FAILED stdout ) else ( echo PASSED )

del stdout stderr data