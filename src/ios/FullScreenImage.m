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

- (void) showImageBase64:(CDVInvokedUrlCommand*)command{

    NSString *fullPath = [[command.arguments objectAtIndex:0] valueForKey:@"base64"];
    
    NSString *imageName = [[command.arguments objectAtIndex:0] valueForKey:@"name"];
    
    
    NSURL *url = [NSURL URLWithString:fullPath];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    UIImage *ret = [UIImage imageWithData:imageData];
    
    
    NSData *imageDataSaved=UIImagePNGRepresentation(ret);
    
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    NSString *completeImageName = [NSString stringWithFormat:@"%@.%@",imageName,[self contentTypeForImageData:imageDataSaved]];
    NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:completeImageName]];
    [imageDataSaved writeToFile:databasePath atomically:YES];
    
    NSURL *imageURL=[NSURL fileURLWithPath:databasePath];
    
    if (imageURL) {
        UIDocumentInteractionController *documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:imageURL];
        documentInteractionController.delegate = self;
        BOOL menuOpenened = [documentInteractionController presentPreviewAnimated:YES];
        if (!menuOpenened)
            NSLog(@"Failed to open document in Document Directory");
    }
    
}

- (UIViewController *) documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *) controller {
    return self.viewController;
}

- (NSString *)contentTypeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    
    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
    }
    return nil;
}



@end

