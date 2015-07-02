
#include "ofMain.h"
#import <WebKit/WebKit.h>
#import <Cocoa/Cocoa.h>


@interface WebViewController : WebView <NSDraggingDestination>
{
   @private
   // NSTimer *timer;//?
   // unsigned long frameCounter;//?
    
}

- (void) init2;

/*- (void) setFrameRate: (float) fr;
- (void) startTimer;
- (void) eraseTimer;

- (int) getFrameNum;
- (float) getFrameRate;
- (float) getRealFrameRate;
*/

@end