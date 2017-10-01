SET parent=%~dp0
java net.sf.saxon.Query -q:%parent%\..\query\selectChildren.xq pid=%1  | java net.sf.saxon.Transform -xsl:%parent%\..\stylesheet\formTextList.xsl -s:-