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
    
    
    void updateSlide(ofEventArgs & e);
    void drawSlide(ofEventArgs & e);
    void resizeSlide(ofResizeEventArgs & e);
    
    void goToUrl(string url);
    
    void setEventsEnabled(bool enabled); // true by default
    void setAutorefreshEnabled(bool enabled); // false by default

    void clearHTML();
    void refreshHTML();

    void setupWebkit();
    void cleanupWebkit();
    
    void setWebViewKeyFocus(bool focus);
    
protected:

    size_t slideIndex;
    
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
    
    void setWebViewPageName(const std::string &pageName);
    void setWebViewHidden(bool hidden);
    void setWebViewFrame(ofRectangle frame);

    
    void setVideoPlayerVideoName(const std::string &videoName);
    void setVideoPlayerHidden(bool hidden);
    
    ofPtr<ofVideoGrabber> _sharedVideoGrabber;
    bool _didInitFirstSlide;
    bool _allowKeyCapture;
    bool _eventsEnabled;
    bool _listeningToEvents;
};