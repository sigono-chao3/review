#import <StoreKit/StoreKit.h>

@interface AlertViewController : NSObject <UIAlertViewDelegate>
+(AlertViewController*) sharedInstance;
-(void) show:(NSString *) title
        message:(NSString *) message
        cancelButtonTitle:(NSString *) cancelButtonTitle
        otherButtonTitle:(NSString *) otherButtonTitle;
-(NSInteger) getLastResult;
@end

extern "C" {
    void requestReview()
    {
        [SKStoreReviewController requestReview];
    }

    bool isSKStoreReviewControllerAvailable()
    {
        if ([SKStoreReviewController class])
        {
            return true;
        }
    
        return false;
    }
    
    void showAlert(const char* title,
                   const char* message,
                   const char* cancelButtonText,
                   const char* otherButtonText){

        NSString *nsTitle= [NSString stringWithUTF8String:title];
        NSString *nsMessage= [NSString stringWithUTF8String:message];
        NSString *nsCancelButton= [NSString stringWithUTF8String:cancelButtonText];
        NSString *nsOtherButton= [NSString stringWithUTF8String:otherButtonText];
        
        [[AlertViewController sharedInstance] show: nsTitle
                                              message: nsMessage
                                              cancelButtonTitle: nsCancelButton
                                              otherButtonTitle: nsOtherButton];

    }

    int getLastAlertResult(){
      return [[AlertViewController sharedInstance] getLastResult];
    }
}


static AlertViewController *_instance;

@implementation AlertViewController{
    NSInteger lastResult;
}
-(id) init {
    self = [super init];
    return self;
}

+(AlertViewController*) sharedInstance {
    if(_instance == nil) {
        _instance = [[AlertViewController alloc] init];
    }
    
    return _instance;
}

-(void) show:(NSString *)title
             message:(NSString *)message
             cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitle:(NSString *)otherButtonTitle {
    
    NSLog(@"%@", title);
    NSLog(@"%@", message);
    NSLog(@"%@", cancelButtonTitle);
    NSLog(@"%@", otherButtonTitle);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles: otherButtonTitle, nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    lastResult =buttonIndex;
}

-(NSInteger) getLastResult{
  return lastResult;
}
@end

