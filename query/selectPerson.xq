declare variable $pid as xs:string external;

let $person-list := doc("../build/personList.xml")//person
for $p in $person-list
    where $p/@id = $pid
    return $p