// Firebase library copyright 2015 Google Inc.
#include <Firebase.h>
#include <FirebaseArduino.h>
#include <FirebaseCloudMessaging.h>
#include <FirebaseError.h>
#include <FirebaseHttpClient.h>
#include <FirebaseObject.h>

// To send and receive radio signals from nano
#include <SPI.h>
#include <nRF24L01.h>

// To connect to wifi and Firebase
#include <ESP8266WiFi.h>
#include <FirebaseArduino.h>

#include <RF24.h>

// Radio
RF24 radio(D4, D8); // CE, CSN
const byte writeAddr[6] = "00001";
const byte readAddr[6] = "00010";

// Firebase and wifi
#define FIREBASE_HOST "plantbit-3d62f.firebaseio.com"
#define FIREBASE_AUTH "2X33LuXGfMeYtEhVF5jRUgOnNe6fX9LPb85O0Wk1"
#define WIFI_SSID "CalvinHacks24"                   // can change
#define WIFI_PASSWORD "knights2019"                 // can change

const int WIFI_LED = D2;

// output payload
struct payload {
  int except;
};

// input payload
struct payload2 {
  int soil;
};

void setup() {
  Serial.begin(9600);
  radio.begin();

  pinMode(WIFI_LED, OUTPUT);                        // define LED pin
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  //connect to wifi
  while (WiFi.status() != WL_CONNECTED) {           // wait till connected to WiFi
    delay(100);
    digitalWrite(WIFI_LED, LOW);                    // blink the light till connected to WiFi
    delay(100);
    digitalWrite(WIFI_LED, HIGH);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("WiFi connected");
  digitalWrite(WIFI_LED, HIGH);
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());

  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);      // connect to database
  //delay(1000);
}

void writeData(int p) {
  radio.openWritingPipe(writeAddr);
  radio.setPALevel(RF24_PA_MIN);
  radio.stopListening();

  payload lights;
  lights.except = p;
  radio.write(&lights, sizeof(lights));
  Serial.println(lights.except);
}

void readData() {
  radio.openReadingPipe(0, readAddr);
  radio.setPALevel(RF24_PA_MIN);
  radio.startListening();

  if (radio.available()) {
    payload2 plantHealth;
    radio.read(&plantHealth, sizeof(plantHealth));
    Serial.println(plantHealth.soil);
    Firebase.setInt("/plant_health/soil_moisture", plantHealth.soil);
  }
}

void loop() {
  // send out {exception, schedule}
  // receive {plant-health}
  int power = Firebase.getInt("/power/on");
  writeData(power);
  delay(300);
  readData();
  delay(50);                                          // pls don't freak out anymore
}
