
//
//  fullscreenimage.js
//
//  Copyright (c) 2014 keensoft - http://keensoft.es
//

var exec = require("cordova/exec");

var FullScreenImage = function () {
  this.name = "FullScreenImage";
};

/*
 * Show image from url
 *
 * Parameters:
 * url: url to show
 *
 */

FullScreenImage.prototype.showImageURL = function (url) {

  exec(null, null, "FullScreenImage", "showImageURL", [{"url":url}]);


};

/*
 * Show image from base64
 *
 * Parameters:
 * base64String: base64String
 * name: filename to show
 * type: image type
 *
 */

FullScreenImage.prototype.showImageBase64 = function (base64String, name, type) {

  exec(null, null, "FullScreenImage", "showImageBase64", [{"base64":base64String, "name":name, "type":type}]);


};

module.exports = new FullScreenImage();
