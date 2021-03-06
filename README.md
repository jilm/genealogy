# genealogy
Some XML tools for genealogy records processing.

## Motivation

The purpose of this set of XML stylesheets is to compile the information about my ancestors into one book.
The book is comprised of the following parts:

* A text, memories and narration of living people. The text may contain the facts obout people like
  the date of birth, death or wedding, their name, relationship between people, and so on.

* A graph tree, which clearly represents relationship between people.

* Photos

* Detailed facts about ancestors, together with citations of the sources

* Index

* Another type of visualization, like geographical or time context.

## Structure

I started to create theese stylesheets when realized, that the amount of information is bigger than I am able
to maintain by hand. So I divided the information as follows:

1) There is a list of all of the person together with the basic information about the birth, death, wedding,
   and relationship. This list is in form of XML files.

2) There is a text of the book. The text is in form of XML file as well.

3) The set of XSL stylesheets and XQueries which compile these sources into one book.

## Person information

The information about a person looks like this:

```xml
<person sex="male | female" id="unique identifier">
  <name>
    <first>given name</first>
    <second>family name</second>
  </name>
</person>
```

## Processing

First of all, the person list, birth list, death list and wedding list are generated by the
makePersonList.xsl, makeBirthList.xsl, makeDeathList.xsl and makeWeddingList.xsl stylesheets.
