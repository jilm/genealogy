declare namespace jilm="http://www.lidinsky.cz";

(:  Return persons without ids :)

for $p in //person
    where empty($p/@id)
    return $p
