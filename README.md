# LED-Stripe-WinControl
Control of a rgb led stripe and peripherals from a windows pc
  
  
Hardware required:    
  -Arduino Nano  
  -LED-Stripe(Type: +RGB)   
  -3 N-channel MOSFETs  
  -12V Power  
  -PCA9685 Servo Driver Board 
  -(Logitech Mouse) if you want to controll the coler of it too  
  -3 10kOhm Resistors   
  -a few cables  
    
Installation: 
 
1.Arduino  
  -Install the .ino file on the Arduino.  
  -Connect the LED-Stripe as showen in this Article to the MOSFETs and the Driver Board: https://blog.adafruit.com/2013/03/29/powering-an-analog-rgb-led-strip-with-the-pi-piday-raspberrypi-raspberry_pi/  
  -Connect the SDA and SCL Pin to A4 and A5 on the arduino nano. On oher boards connect to the corresponding SDA and SCL Pins.  

2.PC  
  -Download Processing  
  -Open the RGB_Picker.pbe file  
  -Install the Logitech LogiLED libary or comment the lines mentioning it out, if you dont use a Logitech mouse or don´t want the rgb on your mouse.  
  -Change the Port to the Port of the connected Arduino. 
  -Run the Script 
