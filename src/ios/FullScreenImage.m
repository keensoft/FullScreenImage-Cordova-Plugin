//
//  FullScreenImage.m
//  Copyright (c) 2014 keensoft - http://keensoft.es
//

#import "FullScreenImage.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "NSData+Base64.h"


@implementation FullScreenImage


- (void)setupDocumentControllerWithURL:(NSURL *)url
{
    //checks if docInteractionController has been initialized with the URL
    if (self.docInteractionController == nil)
    {
        self.docInteractionController = [UIDocumentInteractionController interactionControllerWithURL:url];
        self.docInteractionController.delegate = self;
    }
    else
    {
        self.docInteractionController.URL = url;
    }
}


- (void) showImageURL:(CDVInvokedUrlCommand*)command{
    // Check command.arguments here.
    [self.commandDelegate runInBackground:^{
        self.documentURLs = [NSMutableArray array];
        
        
        NSString *fullPath = [[command.arguments objectAtIndex:0] valueForKey:@"url"];
        
        NSString *soundFilePath = [NSString stringWithFormat:@"%@/www/%@",[[NSBundle mainBundle] resourcePath],fullPath];
        NSURL *URL = [NSURL fileURLWithPath:soundFilePath];
        
        if (URL) {
            
            [self.documentURLs addObject:URL];
            [self setupDocumentControllerWithURL:URL];
            double delayInSeconds = 0.1;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self.docInteractionController presentPreviewAnimated:YES];
            });
            
            
            
        }
    }];
}

- (void) showImageBase64:(CDVInvokedUrlCommand*)command{
    
    [self.commandDelegate runInBackground:^{
        NSString *fullPath = [[command.arguments objectAtIndex:0] valueForKey:@"base64"];
        
        NSString *imageName = [[command.arguments objectAtIndex:0] valueForKey:@"name"];
        
        NSString *imageType = [[command.arguments objectAtIndex:0] valueForKey:@"type"];
        
        if([imageName isKindOfClass:[NSNull class]] || [imageName isEqualToString:@""]){
            imageName = @"default";
        }
        
        if([imageType isKindOfClass:[NSNull class]] || [imageType isEqualToString:@""]){

            NSData *imageDatatest = [NSData dataFromBase64String:fullPath];
            imageType = [self contentTypeForImageData:imageDatatest];
        }

        //    Problem with large base64 strings
        //    https://github.com/keensoft/FullScreenImage-Cordova-Plugin/issues/22
        NSData *imageData = [NSData dataFromBase64String:fullPath];
        UIImage *ret = [UIImage imageWithData:imageData];
        
        
        NSData *imageDataSaved=UIImagePNGRepresentation(ret);
        
        
        NSString *docsDir;
        NSArray *dirPaths;
        
        
        dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        docsDir = [dirPaths objectAtIndex:0];
        NSString *completeImageName = [NSString stringWithFormat:@"%@.%@",imageName,imageType];
        NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:completeImageName]];
        [imageDataSaved writeToFile:databasePath atomically:YES];
        
        NSURL *imageURL=[NSURL fileURLWithPath:databasePath];
        
        if (imageURL) {
            [self.documentURLs addObject:imageURL];
            [self setupDocumentControllerWithURL:imageURL];
            double delayInSeconds = 0.1;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self.docInteractionController presentPreviewAnimated:YES];
            });
        }
    }];
}

- (UIDocumentInteractionController *) setupControllerWithURL: (NSURL*) fileURL
                                               usingDelegate: (id <UIDocumentInteractionControllerDelegate>) interactionDelegate {
    
    UIDocumentInteractionController *interactionController =
    [UIDocumentInteractionController interactionControllerWithURL: fileURL];
    interactionController.delegate = interactionDelegate;
    
    return interactionController;
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

