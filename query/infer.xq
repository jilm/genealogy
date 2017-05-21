declare namespace jilm="http://www.lidinsky.cz";
declare namespace saxon="http://saxon.sf.net/";
declare option saxon:output "indent=yes";

declare variable $person-list := doc("../build/personList.xml");
declare variable $birth-list := doc("../build/birthList.xml");
declare variable $death-list := doc("../build/deathList.xml");
declare variable $wedding-list := doc("../build/weddingList.xml");
declare variable $MIN-WEDDING-AGE := 17;
declare variable $MAX-AGE := 100;

declare function jilm:get($ref as xs:string*) {
    for $i in $ref
        for $p in $person-list
            where $p/@id = $i
                return ($p, jilm:get($p/father/@href), jilm:get($p/mather/@href))
};

<list>{
for $i in $person-list//person

    let $pid := $i/@id/data()
    let $sex := $i/@sex/data()
    let $name := $i/name
    let $birth := $birth-list//birth[born/@href = $pid]
    let $death := $death-list//death[died/@href = $pid]
    let $wedding := $wedding-list//wedding[bride/@href = $pid or bridegroom/@href = $pid]
    
    let $birth-year := xs:integer($birth[1]/date/year/text())
    let $wedding-year := xs:integer($wedding[1]/date/year/text())
    let $death-year := number($death[1]/date/year/text())

    let $children-birth := $birth-list//birth[father/@href = $pid or mather/@href = $pid]
    let $children-birth-year := $children-birth/date/year/text()
    let $children-birth-min-year := min($children-birth-year)
    let $children-birth-max-year := max($children-birth-year)

    let $couple-ids := distinct-values(($pid, $wedding/bride/@href/data(), $wedding/bridegroom/@href/data(), $children-birth/father/@href/data(), $children-birth/mather/@href/data()))
    let $couple-birth-years := (
        for $y in $couple-ids
            return $birth-list//birth[born/@href = $y]/date/year/text()
    )
    let $couple-min-birth-year := min($couple-birth-years)
    let $couple-max-birth-year := max($couple-birth-years)
    let $couple-death-years := (
        for $y in $couple-ids
            return xs:integer($death-list//death[died/@href = $y]/date/year/text())
    )
    let $couple-min-death-year := min($couple-death-years)
    let $couple-max-death-year := max($couple-death-years)

    let $parent-birth-years := $birth-list//birth[born/@href = $birth/father/@href or born/@href = $birth/mather/@href]/date/year/text()
    let $parent-wedding-years := $wedding-list//wedding[bride/@href = $birth/mather/@href or bridegroom/@href = $birth/father/@href]/date/year/text()
    let $parent-death-years := $death-list//death[died/@href = $birth/father/@href or died/@href = $birth/mather/@href]/date/year/text()
    
    (:-------------------------------------------------------------- WEDDING :)

    let $min-wedding-date := $couple-max-birth-year + $MIN-WEDDING-AGE
    let $max-wedding-date := min(($couple-min-death-year, $children-birth-min-year))

    let $wrapped-min-wedding-date := if (exists($min-wedding-date)) then (
        <min><year>{$min-wedding-date}</year></min>
    ) else ()
    let $wrapped-max-wedding-date := if (exists($max-wedding-date)) then (
        <max><year>{$max-wedding-date}</year></max>
    ) else ()
    let $wedding-date := if (exists($wedding/date)) then (
        <date>{$wedding/date/*}</date>
    ) else if (exists($min-wedding-date or $max-wedding-date)) then (
        <date><interval>{
            $wrapped-min-wedding-date, $wrapped-max-wedding-date
        }</interval></date>
    ) else ()

    (:---------------------------------------------------------------- DEATH :)

    let $max-death-date := $birth-year + $MAX-AGE
    let $min-death-date := $children-birth-max-year

    let $wrapped-min-death-date := if (exists($min-death-date)) then (
        <min><year>{$min-death-date}</year></min>
    ) else ()
    let $wrapped-max-death-date := if (exists($max-death-date)) then (
        <max><year>{$max-death-date}</year></max>
    ) else ()
    let $death-date := if (exists($death/date)) then (
        <date>{$death/date/*}</date>
    ) else if (exists($min-death-date or $max-death-date)) then (
        <date><interval>{
            $wrapped-min-death-date, $wrapped-max-death-date
        }</interval></date>
    ) else ()

    (:---------------------------------------------------------------- BIRTH :)

    let $max-birth-date := min(($wedding-year - $MIN-WEDDING-AGE, $children-birth-min-year - $MIN-WEDDING-AGE, $parent-death-years))
    let $min-birth-date := max(($death-year - $MAX-AGE, $parent-wedding-years))

    let $wrapped-min-birth-date := if (exists($min-birth-date)) then (
        <min><year>{$min-birth-date}</year></min>
    ) else ()
    let $wrapped-max-birth-date := if (exists($max-birth-date)) then (
        <max><year>{$max-birth-date}</year></max>
    ) else ()
    let $birth-date := if (exists($birth/date)) then (
        <date>{$birth/date/*}</date>
    ) else if (exists($min-birth-date or $max-birth-date)) then (
        <date><interval>{
            $wrapped-min-birth-date, $wrapped-max-birth-date
        }</interval></date>
    ) else ()

    return <person id="{$pid}" sex="{$sex}">
        {$name},
        <wedding>{$wedding-date}</wedding>,
        <death>{$death-date}</death>,
        <birth>{$birth-date}</birth>
    </person>
}</list>