#include <Arduino.h>
#include <MPU6050_tockn.h>
#include <Wire.h>
#include <EveryTimer.h>
#include <TimeLib.h>
#include <U8g2lib.h>

U8G2_SSD1306_128X64_NONAME_F_HW_I2C u8g2(U8G2_R0, /* reset=*/ U8X8_PIN_NONE);

MPU6050 mpu6050(Wire);

EveryTimer gyroDisp;

bool LED = true;
int LED_PIN = 7;

void flash(int,int);

void setup() {
  Serial.begin(9600);
  delay(1000);
  u8g2.begin();  
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

char lines[8][1];

void dd(int line, char* a, char* n = "") {
  char spaces[30] = "                             ";
  sprintf(lines[line], "%s%s", a, n);
  strcat(lines[line], &spaces[strlen(lines[line])]);
  u8g2.setCursor(0, (line * 8));
  u8g2.print(lines[line]);
  u8g2.sendBuffer();
}
{
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