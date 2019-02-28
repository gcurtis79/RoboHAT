# 1 "/home/gcurtis79/Arduino/libraries/MPU6050_tockn/examples/GetAngle/GetAngle.ino"
# 1 "/home/gcurtis79/Arduino/libraries/MPU6050_tockn/examples/GetAngle/GetAngle.ino"

# 3 "/home/gcurtis79/Arduino/libraries/MPU6050_tockn/examples/GetAngle/GetAngle.ino" 2
# 4 "/home/gcurtis79/Arduino/libraries/MPU6050_tockn/examples/GetAngle/GetAngle.ino" 2

MPU6050 mpu6050(Wire);

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
