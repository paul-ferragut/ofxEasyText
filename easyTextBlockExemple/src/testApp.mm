#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){	

	ofBackground(0,0,0);
	ofSetFrameRate(30);
	ofSetVerticalSync(true);
	
	ofEnableAlphaBlending();
	ofSetLogLevel(OF_LOG_NOTICE);
    
    
    text=new ofxFTGLESFont;
    text->loadFont("fonts/Neutra2Text-Book.otf", 16,true,false,false,0,72);
    
    italic=new ofxFTGLESFont;
    italic->loadFont("fonts/Neutra2Text-LightItalic.otf", 16,true,false,false,0,72);
    
    bold=new ofxFTGLESFont;
    bold->loadFont("fonts/Neutra2Display-Bold.otf", 18,true,false,false,0,72);
    
    
    textBlock.init(text, italic, bold);
    
    XML.loadFile("recipe.xml");
    //XML.pushTag("pasta_recipe");
    testString=XML.getValue("pasta_recipe", "other");

    //XML.popTag();
    cout<<"teststring"<<XML.getNumTags("pasta_recipe")<<testString<<endl;
    
    textBlock.setText(testString, ofGetScreenWidth()*0.8);
    
    
}

//--------------------------------------------------------------
void testApp::update(){

}

//--------------------------------------------------------------
void testApp::draw(){
	ofSetColor(255,255,255);
	
    textBlock.draw(ofGetScreenWidth()*0.1, ofGetScreenWidth()*0.1);
    //font.drawString("HelloWorld", 0, ofGetHeight());
	//font.drawString(str, 0, ofGetHeight());
}

//--------------------------------------------------------------
void testApp::exit(){

}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void testApp::lostFocus(){

}

//--------------------------------------------------------------
void testApp::gotFocus(){

}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){

}

