declare namespace jilm="http://www.lidinsky.cz";

declare variable $pid as xs:string external;
declare variable $person-list := doc("../build/personList.xml")//person;


declare function jilm:get($ref as xs:string*) {
    for $i in $ref
        for $p in $person-list
            where $p/@id = $i
                return ($p, jilm:get($p/father/@href), jilm:get($p/mather/@href))
};

let $ancestors := jilm:get($pid)
return $ancestors