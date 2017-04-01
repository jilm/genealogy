(:

    Create the source for latex index.

    Input: personList.xml

    Output: People index for latex

:)

let $persons := //person
for $x in $persons
  let $namex := concat($x/name/second/text(), '!', $x/name/first/text())
  let $birth := $x/birth/date/text()
  let $year := head(reverse(tokenize($birth, '\.')))
  let $dup := (
  for $y in $persons
    let $namey := concat($y/name/second/text(), '!', $y/name/first/text())
    let $marriednamey := concat($y/name/married/text(), '!', $y/name/first/text())
    where $x != $y and ($namex = $namey or $namex = $marriednamey)
    return $y)
  return 
  concat('\newcommand{\', $x/@id, '}{\index{', 
  if (not(empty($dup))) 
    then concat($namex, '!', $year) 
      else $namex , 
  '}}' ) 
