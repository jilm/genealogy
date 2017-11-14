declare namespace jilm="http://www.lidinsky.cz";

(:  Return duplicite ids :)

let $ids := //person/@id
let $unique := distinct-values($ids)
for $id in $unique
    let $p := //person[@id = $id]
    let $count := count($p)
    let $result :=  if ($count > 1) then ( $p ) else ()
    return $result
