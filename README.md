# DeliciousTagsプラグイン

del.icio.usに登録している自分のタグを読み込んで表示するだけのMovable Typeプラグイン。

## 概要

このプラグインは、del.icio.usのタグをdel.icio.us API経由で読み込んで表示するプラグインです。del.icio.usで表示されているようなtag cloudsを自分のブログにも貼り付けたいときなどに利用できます。

このプラグインを動作させるには、[Net::Deliciousモジュール](http://search.cpan.org/~ascope/Net-Delicious/)がインストールされている必要があります。

## 追加されるタグ

### MTDeliciousTags

del.icio.usタグをリストするコンテナタグ。以下のオプションを指定できます:

 * user="..."
 * pass="..."
 * sort_by="tag|count"
 * sort_order="ascend|descend
 * lastn="N"

userオプションとpassオプションはdel.icio.usのユーザー名とパスワードを指定するもので、必須のオプションです。sort_by, sort_orderオプションはタグリストの表示順をコントロールします。lastnオプションを指定すると表示するタグを最初のN件だけに限定します(じゃあfirstnではないかと…「慣例」です)。

### MTDeliciousTag

del.icio.usタグを生成する変数タグ。

### MTDeliciousTagURL

そのタグに対応するdel.icio.usのページへのURL(e.g., http://del.icio.us/user/tag)を生成する変数タグ。

### MTDeliciousTagCount

そのタグがdel.icio.usで何件使用されているかを表す数値を生成する変数タグ。

### MTDeliciousTagsHeader

最初のdel.icio.usタグの前だけに表示されるコンテナタグ。

### MTDeliciousTagsFooter

最後のdel.icio.usタグの後だけに表示されるコンテナタグ。

## 利用例

    <MTDeliciousTags user="del.icio.us.username" pass="del.icio.us.password">
    <MTDeliciousTagsHeader><ol></MTDeliciousTagsHeader>
      <li><a href="<$MTDeliciousTagURL$>"><$MTDeliciousTag$></a>
        (<$MTDeliciousTagCount$>)</li>
    <MTDeliciousTagsFooter></ol></MTDeliciousTagsFooter>
    </MTDeliciousTags>

## See Also

## License

This code is released under the Artistic License. The terms of the Artistic License are described at [http://www.perl.com/language/misc/Artistic.html]().

## Author & Copyright

Copyright (c) 2005 Hirotaka Ogawa (hirotaka.ogawa at gmail.com)
