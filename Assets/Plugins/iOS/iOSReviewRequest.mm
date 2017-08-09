#import <StoreKit/StoreKit.h>

@interface AlertViewController : NSObject <UIAlertViewDelegate>
+(AlertViewController*) sharedInstance;
-(void) show:(NSString *) title
        message:(NSString *) message
        cancelButtonTitle:(NSString *) cancelButtonTitle
        otherButtonTitle:(NSString *) otherButtonTitle;
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
        
        [[AlertViewController sharedInstance] show: [NSString stringWithUTF8String:title]
                                              message :[NSString stringWithUTF8String:message]
                                              cancelButtonTitle:[NSString stringWithUTF8String:cancelButtonText]
                                              otherButtonTitle:[NSString stringWithUTF8String:otherButtonText]];

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

-(void) show:title:(NSString *)title
             message:(NSString *)message
             cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitle:(NSString *)otherButtonTitle {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles:otherButtonTitle];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    lastResult =buttonIndex;
}

-(NSInteger) getLastResult{
  return lastResult;
}
@end

