
for $i in //interval[max and min]
    let $diff := $i/max - $i/min
    let $event := $i/../..
    let $person := $event/..
    let $name := concat($person/name/first/text(), ' ', $person/name/second/text())
    order by $diff
    return concat(local-name($event), ' of ', $name)