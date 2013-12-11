/**
 * iOSKeyboardPlugin
 * ======================================================
 * Apache Cordova Plugin for iOS
 * Written by Marc Weiner (mhweiner234@gmail.com)
 */


'use strict';

var exec = cordova.require('cordova/exec');

var success = function () {
    // do nothing, succeed quietly
};

var open_callback, close_callback, is_open, keyboard_height;

function setup() {

    var fail = function (error) {
        console.log("Error setting up KeyboardPlugin: " + error);
    };

    exec(success, fail, "KeyboardPlugin", "setup", []);
}

function showToolbar(bool) {

    if(bool === 'undefined' || bool === null){
        bool = true;
    }

    var fail = function (error) {
        console.log("Error: " + error);
    };

    exec(success, fail, "KeyboardPlugin", "showToolbar", [bool]);
}

function overlayApp(bool) {

    if(bool === 'undefined' || bool === null){
        bool = true;
    }

    var fail = function (error) {
        console.log("Error: " + error);
    };

    exec(success, fail, "KeyboardPlugin", "overlayApp", [bool]);
}

function onOpen(fn){
    open_callback = fn;
}

function onClose(fn){
    close_callback = fn;
}

/**
 * Called by native code
 * @param height
 */
function nativeKeyboardEventHandler(height){
    if(height){
        keyboard_height = height;
        is_open = true;
        if(typeof open_callback == 'function') open_callback();
    } else {
        is_open = false;
        keyboard_height = 0;
        if(typeof close_callback == 'function') close_callback();
    }
}

function isOpen(){
    return is_open;
}

function getHeight(){
    return keyboard_height;
}

module.exports = {
    setup: setup,
    showToolbar: showToolbar,
    overlayApp: overlayApp,
    onOpen: onOpen,
    onClose: onClose,
    nativeKeyboardEventHandler: nativeKeyboardEventHandler,
    isOpen: isOpen,
    getHeight: getHeight
};