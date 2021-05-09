
#include <Wire.h>
#include <Adafruit_PWMServoDriver.h>
Adafruit_PWMServoDriver pwm = Adafruit_PWMServoDriver();

int rPin = 4;
int gPin = 6;
int bPin = 5;
int DELAY = 1;
int x2,y2,z2;
int value; 

void setup() {
  Serial.begin(9600);
  pwm.begin();
  pwm.setOscillatorFrequency(27000000);
  pwm.setPWMFreq(1500);  // This is the maximum PWM frequency
  Wire.setClock(400000);
  
  pwm.setPWM(rPin,0,0 );
  pwm.setPWM(gPin,0,0 );
  pwm.setPWM(bPin,0,0 );
  
  Serial.println("Startup complete");
}

void loop(){  
  if(Serial.available() > 0) {
    x2=Serial.parseInt()*10;
    y2=Serial.parseInt()*10;
    z2=Serial.parseInt()*10;
    
    Serial.println(x2);
    Serial.println(y2);
    Serial.println(z2);/*
    if(value == 'r'){                 //Red
      for(int i=0; i<512; i++) {
      pwm.setPWM(rPin,0,0 );
      pwm.setPWM(gPin,0, i*8 );
      pwm.setPWM(bPin,0,0 );
      delay(DELAY);
      Serial.println("r");
      Serial.println(i);
      }
    }else if(value == 'g'){                 //Green
      for(int i=0; i<512; i++) {
      pwm.setPWM(rPin,0,0 );
      pwm.setPWM(gPin,0,0 );
      pwm.setPWM(bPin,0,i*8 );
      delay(DELAY);
      Serial.println("g");
      Serial.println(i);
      }
    }else if(value == 'b'){                 //Blue
      for(int i=0; i<512; i++) {
      pwm.setPWM(rPin,0,i*8 );
      pwm.setPWM(gPin,0,0);
      pwm.setPWM(bPin,0,0 );
      delay(DELAY);
      Serial.println("b");
      Serial.println(i);
      }
    }else if(value == "f"||value == "fade"){         //fade RGB
      // fade from green to red
      for(int i=0; i<512; i++) {
        pwm.setPWM(rPin,0,i*8 );
        pwm.setPWM(gPin,0,4095 - i*8 );
        pwm.setPWM(bPin,0,0 );
        delay(DELAY);
        Serial.println("b");
        Serial.println(i);
      }
    
      // fade from red to blue
      for(int i=0; i<512; i++) {
        pwm.setPWM(rPin,0,4095 - i*8 );
        pwm.setPWM(gPin,0,0 );
        pwm.setPWM(bPin,0,i*8 );
        delay(DELAY);
        Serial.println("r");
        Serial.println(i);
      }
    
      // fade from blue to green
      for(int i=0; i<512; i++) {
        pwm.setPWM(rPin,0,0 );
        pwm.setPWM(gPin,0, i*8 );
        pwm.setPWM(bPin,0,4095 - i*8 );
        delay(DELAY);
        Serial.println("g");
        Serial.println(i);
      }  
    }else if (value == "b"||value == "blink"){         //Blink
        pwm.setPWM(rPin,0,4095 );
        pwm.setPWM(bPin,0,0 );
        pwm.setPWM(gPin,0,0 );
        
        delay(500);
        
        pwm.setPWM(gPin,0,4095 );
        pwm.setPWM(rPin,0,0 );
        pwm.setPWM(bPin,0,0 );
        
        delay(500);
        
        pwm.setPWM(bPin,0,4095 );
        pwm.setPWM(rPin,0,0 );
        pwm.setPWM(gPin,0,0 );
        
        delay(500);
      
    }else if (value == "o"||value == "off"){
        pwm.setPWM(rPin,0,0 );
        pwm.setPWM(gPin,0,0 );
        pwm.setPWM(bPin,0,0 );
      
    }else{                             //set color*/
      if(x2||y2||z2 != 0){
        pwm.setPWM(rPin,0,x2 );
        pwm.setPWM(gPin,0,y2 );
        pwm.setPWM(bPin,0,z2 );
      }
    //}
  }
}
