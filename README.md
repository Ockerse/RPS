Overview
=======
The following tutorial will be using Apple's Gamekit framework using Swift 5. With Gamekit we can create applications that allow us to interact with other iOS users through Game Centers own network. Some of the many examples you can implement to your own application are: achievements, leaderboards, and challenges. Through Game Center you are also able to add real time multiplayer or turn base multiplayer. 

![Image](doc/menu_screen.png "Main Menu" = 10 x 10)

![Image](doc/achievements_screen.png "Achievement Screen")

![Image](doc/leaderboards_screen.png "Leaderboard Screen")

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

![Image](doc/appstoreGC.png "App Store Game Center")

From here you can manage all of your achievements and leaderboards. When you make a new leaderboard or achievement keep in mind that the identifier you choose cannot be changed later. You will use this identifier in your code to save players progress and data to the leaderboard or achievement that corresponds to the identifier.

You are now ready to start implementing Game Center in your code.

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
