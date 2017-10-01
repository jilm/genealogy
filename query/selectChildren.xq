declare namespace jilm="http://www.lidinsky.cz";

declare variable $pid as xs:string external;
declare variable $person-list := doc("../build/p.xml")//person;

<list>{

for $i in $person-list
    where $i/birth/mather/@href = $pid or $i/birth/father/@href = $pid
        return $i

}</list>