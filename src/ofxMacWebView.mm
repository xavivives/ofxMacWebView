#include "ofxMacWebView.h"
#include "ofAppGLFWWindow.h"

#import <Cocoa/Cocoa.h>
#import <CoreGraphics/CoreGraphics.h>
#import <AVFoundation/AVFoundation.h>

#pragma mark Webkit

void ofxMacWebView::setupWebkit() {

    window = (NSWindow *)ofGetCocoaWindow();
    NSRect f;
    f = (NSRect){[window.contentView bounds].origin.x, [window.contentView bounds].origin.y, [window.contentView bounds].size.width, [window.contentView bounds].size.height};
    

    
    webView = [[WebViewController alloc] initWithFrame:f];
    [webView init2];

   
    [webView setDrawsBackground:YES];
    [webView setWantsLayer:YES];
    [webView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    [webView setCanDrawConcurrently:YES];
    
    [webView setUIDelegate:webView];
    [webView setEditingDelegate:webView];
    
    [webView setHostWindow:window];
    [window.contentView addSubview:webView];
    
    /*[NSEvent addLocalMonitorForEventsMatchingMask:NSKeyDownMask handler:^ NSEvent * (NSEvent * event) {
     if(!_allowKeyCapture) {
     [window makeFirstResponder:window.contentView];
     }
     return event;
     }];
     */
}


void ofxMacWebView::goToUrl(string url) {
   // NSString * page = [NSString stringWithUTF8String:ofToDataPath("/ui/index").c_str()];
    NSURL * nsUrl = [NSURL URLWithString:[NSString stringWithUTF8String:url.c_str()]];
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:nsUrl];
    [[webView mainFrame] loadRequest:urlRequest];
}

void ofxMacWebView::cleanupWebkit() {
    [webView removeFromSuperview];
    [webView release];
}

void ofxMacWebView::setWebViewHidden(bool hidden) {
    if(hidden != webView.isHidden) {
        [webView.animator setHidden:hidden];
    }
}

void ofxMacWebView::setWebViewPageName(const std::string &pageName) {
    NSString * page = [NSString stringWithUTF8String:ofToDataPath(pageName).c_str()];
    NSURL * url = [[NSBundle mainBundle] URLForResource:page withExtension:@"html"];;
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:url];
    [[webView mainFrame] loadRequest:urlRequest];
}

void ofxMacWebView::setWebViewFrame(ofRectangle frame) {
    NSRect f;
    
    if(frame.isEmpty()) {
        f = (NSRect){[window.contentView bounds].origin.x, [window.contentView bounds].origin.y, [window.contentView bounds].size.width, [window.contentView bounds].size.height};

        //f = [window.contentView bounds];
    } else {
        f = (NSRect){frame.x, frame.y, frame.width, frame.height};
    }
    
    [webView setFrame:f];
}

void ofxMacWebView::setWebViewKeyFocus(bool focus) {
    [window makeFirstResponder:focus ? webView : window.contentView];
}

void ofxMacWebView::clearHTML() {
    [[webView mainFrame] loadHTMLString:@"" baseURL:nil];
}

#pragma mark - Auto Refresh

void ofxMacWebView::refreshHTML() {
    [webView reload:nil];
    //getCurrentSlide()->didRefresh();
}

void SlidesModifiedCallback(ConstFSEventStreamRef streamRef,
                            void * clientCallBackInfo,
                            size_t numEvents,
                            void * eventPaths,
                            const FSEventStreamEventFlags eventFlags[],
                            const FSEventStreamEventId eventIds[])
{
    ((ofxMacWebView *)clientCallBackInfo)->refreshHTML();
}

void ofxMacWebView::setAutorefreshEnabled(bool enable) {
    
    if(enable && !eventStreamRunning) {
        NSArray * paths = @[ [NSString stringWithUTF8String:ofToDataPath("").c_str()] ];
        FSEventStreamContext ctx = { .info = this };
        eventStream = FSEventStreamCreate(NULL, &SlidesModifiedCallback, &ctx, (CFArrayRef)paths, kFSEventStreamEventIdSinceNow, 0.25, kFSEventStreamCreateFlagNone);
        FSEventStreamScheduleWithRunLoop(eventStream, CFRunLoopGetMain(), kCFRunLoopDefaultMode);
        FSEventStreamStart(eventStream);
        eventStreamRunning = true;
    } else if(!enable &&eventStreamRunning) {
        FSEventStreamStop(eventStream);
        FSEventStreamInvalidate(eventStream);
        FSEventStreamRelease(eventStream);
        eventStreamRunning = false;
    }
}

