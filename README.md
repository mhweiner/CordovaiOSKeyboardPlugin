# iOS Keyboard Plugin

This plugin allows you to subscribe to native UIKeyboard events via jQuery.

Some of the things you can do :

- Subscribe to jQuery events for native keyboard event notifications (willShow, didShow, willHide, didHide)
- See if the keyboard is open or not
- Get the height of the keyboard (to accommodate different languages, etc)

# What's changed recently

3/13/14

- I had to remove the ability for the app to prevent the keyboard from pushing up the app. iOS7.1 broke it, and it
was an unmaintainable hack. There is no documented way to change the keyboard behavoir or appearance in a UIWebView,
with a few exceptions. See: https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIWebView_Class/Reference/Reference.html and
and https://developer.apple.com/library/ios/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html.

- Plugin no longer requires jQuery

- Plugin auto-instantiates and should work on all versions of Cordova 2.9+.

# Installation

Assuming you're running Cordova 2.9+ and using the command line interface, you can install using:

    $ cd /path/to/project
    $ cordova plugin add https://github.com/mhweiner/CordovaiOSKeyboardPlugin
    
# Usage / API

The plugin creates a global variable called `Keyboard` when it is installed.

```js

// See if keyboard is open or not
var is_open = Keyboard.isOpen();

// Get height of open keyboard (including inputAccessoryView toolbar)
var height = Keyboard.getHeight();

// The following jQuery events are available:
// keyboardWillShow, keyboardDidShow, keyboardWillHide, keyboardDidHide

// Set callback
$('body').on('keyboardWillShow', myCallback);

// Remove callback
$('body').off('keyboardWillShow');

Note: jQuery is not required. It's just used here as an example.

```

# Troubleshooting & Tips

* Other keyboard plugins could interfere with this plugin. If you're having issues, try disabling them.

* If you're using PhoneGap/Cordova prior to 3.2, you will probably want to comment out the code in the keyboardWillShow
and keyboardWillHide functions. This was moved to the plugin `org.apache.cordova.keyboard` in 3.2.

# License

The MIT License

Copyright (c) 2013 Marc H. Weiner

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

