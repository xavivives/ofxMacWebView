#include "ofxMacWebView.h"
#include "ofMain.h"
#include "ofEvents.h"



ofxMacWebView::ofxMacWebView()
: webView(NULL)
, _sharedVideoGrabber(ofPtr<ofVideoGrabber>())
, _didInitFirstSlide(false)
, _allowKeyCapture(true)
, _eventsEnabled(true)
, _listeningToEvents(false) {
    
}

ofxMacWebView::~ofxMacWebView() {
    cleanupWebkit();
    
    if(_listeningToEvents) {
        setEventsEnabled(false);
    }
}

ofxMacWebView::ofxMacWebView(const ofxMacWebView& other) {
    this->slideIndex = other.slideIndex;
    this->webView = other.webView;
    this->window = other.window;
    this->_didInitFirstSlide = other._didInitFirstSlide;
    this->_sharedVideoGrabber = other._sharedVideoGrabber;
}

void ofxMacWebView::updateSlide(ofEventArgs &e) {
 //   getCurrentSlide()->update();
}

void ofxMacWebView::drawSlide(ofEventArgs &e) {
   // getCurrentSlide()->draw();
}

void ofxMacWebView::resizeSlide(ofResizeEventArgs &e) {
   // getCurrentSlide()->windowResized(e.width, e.height);
}

void ofxMacWebView::setEventsEnabled(bool enabled) {
    _eventsEnabled = enabled;
    
    if(_eventsEnabled && !_listeningToEvents) {
        ofAddListener(ofEvents().update, this, &ofxMacWebView::updateSlide, OF_EVENT_ORDER_BEFORE_APP);
        ofAddListener(ofEvents().draw, this, &ofxMacWebView::drawSlide, OF_EVENT_ORDER_BEFORE_APP);
        ofAddListener(ofEvents().windowResized, this, &ofxMacWebView::resizeSlide, OF_EVENT_ORDER_BEFORE_APP);
        _listeningToEvents = true;
    } else if(!_eventsEnabled && _listeningToEvents) {
        ofRemoveListener(ofEvents().update, this, &ofxMacWebView::updateSlide);
        ofRemoveListener(ofEvents().draw, this, &ofxMacWebView::drawSlide);
        ofAddListener(ofEvents().windowResized, this, &ofxMacWebView::resizeSlide, OF_EVENT_ORDER_BEFORE_APP);
        _listeningToEvents = false;
    }
}

