(:


:)

let $persons := //person
for $x in $persons
  for $y in $persons
    where $x/name = $y/name and $x/@id != $y/@id
    return $x
