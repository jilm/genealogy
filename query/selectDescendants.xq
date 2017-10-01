declare namespace jilm="http://www.lidinsky.cz";

declare variable $pid as xs:string external;
declare variable $person-list := doc("../build/p.xml")//person;

declare function jilm:getDescendants($person) {
        for $p in $person-list
            where $person/@id = $p/birth/father/@href or $p/birth/mather/@href = $person/@id
                return ($p, jilm:getDescendants($p))
};


<list>{

    let $p := $person-list[@id = $pid]
    let $desc := jilm:getDescendants($p)
    return $desc

}</list>