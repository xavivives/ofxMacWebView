#include "ofxMacWebView.h"
#include "ofMain.h"
#include "ofEvents.h"



ofxMacWebView::ofxMacWebView(): webView(NULL)
{
    
}

ofxMacWebView::~ofxMacWebView() {
    cleanup();
}

ofxMacWebView::ofxMacWebView(const ofxMacWebView& other) {
    this->webView = other.webView;
    this->window = other.window;
}

