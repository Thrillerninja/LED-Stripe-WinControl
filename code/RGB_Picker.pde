ColorPicker cp;
import processing.serial.*;
import com.logitech.gaming.LogiLED;        //Maus
Serial port;

//Buttons
boolean fade = false;

int bx = 00;
int by = 400;
int bw = 75;
int bh = 26;
color c1;

void setup() 
{
  size( 500, 500 );
  frameRate( 40 );
  LogiLED.LogiLedInit();
  cp = new ColorPicker( 10, 10, 400, 400, 255 );  
  port = new Serial(this, Serial.list()[0], 9600);
}

void draw ()
{
  background( 80 );
  cp.render();
  fill(175);
  rect(bx+40,by+20,bw-30,20);        //Fade  
  rect(bx+90,by+20,bw-40,20);        //OFF
  
  fill(0);
  textSize(17);
  text("Fade", bx+42, bh+411);
  text("OFF", bx+bw+17, bh+411);
  
  //Get color
  color c = get(20, 430);
  int r  = (int)red(c);
  int g  = (int)green(c);
  int b  = (int)blue(c);
  
  if (c!=c1){
  LogiLED.LogiLedSetLightingForTargetZone(0x3,0,r,g,b);            //Maus
  LogiLED.LogiLedSetLightingForTargetZone(0x3,1,r,g,b);            //Maus Logo
  port.write(r + "," + g + "," + b + ">");  
  println(System.currentTimeMillis()+" <" + r + "," + g + "," + b + ">");  
  c1 = c;
  }
  fill(r, g, b);
  noStroke();

  rect(20, 20, 50, 50);
  
  fill(255);
  text(r, 20, 30);
  text(g, 20, 40);
  text(b, 20, 50);
  delay(10);
  
  //LogiLED.LogiLedShutdown();
}



public class ColorPicker 
{
  int x, y, w, h, c;
  PImage cpImage;
  
  public ColorPicker ( int x, int y, int w, int h, int c )
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
    
    cpImage = new PImage( w, 500 );
    
    init();
  }
  
  private void init ()
  {
    // draw color.
    int cw = w - 60;
    for( int i=0; i<cw; i++ ) 
    {
      float nColorPercent = i / (float)cw;
      float rad = (-360 * nColorPercent) * (PI / 180);
      int nR = (int)(cos(rad) * 127 + 128) << 16;
      int nG = (int)(cos(rad + 2 * PI / 3) * 127 + 128) << 8;
      int nB = (int)(Math.cos(rad + 4 * PI / 3) * 127 + 128);
      int nColor = nR | nG | nB;
      
      setGradient( i, 0, 1, h/2, 0xFFFFFF, nColor );
      setGradient( i, (h/2), 1, h/2, nColor, 0x000000 );
    }
    
    // draw black/white.
    //drawRect( cw, 0,   30, h/2, 0xFFFFFF );
    //drawRect( cw, h/2, 30, h/2, 0 );
    
    // draw grey scale.
    for( int j=0; j<h; j++ )
    {
      int g = 255 - (int)(j/(float)(h-1) * 255 );
      drawRect( w-30, j, 30, 1, color( g, g, g ) );
    }
    
    drawRect(bx,by,bw,bh,175);                                  //Fade  
    drawRect(bx+bw+10,by,bw/2-5,bh,color( 80, 80, 80 ));        //OFF
    drawRect(bx,by+bh+10,bw/2-5,bh,color( 255, 0, 0 ));         //R
    drawRect(bx+bw/2+5,by+bh+10,bw/2-5,bh,color( 0, 255, 0 ));  //G
    drawRect(bx+bw+10,by+bh+10,bw/2-5,bh,color( 0, 0, 255 ));   //B
  }

  private void setGradient(int x, int y, float w, float h, int c1, int c2 )
  {
    float deltaR = red(c2) - red(c1);
    float deltaG = green(c2) - green(c1);
    float deltaB = blue(c2) - blue(c1);

    for (int j = y; j<(y+h); j++)
    {
      int c = color( red(c1)+(j-y)*(deltaR/h), green(c1)+(j-y)*(deltaG/h), blue(c1)+(j-y)*(deltaB/h) );
      cpImage.set( x, j, c );
    }
  }
  
  private void drawRect( int rx, int ry, int rw, int rh, int rc )
  {
    for(int i=rx; i<rx+rw; i++) 
    {
      for(int j=ry; j<ry+rh; j++) 
      {
        cpImage.set( i, j, rc );
      }
    }
  }
  
  public void render ()
  {
  image( cpImage, x, y );
    
  if (mousePressed && mouseX > bx+40 && mouseX < bx+40+bw-30 && mouseY > by+20 && mouseY < by+40) {    //Fade
    cp.fade();
  }else if (mousePressed && mouseX > bx+90 && mouseX < bx+90+bw-40 && mouseY > by+20 && mouseY < by+40){    //OFF
    c = 1;
  }else if((mousePressed && mouseX >= x && mouseX < x + w && mouseY >= y && mouseY < y + h )||(mousePressed && mouseX >= x && mouseX < x + 120 && mouseY >= by+bh+15 && mouseY < 500/*y + h*/ )){
      c = get( mouseX, mouseY );
    }
    fill( c );
    rect( x, y+h+10, 20, 20 );
  }
  
  public void fade ()
  {
  port.write( 300 + "," + 300 + "," + 300 + ">");
  println(System.currentTimeMillis()+" < Fade >");
    
  }
}
