ThemeKit

ThemeKit is an easy way to configure applications to have different looks using color and fonts. For example, your app could have a full color theme and a black and white theme. Or have themes based on locale. 

Using ThemeKit is easy. First create a theme file as a .plist. Look at the example, `ThemeKitBuilder`, for the `StandardTheme.plist` and you'll see that it is broken into the following sections, each a Dictionary:

- colors: These are named colors, each a red,green,blue,alpha values. The red, green, and blue values are 0 to 255 and alpha is 0 to 100.
- borders: Each item is itself a Dictionary and has items: color (use one of the named colors), width, and corner radius.
- fonts: Each item is itself a Dictionary and has items: font (the name of a font) and style (usually bold, regular, or italic, but it depends on the font).
- application: This dictionary puts it all together. Each item in this collection is a Dictionary and is named for a class. For example, "`TKPrimaryButton`". The members of these collections are appearance traits such as `backgroundColor` or `tintColor`. The item depends on the class.

In your `AppDelegate`, load the theme file using `ThemeKit.shared.load(themeResource: "StandardTheme")` then `apply` the theme.

While you can use generic classes such as `UIButton` and `UILabel`, it is better to use custom classes. These can be your own or you can use ThemeKit's classes which are lightweight extensions of the UIKit classes. In ThemeKit you will find classes like `TKPrimaryButton`, `TKTitle`, `TKBorderedView`, and so on. Just use these classes in your storyboard and XIB files (don't forget to set their module to ThemeKit).

And that's ThemeKit.
