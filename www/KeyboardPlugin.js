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

/**
 * Called by Obj-C code
 * @param height
 */
function keyboardWillShow(height){
    keyboard_height = height;
    var elem = document.getElementByTagName('body');
    var event = new Event('keyboardWillShow');
    elem.dispatchEvent(event);
}

/**
 * Called by Obj-C code
 */
function keyboardWillHide(){
    $('body').trigger('keyboardWillHide');
    var elem = document.getElementByTagName('body');
    var event = new Event('keyboardWillHide');
    elem.dispatchEvent(event);
}

/**
 * Called by Obj-C code
 */
function keyboardDidShow(){
    is_open = true;
    var elem = document.getElementByTagName('body');
    var event = new Event('keyboardDidShow');
    elem.dispatchEvent(event);
}

/**
 * Called by Obj-C code
 */
function keyboardDidHide(){
    is_open = false;
    var elem = document.getElementByTagName('body');
    var event = new Event('keyboardDidHide');
    elem.dispatchEvent(event);
}

function isOpen(){
    return is_open;
}

function getHeight(){
    return keyboard_height;
}

module.exports = {
    keyboardWillShow: keyboardWillShow,
    keyboardWillHide: keyboardWillHide,
    keyboardDidShow: keyboardDidShow,
    keyboardDidHide: keyboardDidHide,
    isOpen: isOpen,
    getHeight: getHeight
};