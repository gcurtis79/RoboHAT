# RoboHAT
This will be the repository of things needed to work with, or at least get started with, my RoboHAT Raspberry Pi HAT for robot control.

The current prototype PCB can be seen, forked and modified, or downloaded and made at https://easyeda.com/gcurtis79/pihat  
Make sure to check anything you get from there untill there's one marked "FINAL" or "RELEASE" because I'm constantly changing it at present.

I will be adding the following:
  * C++ firmware for the Atmega328pb which does the following:
    * Controls the motors
    * Translates hardware PWM for the servos
    * Analog battery voltage monitor
    * 6-DOF IMU (MPU6050) translation
    
  * Mini development environment for compiling/uploading to the Atmega328pb
  
  * Python examples to interface with the board which will include the following:
    * LetsRobot.tv Python3 module for easy integration to LetsRobot
    * Eventually a pypy (pip) library for ease-of-use
    
  * A guide on how I designed and built my prototypes
