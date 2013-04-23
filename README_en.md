# DeliciousTags Plugin

A simple Movable Type plugin for importing and displaying your del.icio.us tags.

## Overview

This plugin allows you to import and display your del.icio.us tags into your MT blogs. This plugin requires [Net::Delicious module](http://search.cpan.org/~ascope/Net-Delicious/).

## Tags

### MTDeliciousTags

A container tag for your del.icio.us tags. This container takes the following options:

 * user="..."
 * pass="..."
 * sort_by="tag|count"
 * sort_order="ascend|descend
 * lastn="N"

"user" and "pass" options are required. Other options work as like standard Movable Type tags, such as MTEntries.

### MTDeliciousTag

Generates a del.icio.us tag.

### MTDeliciousTagURL

Generates the URL to a del.icio.us (e.g., http://del.icio.us/user/tag).

### MTDeliciousTagCount

Generates the number how many a del.icio.us tag appears in your del.icio.us bookmarks.

### MTDeliciousTagsHeader

A container tag that renders its contents before the first del.icio.us tag.

### MTDeliciousTagsFooter

A container tag that renders its contents after the last del.icio.us tag.

## Example

    <MTDeliciousTags user="del.icio.us.username" pass="del.icio.us.password">
    <MTDeliciousTagsHeader><ol></MTDeliciousTagsHeader>
    <li><a href="<$MTDeliciousTagURL$>"><$MTDeliciousTag$></a> (<$MTDeliciousTagCount$>)</li>
    <MTDeliciousTagsFooter></ol></MTDeliciousTagsFooter>
    </MTDeliciousTags>

## See Also

## License

This code is released under the Artistic License. The terms of the Artistic License are described at [http://www.perl.com/language/misc/Artistic.html](http://www.perl.com/language/misc/Artistic.html).

## Author & Copyright

Copyright (c) 2005 Hirotaka Ogawa (hirotaka.ogawa at gmail.com)
