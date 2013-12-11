/**
 * CordovaiOSKeyboardPlugin
 * ======================================================
 * Apache Cordova Plugin for iOS
 * Written by Marc Weiner (mhweiner234@gmail.com)
 * https://github.com/mhweiner/CordovaiOSKeyboardPlugin
 * License: MIT
 */


'use strict';

var exec = cordova.require('cordova/exec');

var success = function () {
    // do nothing, succeed quietly
};

var callbacks = {
    keyboardWillShow: null,
    keyboardWillHide: null,
    keyboardDidShow: null,
    keyboardDidHide: null
};

var is_open, keyboard_height;

function setup() {

    var fail = function (error) {
        console.log("Error setting up KeyboardPlugin: " + error);
    };

    exec(success, fail, "KeyboardPlugin", "setup", []);
}

function resizeApp(bool) {

    if(bool === 'undefined' || bool === null){
        bool = true;
    }

    var fail = function (error) {
        console.log("Error: " + error);
    };

    exec(success, fail, "KeyboardPlugin", "resizeApp", [bool]);
}

/**
 * Set callback for UIKeyboardWillShowNotification
 * @param fn
 */
function onKeyboardWillShow(fn){
    callbacks.keyboardWillShow = fn;
}

/**
 * Set callback for UIKeyboardWillHideNotification
 * @param fn
 */
function onKeyboardWillHide(fn){
    callbacks.keyboardWillHide = fn;
}

/**
 * Set callback for UIKeyboardDidShowNotification
 * @param fn
 */
function onKeyboardDidShow(fn){
    callbacks.keyboardDidShow = fn;
}

/**
 * Set callback for UIKeyboardDidHideNotification
 * @param fn
 */
function onKeyboardDidHide(fn){
    callbacks.keyboardDidHide = fn;
}

/**
 * Called by Obj-C code
 * @param height
 */
function keyboardWillShow(height){
    keyboard_height = height;
    if(typeof callbacks.keyboardWillShow == 'function') callbacks.keyboardWillShow();
}

/**
 * Called by Obj-C code
 */
function keyboardWillHide(){
    if(typeof callbacks.keyboardWillHide == 'function') callbacks.keyboardWillHide();
}

/**
 * Called by Obj-C code
 */
function keyboardDidShow(){
    is_open = true;
    if(typeof callbacks.keyboardDidShow == 'function') callbacks.keyboardDidShow();
}

/**
 * Called by Obj-C code
 */
function keyboardDidHide(){
    is_open = false;
    if(typeof callbacks.keyboardDidHide == 'function') callbacks.keyboardDidHide();
}

function isOpen(){
    return is_open;
}

function getHeight(){
    return keyboard_height;
}

module.exports = {
    setup: setup,
    resizeApp: resizeApp,
    onKeyboardWillShow: onKeyboardWillShow,
    onKeyboardWillHide: onKeyboardWillHide,
    onKeyboardDidShow: onKeyboardDidShow,
    onKeyboardDidHide: onKeyboardDidHide,
    keyboardWillShow: keyboardWillShow,
    keyboardWillHide: keyboardWillHide,
    keyboardDidShow: keyboardDidShow,
    keyboardDidHide: keyboardDidHide,
    isOpen: isOpen,
    getHeight: getHeight
};