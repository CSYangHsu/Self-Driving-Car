# Self-Driving-Car
In this project,i implemented a car that follows a track with a black line and stops when there’s an obstacle in front of it.
  
  
## Table of Contents
* [Hardware Details](#Hardware-Details)
* [File introduction](#File-introduction) 
* [Demo](#Demo)


## Hardware Details
- Basys 3 Artix-7 FPGA Trainer Board
- Pmod connectors
- 3-way track sensor :    
![image](https://user-images.githubusercontent.com/86723888/154815908-60290024-db19-443e-b5d0-c4718fb3807a.png) 　![image](https://user-images.githubusercontent.com/86723888/154815920-97cd8817-840f-4531-b092-8ef306beed8c.png)  
This track sensor has 3 independent infrared (IR) sensors. Each IR sensor has an IR blaster and an IR
receiver. If the IR is being reflected by the floor, the sensor will output HIGH. Hence, a white floor
reflects IR, and the sensor outputs HIGH; a black floor absorbs IR, and the sensor outputs LOW.  
 
  
 
    

- Ultrasonic sensor :  
![image](https://user-images.githubusercontent.com/86723888/154815935-797438aa-481d-43a5-95ba-92137b9db3d6.png) 　![image](https://user-images.githubusercontent.com/86723888/154816411-fba4b50c-3658-4d55-900d-fca8e563cc24.png)  
The HC-SR04 Ultrasonic sensor can measure the distance between the sensor module and the object in front of it.  
   - First, send a 10us pulse to the “Trig” pin to trigger the sensor.   
   - The sensor will then generate eight pulses of ultrasonic soundwaves and determine the distance.   
   - After that, the “Echo” pin will output a long pulse. The length of the pulse is equal to the total travel time of the soundwave.  
   - Calculate the distance, that is, (pulse_length / 2) * 340(m/s) .  
   - Each measurement should have a >60ms interval for a better accuracy.  
     
   ![image](https://user-images.githubusercontent.com/86723888/154816687-aa33f456-03b8-4c9f-b9cc-8c848c4be7b7.png)  



 

- L298N motor driver and motors  
![image](https://user-images.githubusercontent.com/86723888/154816716-832be819-a2d7-4116-91fd-e5b034fd57b4.png)  
The L298N is a dual H-Bridge motor driver which supports the speed and direction control of two DC
motors at the same time. ENA, IN1, IN2 controls the motor A, while ENB, IN3, IN4 controls the motor
B.  
  - Direction control:  
  ![image](https://user-images.githubusercontent.com/86723888/154816761-114b9c71-cf35-47f3-b4ee-2b71a0e1e733.png)  

  - Speed controls:    
  Send PWM signals to ENA and ENB to control the speed. A larger duty cycle results in a faster
  speed.  
  ![image](https://user-images.githubusercontent.com/86723888/154816795-5fecaaef-1c8c-47fe-85e3-252b0b4449a9.png) 　![image](https://user-images.githubusercontent.com/86723888/154816799-e59272bc-fd65-472a-b010-44bbc46ac34a.png)  
  ![image](https://user-images.githubusercontent.com/86723888/154816806-c20d4e97-23a3-4cbf-a9bc-468ec30fabe3.png) 　![image](https://user-images.githubusercontent.com/86723888/154816815-47ef9185-3ce4-423b-8852-05cde4268927.png)  




## Demo  
Pass the two maps below.  
![image](https://user-images.githubusercontent.com/86723888/155743619-40691a19-7b4c-4040-9293-8d775ad35c5c.png) 　![image](https://user-images.githubusercontent.com/86723888/155743439-b2dcf388-6d1d-4aa3-9d28-84574e0e1cf2.png)


https://user-images.githubusercontent.com/86723888/154817033-83cd8877-9dcb-40cf-bc83-251738feacbf.mp4




