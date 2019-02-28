#include <Arduino.h>
#line 1 "/home/gcurtis79/Arduino/libraries/MPU6050_tockn/examples/GetAngle/GetAngle.ino"
#line 1 "/home/gcurtis79/Arduino/libraries/MPU6050_tockn/examples/GetAngle/GetAngle.ino"

#include <MPU6050_tockn.h>
#include <Wire.h>

MPU6050 mpu6050(Wire);

#line 7 "/home/gcurtis79/Arduino/libraries/MPU6050_tockn/examples/GetAngle/GetAngle.ino"
void setup();
#line 14 "/home/gcurtis79/Arduino/libraries/MPU6050_tockn/examples/GetAngle/GetAngle.ino"
void loop();
#line 7 "/home/gcurtis79/Arduino/libraries/MPU6050_tockn/examples/GetAngle/GetAngle.ino"
void setup() {
  Serial.begin(9600);
  Wire.begin();
  mpu6050.begin();
  mpu6050.calcGyroOffsets(true);
}

void loop() {
  mpu6050.update();
  Serial.print("angleX : ");
  Serial.print(mpu6050.getAngleX());
  Serial.print("\tangleY : ");
  Serial.print(mpu6050.getAngleY());
  Serial.print("\tangleZ : ");
  Serial.println(mpu6050.getAngleZ());
}

