#pragma once

#include "ofBaseApp.h"
#include "ofVideoGrabber.h"

#include <vector>
#include <string>

//#import <CoreServices/CoreServices.h>

#ifdef __OBJC__
#import <WebKit/WebKit.h>
#import "WebViewController.h"
#endif

class ofxMacWebView : public ofBaseApp {
    
public:
    
    ofxMacWebView();
    virtual ~ofxMacWebView();
    ofxMacWebView( const ofxMacWebView& other );
    
    void load(string url);

    void clearHTML();
    void refreshHTML();

    void setup();
    void cleanup();
    
    void setWebViewKeyFocus(bool focus);
    
private:
    
#ifdef __OBJC__
    WebViewController * webView;
    NSWindow * window;
#else
    void * webView;
    void * window;
#endif
    
    bool eventStreamRunning;
    FSEventStreamRef eventStream;

    void setWebViewFrame(ofRectangle frame);
};