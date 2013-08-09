/***********************************************************************

 Copyright (c) 2009, Paul

 ***********************************************************************/

#ifndef OFXEASYTEXTBLOCK_H
#define OFXEASYTEXTBLOCK_H

#include "ofMain.h"
#include <iterator>
#include "ofxFTGLESFont.h"

#define WRDSPACE 0.7
#define LINEHEIGHT 1.2

#define FONTTEXT 1
#define FONTITALIC 2
#define FONTBOLD 3



class ofxEasyTextBlock
{
    public:
        ofxEasyTextBlock();
        virtual ~ofxEasyTextBlock();

        ofxFTGLESFont * defaultFont;
        ofxFTGLESFont * boldFont;
        ofxFTGLESFont * italicFont;

        void init(ofxFTGLESFont * _FONT,ofxFTGLESFont * _FONTITALIC,ofxFTGLESFont * _FONTBOLD);
        void init(ofxFTGLESFont * _FONT);
        bool usingSet;

        void    setText(string _inputText, int width);

        void    setLineHeight(float lineHeight);

        void    draw(float x, float y);                    //Draws left align.
    
        void    drawCentered(float x, float y);                    //Draws left align.

        string addSpace(string _input);

        float   getWidth();
        float   getHeight();
    int blockWidth;
    
    float lineHeight;
    
    float wordSpacing;
    int currentLineNum;
    
    float offSet;
    
    vector<float>wrapX(string text, int width, float wordSpacing);
    vector<float>wordsXpos;
    vector<float>belongToLine;
    vector<float>centeredPos;
    
    vector<int>fontStyle;
    
    vector<string>words;

    ofRectangle boundingBox;
    

    protected:


    private:
};

#endif // OFXEASYTEXTBLOCK_H
