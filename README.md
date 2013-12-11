# iOS Keyboard Plugin

This plugin allows you to have more control over the behavior and appearance of the iOS keyboard. Other code I have found
has attempted to do similar things (such as the official PhoneGap plugins), but was buggy on iOS7, or didn't quite
satisfy different scenarios, such as position:fixed/absolute designs. Some also required that you add
height: device-height to the viewport, which causes issues with universal iPad apps.

Some of the things you can do :

- Have the keyboard overlay your app without pushing it up (and animate in smoothly)
- See if the keyboard is open or not
- Get the height of the keyboard (to accommodate different languages, etc)

# Installation

Assuming you're running Cordova 2.9+ and using the command line interface, you can install using:

    $ cd /path/to/project
    $ cordova plugin add https://github.com/mhweiner/awesome-ios-keyboard
    
# Usage / API

The plugin creates a global variable called `Keyboard` when it is installed.

```js
// Have the keyboard overlay the app
Keyboard.overlayApp(true);

// Have the keyboard push up the app (or other default behavior)
Keyboard.overlayApp(false);

// See if keyboard is open or not
var is_open = Keyboard.isOpen();

// Get height of open keyboard (including inputAccessoryView toolbar, if visible)
var height = Keyboard.getHeight();

// Set a callback for when the keyboard opens (only supports one at the moment)
Keyboard.onOpen(myCallbackFunction);

// Set a callback for when the keyboard closes  (only supports one at the moment)
Keyboard.onClose(myCallbackFunction);
```

Please note that if the keyboard is overlaying your app, it's up to you to make sure your fields aren't hidden.

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

