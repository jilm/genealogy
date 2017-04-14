(:


let $res-places := distinct-values(doc('../resources/places.xml')//place/parish/text())
let $places := //place[parish]/parish/text() | //place[not(parish)]/text()
let $pp := (
for $place in $places
  for $y in $res-places
    where contains($place, $y)
      return $y
)
for $i in distinct-values($pp)
return ($i, count($pp[$i eq .]))
:)

let $res-places := doc('../resources/places.xml')//place
let $places := //place[@href]
let $pp := (
for $x in $places
for $y in $res-places
where $x/@href = $y/@id
return $y
)
let $ppp := distinct-values($pp)
for $z in $ppp
