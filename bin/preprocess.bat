SET parent=%~dp0

java net.sf.saxon.Transform -xsl:%parent%\..\stylesheet\preprocess.xsl -s:%parent%\..\src\data\__lidinsky.xml -o:%parent%\..\build\p.xml
java net.sf.saxon.Transform -xsl:%parent%\..\stylesheet\preprocessSort.xsl -s:%parent%\..\build\p.xml -o:%parent%\..\build\pp.xml
java net.sf.saxon.Transform -xsl:%parent%\..\stylesheet\preprocessChildren.xsl -s:%parent%\..\build\pp.xml -o:%parent%\..\build\ppp.xml
java net.sf.saxon.Transform -xsl:%parent%\..\stylesheet\preprocessWeddings.xsl -s:%parent%\..\build\ppp.xml -o:%parent%\..\build\pppp.xml
java net.sf.saxon.Transform -xsl:%parent%\..\stylesheet\makeDescGenTree.xsl -s:%parent%\..\build\pppp.xml -o:%parent%\..\build\desTree.tex
