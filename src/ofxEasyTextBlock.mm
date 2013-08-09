/***********************************************************************

 ***********************************************************************/

#include "ofxEasyTextBlock.h"

ofxEasyTextBlock::ofxEasyTextBlock()
{

}

ofxEasyTextBlock::~ofxEasyTextBlock()
{
    
}

void ofxEasyTextBlock::init(ofxFTGLESFont * _FONT,ofxFTGLESFont * _FONTITALIC,ofxFTGLESFont * _FONTBOLD){
    
    defaultFont=_FONT;
    italicFont=_FONTITALIC;
    boldFont=_FONTBOLD;
    lineHeight=defaultFont->getLineHeight();//*LINEHEIGHT;
    offSet=(lineHeight*(LINEHEIGHT))*0.24;
    usingSet=true;
}

void ofxEasyTextBlock::init(ofxFTGLESFont * _FONT){
    
    defaultFont=_FONT;
    lineHeight=defaultFont->getLineHeight();//*LINEHEIGHT;
    offSet=(lineHeight*(LINEHEIGHT))*0.24;
    usingSet=false;
}

void ofxEasyTextBlock::setText(string _inputText, int width){

    words.clear();
    wordsXpos.clear();
    belongToLine.clear();
    fontStyle.clear();
    centeredPos.clear();
    blockWidth=width;
    belongToLine=wrapX(_inputText, width,WRDSPACE);
    boundingBox.width=getWidth();
    boundingBox.height=getHeight();
}

void ofxEasyTextBlock::draw(float x, float y){

    
    if (usingSet==true) {
        for (int i=0;i<words.size(); i++) {
            float xPos=x+wordsXpos[i];
            float yPos=(y+((belongToLine[i]+1)*lineHeight))-offSet;
 
            
            switch (fontStyle[i]) {
                case FONTTEXT:
                    defaultFont->drawString(words[i],xPos, yPos);
                    break;
                case FONTITALIC:
                    italicFont->drawString(words[i],xPos, yPos);
                    break;
                case FONTBOLD:
                    boldFont->drawString(words[i],xPos, yPos);
                    break;
                //default:
                    //defaultFont->drawString(words[i],xPos, yPos);
                //break;
            }
            
        }
    }
    else if (usingSet==false) {
        for (int i=0;i<words.size(); i++) {
            float xPos=x+wordsXpos[i];
            float yPos=(y+((belongToLine[i]+1)*lineHeight))-offSet;
            defaultFont->drawString(words[i],xPos, yPos);
        }
    }
    
    
    boundingBox.x=x;
    boundingBox.y=y;
    
}

void ofxEasyTextBlock::drawCentered(float x, float y){

    if (usingSet==true) {
        for (int i=0;i<words.size(); i++) {
            float xPos=x+wordsXpos[i]+centeredPos[belongToLine[i]];
            float yPos=y+((belongToLine[i]+1)*lineHeight);
            switch (fontStyle[i]) {
                case FONTTEXT:
                    defaultFont->drawString(words[i], xPos, yPos);
                    break;
                case FONTITALIC:
                    italicFont->drawString(words[i], xPos, yPos);
                    break;
                case FONTBOLD:
                    boldFont->drawString(words[i], xPos, yPos);
                    break;
                default:
                    //defaultFont->drawString(words[i], xPos, yPos);
                    break;
            }
        }
    }
    else {
        for (int i=0;i<words.size(); i++) {
            float xPos=x+wordsXpos[i]+centeredPos[belongToLine[i]];
            float yPos=y+((belongToLine[i]+1)*lineHeight);
            defaultFont->drawString(words[i], xPos, yPos);
        }
    }
}



vector<float>ofxEasyTextBlock::wrapX(string text, int width, float wrdSpacing)
{
    
    wordSpacing=defaultFont->stringWidth("v")*wrdSpacing; //WARNING openFrameworks don't get space character width so here it's replaced here by "v"
    text=addSpace(text); //FORMAT EVERY [] tags
    
    string currentLine="";
    currentLineNum=0;
    float lastXLenght=0;
    
    words=ofSplitString(text," ");
    
    vector<float>belongToLine;
    
    int currentFontStyle=FONTTEXT;//By default use text font
        
    for(int i=0; i<words.size(); i++)//Look for TAGs
    {
        wordsXpos.push_back(lastXLenght); 
        
        bool isTag=false;
        if (words[i]=="[ITALIC]") {
            words[i]="";
            currentFontStyle=FONTITALIC;
            //isTag=true;
            //continue;
        }
        else if(words[i]=="[ENDITALIC]") {
            words[i]="";
            currentFontStyle=FONTTEXT;
            //isTag=true;
            //continue;
        }
        if (words[i]=="[TITLE]"||words[i]=="[BOLD]") {
            words[i]="";
            currentFontStyle=FONTBOLD;
            //isTag=true;
            //continue;
        }
        else if (words[i]=="[ENDTITLE]"||words[i]=="[ENDBOLD]") {
            words[i]="";
            currentFontStyle=FONTTEXT;
            //isTag=true;
            //continue;
        }
        if (words[i]=="[BR]") {
            //isTag=true;
        }
        string word=words[i];
        cout<<"word:"<<word<<"."<<endl;
        string nextWord="";
        if (i<words.size()-1) {
            nextWord=words[i+1];
        }else{nextWord="";}
        
        
        currentLine+=word;//add last word to the current string
        
        float newWordWidth=0;
        float nextWordWidth=0;
        if(isTag==false){
            switch (currentFontStyle) { //find current word width with spacing
                case FONTTEXT:
                    newWordWidth=defaultFont->stringWidth(word)+wordSpacing;
                    nextWordWidth=defaultFont->stringWidth(nextWord);
                break;
                case FONTITALIC:
                    newWordWidth=italicFont->stringWidth(word)+wordSpacing;
                    nextWordWidth=italicFont->stringWidth(nextWord);
                break;
                case FONTBOLD:
                    newWordWidth=boldFont->stringWidth(word)+wordSpacing;
                    nextWordWidth=boldFont->stringWidth(nextWord);
                break;
                default:
                    newWordWidth=defaultFont->stringWidth(word)+wordSpacing;
                    nextWordWidth=defaultFont->stringWidth(nextWord);
                break;
            }
        }
        
        //Add new word to the line
        lastXLenght+=newWordWidth;
        
        //!!
        if(usingSet) {
        fontStyle.push_back(currentFontStyle);
        }
        belongToLine.push_back(currentLineNum);
        
         if(word=="[BR]")//FORCE JUMP LINE
        {
            words[i]="";//delete the word [BR]
            currentLineNum++;
            currentLine="";

            float centerString=(width-lastXLenght)/2;//calculate
            centeredPos.push_back(centerString);//store line width
            
            lastXLenght=0;
        }
        else if ((lastXLenght+nextWordWidth)>width || i==words.size()-1)//JUMP LINE When upcoming line > width
        {
            currentLineNum++;
            currentLine="";
            
            float centerString=(width-lastXLenght)/2;//calculate
            centeredPos.push_back(centerString);//store line width
            
            lastXLenght=0;
        }
       

        
        /*
        if (i==words.size()-1) { //if last word
            currentLineNum++;
            currentLine="";
            float centerString=(width-lastXLenght)/2;//calculate
            centeredPos.push_back(centerString);//store line width
        }
        */
        
        
    }
    return belongToLine; //Return which line the word belong to
}



float ofxEasyTextBlock::getWidth(){
    float largerWidth=0;
    float smaller=999999999999;
    for (int i=0; i<centeredPos.size(); i++) {
        if (centeredPos[i]<smaller) {
            smaller=centeredPos[i];
            //cout<<"smaller"<<smaller<<" center pos"<<centeredPos[i]<<endl;
        }
    }
    largerWidth=blockWidth-(smaller*2);
    return  largerWidth;

}

float ofxEasyTextBlock::getHeight(){ //TO VERIFY
   //float height= (lines.size()-1)*(lineHeight);
   
    float height= lineHeight*currentLineNum;//(belongToLine[belongToLine.size()-1])*(lineHeight);
    
    return height;

}

string ofxEasyTextBlock::addSpace(string _input)
{
    
    string output=_input;
    //string *replace;
    
    /*
    replace=new string;
    replace=&output;
    ofStringReplace(*replace, "[BR]", " [BR] ");
    ofStringReplace(*replace, "[ITALIC]", " [ITALIC] ");
    ofStringReplace(*replace, "[ENDITALIC]", " [ENDITALIC] ");
    ofStringReplace(*replace, "[TITLE]", " [TITLE] ");
    ofStringReplace(*replace, "[ENDTITLE]", " [ENDTITLE] ");
    ofStringReplace(*replace, "  ", " ");
    //cout<<"output:"<<*replace<<endl;
    return *replace;
    */

    ofStringReplace(output, "[BR]", " [BR] ");
    ofStringReplace(output, "[ITALIC]", " [ITALIC] ");
    ofStringReplace(output, "[ENDITALIC]", " [ENDITALIC] ");
    ofStringReplace(output, "[TITLE]", " [TITLE] ");
    ofStringReplace(output, "[ENDTITLE]", " [ENDTITLE] ");
    ofStringReplace(output, "[BR]", " [BR] ");

    ofStringReplace(output, "  ", " ");

    return output;
}

