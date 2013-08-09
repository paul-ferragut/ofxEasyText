#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#include "ofxFTGLESFont.h"
#include "ofxEasyTextBlock.h"//
#include "ofxXmlSettings.h"



class testApp : public ofxiPhoneApp{
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);
    
    
    string testString;
    
    ofxFTGLESFont *text;
    ofxFTGLESFont *italic;
    ofxFTGLESFont *bold;
    
    
    ofxEasyTextBlock textBlock;
    
    ofxXmlSettings XML;
};


