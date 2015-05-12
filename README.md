Full Screen Image Plugin Cordova iOS/Android
=================================

Plugin to show images from cordova project and use it with native components. 

Installation:
--------------

`cordova plugin add https://github.com/keensoft/FullScreenImage-Cordova-Plugin.git`

OR from http://plugins.cordova.io/ 

`cordova plugin add es.keensoft.fullscreenimage`

Usage:
--------------

Usage with your javascript code (Images should be inside www/**pathOfImage**):
`FullScreenImage.showImageURL(imageSrc);`

Usage with base64 image String code:
`FullScreenImage.showImageBase64(base64String, name, type);`

Platforms:
--------------
* iOS ( >= iOS 6)
Full Screen Image Plugin, open **UIDocumentInteractionController** to show image.  

* Android
Full Screen Image Plugin, use Intent to open it with external Imageviewer. This plugins checks Application *can use getExternalStorageDirectory*

Example App
--------------
You can test the plugin fast and easy. Go to "example/" path and execute [ionic][4] project. Get started with ionic [here][5]

First execute: "ionic platform add ios" and then you can open iOS project.

Added Simple Photo Gallery using IonicFramework, loading array of Base64 images or local URL's.

Uninstall
--------------

`cordova plugin remove FullScreenImage`

Tested devices
--------------
iPad2 (iOS 7), iPhone 4S (iOS 7), iPhone 5 (iOS 7), Galaxy Note II (4.3)

Info
--------------
![enter image description here][1]

Contact: [info@keensoft.es][2]

Web: [http://keensoft.es][3]


[1]: http://www.keensoft.es/wp-content/uploads/2013/04/keensoft-logo1.png
[2]: info@keensoft.es
[3]: http://keensoft.es
[4]: http://ionicframework.com/
[5]: http://ionicframework.com/getting-started/