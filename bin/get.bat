SET parent=%~dp0

:: Read command line arguments
:args
IF "%1"=="--name" (
    SET name=%2
)

echo %1

java net.sf.saxon.Query -q:%parent%\..\query\selectPerson.xq pid=%1 | java net.sf.saxon.Transform -xsl:%parent%\..\stylesheet\formTextList.xsl -s:-