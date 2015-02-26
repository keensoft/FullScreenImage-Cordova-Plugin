//
//  FullScreenImage.h
//  Copyright (c) 2014 keensoft - http://keensoft.es
//

#import <Cordova/CDVPlugin.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FullScreenImage : CDVPlugin <UIDocumentInteractionControllerDelegate>

@property (nonatomic, strong) UIDocumentInteractionController *docInteractionController;
@property (nonatomic, strong) NSMutableArray *documentURLs;

- (void) showImageURL:(CDVInvokedUrlCommand*)command;
- (void) showImageBase64:(CDVInvokedUrlCommand*)command;
@end
