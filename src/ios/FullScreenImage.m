//
//  FullScreenImage.m
//  Copyright (c) 2014 keensoft - http://keensoft.es
//

#import "FullScreenImage.h"
#import <MobileCoreServices/MobileCoreServices.h>



@implementation FullScreenImage


- (void) showImageURL:(CDVInvokedUrlCommand*)command{

    NSString *fullPath = [[command.arguments objectAtIndex:0] valueForKey:@"url"];
    NSString *soundFilePath = [NSString stringWithFormat:@"%@/www/%@",[[NSBundle mainBundle] resourcePath],fullPath];
    NSURL *URL = [NSURL fileURLWithPath:soundFilePath];

    if (URL) {
        UIDocumentInteractionController *documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
        documentInteractionController.delegate = self;
        BOOL menuOpenened = [documentInteractionController presentPreviewAnimated:YES];
        if (!menuOpenened)
            NSLog(@"Failed to open document in Document Directory");
    }
    
}


- (UIViewController *) documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *) controller {
    return self.viewController;
}


@end

