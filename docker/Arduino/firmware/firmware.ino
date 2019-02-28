#include "Arduino.h"
#include <MPU6050_tockn.h>
#include <Wire.h>
#include <Wire1.h>
#include <EveryTimer.h>
#include <TimeLib.h>

MPU6050 mpu6050(Wire);

EveryTimer gyroDisp;

bool LED = true;
int LED_PIN = 7;

void flash(int,int);
void dd();

void setup() {
  Serial.begin(9600);
  delay(1000);
  Wire.begin();
  mpu6050.begin();
  mpu6050.calcGyroOffsets(true);
  pinMode(LED_PIN, OUTPUT);
  setTime(0);
  gyroDisp.Every(1000, dd);
}

void loop() {
  mpu6050.update();
  gyroDisp.Update();
}

void dd() {
  Serial.print("angleX : ");
  Serial.print(mpu6050.getAngleX());
  Serial.print("\tangleY : ");
  Serial.print(mpu6050.getAngleY());
  Serial.print("\tangleZ : ");
  Serial.println(mpu6050.getAngleZ());
  flash();
}

void flash() {
  digitalWrite(LED_PIN, LED);
  LED = !LED;
}