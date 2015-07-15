#include "ofxMacWebView.h"
#include "ofAppGLFWWindow.h"

#import <Cocoa/Cocoa.h>
#import <CoreGraphics/CoreGraphics.h>
#import <AVFoundation/AVFoundation.h>

#pragma mark Webkit

void ofxMacWebView::setup() {

    window = (NSWindow *)ofGetCocoaWindow();
    NSRect f;
    f = (NSRect){[window.contentView bounds].origin.x, [window.contentView bounds].origin.y, [window.contentView bounds].size.width, [window.contentView bounds].size.height};
    
    webView = [[WebViewController alloc] initWithFrame:f];
    [webView init];

    [webView setDrawsBackground:YES];
    [webView setWantsLayer:YES];
    [webView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    [webView setCanDrawConcurrently:YES];
    
    [webView setUIDelegate:webView];
    [webView setEditingDelegate:webView];
    
  //  [webView setHostWindow:window];
    [window.contentView addSubview:webView];

    
    //[window makeFirstResponder: window.contentView];
    
    [NSEvent addLocalMonitorForEventsMatchingMask:NSKeyDownMask handler:^ NSEvent * (NSEvent * event)
    {
        //[window makeFirstResponder: window.contentView];
        //[window makeFirstResponder: webView];
     return event;
     }];
}

void ofxMacWebView::load(string url) {
    NSURL * nsUrl = [NSURL URLWithString:[NSString stringWithUTF8String:url.c_str()]];
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:nsUrl];
    [[webView mainFrame] loadRequest:urlRequest];
}

void ofxMacWebView::showBackground(bool show) {
    [webView setDrawsBackground:show];
}

void ofxMacWebView::show(bool show)
{
    NSRect f;
    if(show)
    {
        [webView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
        f = (NSRect){[window.contentView bounds].origin.x, [window.contentView bounds].origin.y, [window.contentView bounds].size.width, [window.contentView bounds].size.height};
        [webView setFrame:f];
    }
    else
    {
        [webView setAutoresizingMask:NO];
        f = (NSRect){0, 0, 0, 0};
        [webView setFrame:f];
    }
    
}

void ofxMacWebView::cleanup() {
    [webView removeFromSuperview];
    [webView release];
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