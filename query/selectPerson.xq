declare variable $pid as xs:string external;

<list>{

let $person-list := doc("../build/personList.xml")//person
for $p in $person-list
    where contains($p/@id, $pid)
    return $p

}</list>
