/*
* Arduino Wireless Communication Tutorial
*       Example 1 - Receiver Code
*                
* by Dejan Nedelkovski, www.HowToMechatronics.com
* 
* Library: TMRh20/RF24, https://github.com/tmrh20/RF24/
*/
#include <SPI.h>
#include <nRF24L01.h>
#include <RF24.h>
//Radio
RF24 radio(9, 10); // CE, CSN
const byte address[6] = "00001";
const byte writeAddr[6] = "00010";

//LED
struct payload {
  int except;   
};

//LED
struct payload2 {
  int soil;   
};

//SOIL
int val = 0; //value for storing moisture value 
int soilPin = A0;//Declare a variable for the soil moisture sensor 
int soilPower = 3;//Variable for Soil moisture Power

void setup() {
  Serial.begin(9600);
  radio.begin();
  
  // initialize digital pin LED_BUILTIN as an output.
  pinMode(8, OUTPUT);

  // Soil
  pinMode(soilPower, OUTPUT);//Set D7 as an OUTPUT
  digitalWrite(soilPower, LOW);//Set to LOW so no power is flowing through the sensor
}
void loop() {
  //SOIL
  Serial.print("Soil Moisture = ");    
  //get soil moisture value from the function below and print it
  Serial.println(readSoil());
  //send soil value 
  //This 1 second timefrme is used so you can test the sensor and see it change in real-time.
  //For in-plant applications, you will want to take readings much less frequently.

  // Read
  readData();
  delay(100);
  // Write
  writeData();
  //delay(500);//take a reading every second
}

//This is a function used to get the soil moisture content
int readSoil()
{
    digitalWrite(soilPower, HIGH);//turn D7 "On"
    delay(10);//wait 10 milliseconds 
    val = analogRead(soilPin);//Read the SIG value form sensor 
    digitalWrite(soilPower, LOW);//turn D7 "Off"
    return val;//send current moisture value
}

// writeData
void writeData() {
  radio.openWritingPipe(writeAddr);
  radio.setPALevel(RF24_PA_MIN);
  radio.stopListening();

  payload2 plantHealth; 
  plantHealth.soil = readSoil();
  radio.write(&plantHealth, sizeof(plantHealth));
}

// readData
void readData() {
  //setup
  radio.openReadingPipe(0, address);
  radio.setPALevel(RF24_PA_MIN);
  radio.startListening();

  //lights
  if (radio.available()) {
    //char text[32] = "";
    payload lights;
    //radio.read(&text, sizeof(text));
    radio.read(&lights, sizeof(lights));
    Serial.println(lights.except);
    if (lights.except == 1){
      digitalWrite(8, HIGH);   // turn the LED on (HIGH is the voltage level)
      //delay(1000);             // wait for a second
    }
    if (lights.except == 0) {
      digitalWrite(8, LOW);    // turn the LED off by making the voltage LOW
      //delay(1000);             // wait for a second  
    }
  }
}
