

declare namespace svg="http://www.w3.org/2000/svg";
declare namespace math="http://www.w3.org/2005/xpath-functions/math";

declare variable $width as xs:decimal := 482.5;
declare variable $height as xs:decimal := 278;
declare variable $north as xs:decimal := 51.0555556;
declare variable $south as xs:decimal := 48.5525;
declare variable $west  as xs:decimal :=  12.0913889;
declare variable $east as xs:decimal :=  18.8588889;

<svg:svg width="{$width}" height="{$height}" viewbox="0 0 {$width} {$height}">
<svg:rect x="0" y="0" width="{$width}" height="{$height}" style="fill:none;stroke:blue;" />
{

for $place in doc("../resources/places.xml")//place
    let $c := count(//place[parish = $place/parish and district = $place/district])
    where $c gt 0
    let $coord := $place/coordinates
    let $x := ($coord/lon/text() - $west) * $width div ($east - $west)
    let $y := ($coord/lat/text() - $north) * $height div ($south - $north)
    let $r := math:sqrt($c div math:pi()) * 2.0
return <svg:circle cx="{$x}" cy="{$y}" r="{$r}" />

}</svg:svg>