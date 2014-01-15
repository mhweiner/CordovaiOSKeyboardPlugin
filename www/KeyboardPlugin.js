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

var is_open = false;
var keyboard_height = 0;

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
 * Called by Obj-C code
 * @param height
 */
function keyboardWillShow(height){
    keyboard_height = height;
    $('body').trigger('keyboardWillShow');
}

/**
 * Called by Obj-C code
 */
function keyboardWillHide(){
    $('body').trigger('keyboardWillHide');
}

/**
 * Called by Obj-C code
 */
function keyboardDidShow(){
    is_open = true;
    $('body').trigger('keyboardDidShow');
}

/**
 * Called by Obj-C code
 */
function keyboardDidHide(){
    is_open = false;
    $('body').trigger('keyboardDidHide');
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
    keyboardWillShow: keyboardWillShow,
    keyboardWillHide: keyboardWillHide,
    keyboardDidShow: keyboardDidShow,
    keyboardDidHide: keyboardDidHide,
    isOpen: isOpen,
    getHeight: getHeight
};