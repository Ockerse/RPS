Overview
=======
The following tutorial will be using Apple's Gamekit framework using Swift 5. With Gamekit we can create applications that allow us to interact with other iOS users through Game Centers own network.  

Getting started
=======

Set up Game Center in XCode project
----
Go to <b>PROJECT>TARGETS>Signing & Capabilites</b><br />
Click the plus sign next to capabilities to add a new capability. In the prompt that pops up search for Game Center. When complete it should show up like below.


Register your game with App Store Connect
----
To use Game Center's features you have to authenticate the player with Game Center. Before you can do that your game must be registered with Apple. To register head over to [App Store Connect](https://appstoreconnect.apple.com) website (This does require an Apple Developer Account). 


Once your app is registered, select it and go to <b>Features>Game Center</b>
![Image](appstoreGC.png "App Store Game Center")

Step-by-step coding instructions
=======

Conclusions
=======

```ruby
require 'redcarpet'
markdown = Redcarpet.new("Hello World!")
puts markdown.to_html
```

Paragraphs are separated
-----------
by a blank line.


Two spaces at the end of a line  
produces a line break.

Text attributes _italic_, 
**bold**, `monospace`.

Horizontal rule:


---
Strikethrough:
~~strikethrough~~

Bullet list:

  * apples
  * oranges
  * pears

Numbered list:

  1. lather
  2. rinse
  3. repeat

An [example](http://example.com).

![Image](Icon-pictures.png "icon")
test

> Markdown uses email-style > characters for blockquoting.

Inline <abbr title="Hypertext Markup Language">HTML</abbr> is supported.
