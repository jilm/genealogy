declare namespace saxon="http://saxon.sf.net";
declare option saxon:output "indent=yes";

<list>{
let $persons := //person[name/first and @sex]
let $names := distinct-values(
for $p in $persons
return $p/name/first/text()
)
for $n in $names
return <name sex="{$persons[name/first/text() = $n and @sex][1]/@sex}">{$n}</name>

}</list>
