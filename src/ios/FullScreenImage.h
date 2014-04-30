//
//  FullScreenImage.h
//  Copyright (c) 2014 keensoft - http://keensoft.es
//

#import <Cordova/CDVPlugin.h>
#import <Foundation/Foundation.h>

@interface FullScreenImage : CDVPlugin <UIDocumentInteractionControllerDelegate>

- (void) showImageURL:(CDVInvokedUrlCommand*)command;

@end
