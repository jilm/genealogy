SET parent=%~dp0
java net.sf.saxon.Query -q:%parent%\..\query\selectDescendants.xq pid=%1  | java net.sf.saxon.Transform -xsl:%parent%\..\stylesheet\formTextList.xsl -s:-