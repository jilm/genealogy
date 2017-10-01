declare variable $pid as xs:string external;

<list>{

let $person-list := doc("../build/p.xml")//person
for $p in $person-list
    where contains($p/@id, $pid)
    return $p

}</list>
