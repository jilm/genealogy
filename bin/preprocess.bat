SET parent=%~dp0
java net.sf.saxon.Transform -xsl:%parent%\..\stylesheet\preprocess.xsl -s:%parent%\..\src\data\_lidinsky.xml -o:%parent%\..\build\p.xml