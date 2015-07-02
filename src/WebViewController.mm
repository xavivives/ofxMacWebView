
#import "WebViewController.h"


@interface WebViewController ()

@end

@implementation WebViewController


-(void) init
{
    [self setUIDelegate:self];
    [self setEditingDelegate:self];
}

- (BOOL)validateMenuItem:(NSMenuItem *)item {
    //disable right click menu
    BOOL shouldEnable = false;
    if ([item action] == @selector(newContextualMenu:) &&
        !shouldEnable) {
        return NO;
    }
    return [super validateMenuItem:item]; // only use if super implements
}

- (NSArray *)WebViewController:(WebView *)sender contextMenuItemsForElement:(NSDictionary *)element
    defaultMenuItems:(NSArray *)defaultMenuItems
{
    cout << "\nRIGHT CLICK";
    // disable right-click context menu
    return nil;
}

- (BOOL)WebViewController:(WebView *)webView shouldChangeSelectedDOMRange:(DOMRange *)currentRange
     toDOMRange:(DOMRange *)proposedRange
       affinity:(NSSelectionAffinity)selectionAffinity
 stillSelecting:(BOOL)flag
{
    cout << "\nDisable selection";
    // disable text selection
    return NO;
}

- (BOOL) acceptsFirstResponder {
    return YES;
}





/*
-(void) initWebView
{
    //[super viewDidLoad];
    
    self.autoresizesSubviews = YES;
    
    NSRect nsframe = NSMakeRect(0,0, self.frame.size.width, self.frame.size.height);

    webView=[[SubWebView alloc]initWithFrame:nsframe];
    webView.autoresizingMask=(NSViewWidthSizable | NSViewHeightSizable);
    
    //[webView setDrawsBackground:NO];
    //[webView setWantsLayer:YES];
    //[webView setCanDrawConcurrently:YES];
    //[webView setHostWindow:window];
    [webView setUIDelegate:self];
    [webView setEditingDelegate:self];
    [self addSubview:webView];
   // web.delegate = self;
}

-(void) loadPage
{
    ///LOAD PAGE
    NSString * page = [NSString stringWithUTF8String:ofToDataPath("/ui/index").c_str()];
    //NSURL * url = [[NSBundle mainBundle] URLForResource:page withExtension:@"html"];
    NSURL * url = [NSURL URLWithString:@"http://localhost:9092/"];
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:url];
    [[webView mainFrame] loadRequest:urlRequest];
}

//Disable right click   


- (void) drawRect: (NSRect) rect {
    //do nothing here...
}


- (BOOL) acceptsFirstResponder {
    return YES;
}
// - - - - LEFT MOUSE BUTTON - - - -


- (void) mouseDown: (NSEvent*) event {
    NSPoint p = [self convertPoint:[event locationInWindow] fromView:nil];
    windowApp->mousePressed(p.x, self.frame.size.height - p.y, 0);
}
 

- (void) mouseDragged: (NSEvent*) event {
    
    NSPoint p = [self convertPoint:[event locationInWindow] fromView:nil];
    windowApp->mouseDragged(p.x, self.frame.size.height - p.y, 0);
}

- (void) mouseUp: (NSEvent*) event {
    
    NSPoint p = [self convertPoint:[event locationInWindow] fromView:nil];
    windowApp->mouseReleased(p.x, self.frame.size.height - p.y, 0);
    windowApp->mouseReleased();
}

// - - - - RIGHT MOUSE BUTTON - - - -

- (void) rightMouseDown: (NSEvent*) event {
    
    NSPoint p = [self convertPoint:[event locationInWindow] fromView:nil];
    windowApp->mousePressed(p.x, self.frame.size.height - p.y, 1);
}

- (void) rightMouseDragged: (NSEvent*) event {
    
    NSPoint p = [self convertPoint:[event locationInWindow] fromView:nil];
    windowApp->mouseDragged(p.x, self.frame.size.height - p.y, 1);
}

- (void) rightMouseUp: (NSEvent*) event {
    
    NSPoint p = [self convertPoint:[event locationInWindow] fromView:nil];
    windowApp->mouseReleased(p.x, self.frame.size.height - p.y, 1);
    windowApp->mouseReleased();
}

- (void) mouseMoved: (NSEvent*) event {
    
    NSPoint p = [self convertPoint:[event locationInWindow] fromView:nil];
    windowApp->mouseX = p.x;
    windowApp->mouseY = self.frame.size.height - p.y;
    windowApp->mouseMoved(p.x, self.frame.size.height - p.y);
}

// - - - - KEYS - - - -

- (void) keyDown: (NSEvent*) event {
    
    unichar c = [[event characters] characterAtIndex:0];
    windowApp->keyPressed(c);
}

- (void) keyUp: (NSEvent*) event {
    
    unichar c = [[event characters] characterAtIndex:0];
    windowApp->keyReleased(c);
}

// - - - - SCROLLWHEEL - - - -

- (void) scrollWheel: (NSEvent*) event {
    
   // windowApp->mouseScrolled(event.deltaX, event.deltaY);
}


// - - - - DRAGGING - - - -
/*Implemented in subWebView
- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    
    //return drag operation copy, so that the cursor and the plus sign...
    //i think this makes the most sense...
    NSLog(@"Super In");
    return NSDragOperationCopy;
}


- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
    
   NSLog(@"Super ON");
    NSPasteboard *pasteboard = [sender draggingPasteboard];
    
    //get the array of filenames, these are absolute file paths
    NSArray *files = [pasteboard propertyListForType: NSFilenamesPboardType];
    
    
    NSPoint p = [sender draggingLocation];
    
    [self setOfWindow];
    ofDragInfo dragInfo;
    dragInfo.position = ofPoint(p.x, ofGetHeight() - p.y);//flip positive y direction
    
    //now we can differentiate between links and data and other stuff like that
    //but for our application, i don't think we need to, so
    
    for (NSString *o in files) {
        dragInfo.files.push_back([o UTF8String]);
    }
    
    windowApp->dragEvent(dragInfo);
    
    
    return YES;
}


- (void) dealloc {

    [super dealloc];
}
*/
@end
