# Self-Driving-Car
In this project,i implemented a car that follows a track with a black line and stops when there’s an obstacle in front of it.
  
  
## Table of Contents
* [Hardware Details](#Hardware-Details)
* [Design](#Design) 
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


## Design
- tracker_sensor.v: 車頭的紅外線 sensor 判斷車子是否在軌道上，依據情況判定左右轉及直行。
  共有 3 個 Tracker sensors，分置於左中右。當看到黑色軌道時，紅外線被吸收，其輸出為 0，
  看到白色 floor 時，反射紅外線，其輸出為 1。
  針對車子偏左偏右、在中間的狀態描述，和軌道的寬度有關。此處的軌道為一個sensor的寬度。  
    
  車身狀態: 輸出 state (2 bits)應對。  
    + 在黑線中間時: tracker sensors (left_track, mid_track, right_track) = (1, 0, 1)，　 state = (0,1)，代表可以直行 (direct).  
    + 偏黑線左邊時: tracker sensors (left_track, mid_track, right_track) = (1, 1, 0). 　state = (0,0)，代表需右轉.  
    + 偏黑線右邊時: tracker sensors (left_track, mid_track, right_track) = (0, 1, 1). 　state = (1,0)，代表需左轉.  
   要右轉, 就要把右motor的速度變慢. 同理, 要左轉, 就要把左motor的速度變慢. 詳細的細節, 會在 motor.v 說明。  

- sonic.v: 用來判斷車子是否遇到障礙物。  
做法為每 100 mini-seconds 做一次距離的量測。每一次量測，紀錄 echo (from sonic sensors)
的時間長度，再換算成距離(以公分表示)。  


- motor.v: 控制車子前進和轉彎。
    + 前進: 左右兩邊的速度一樣。  
    + 右轉時，右邊的 motor 向後轉，左邊 motor 向前轉。  
    + 左轉時, 左邊的 motor 向後轉，右邊 motor 向前轉。  
  控制轉快和轉慢由 duty 決定。 Duty 越大，轉速越快。並且由 PWM 來控制 Duty。  
  
- 轉大彎For U-turn: 在面對極大轉彎時(趨近 90 度)，當轉彎到一半時，容易遇到車頭與黑線平行，三個tracker sensors 感應到 (0,0,0) 全黑的情況，而無法判斷後續為左/右轉。 
Sol: 就像日常生活開車一樣，遇到極大轉彎時，先轉一半→直行→再轉剩下一半。  
    Ex. 右轉大彎  
    1. 照舊右轉  
    2. 中途遇到全黑(0,0,0)時，直行。  
    3. 直行到非全黑(0,0,0)時，回歸(1.)步驟狀態，繼續右轉，直到車頭轉回軌道。  
    ![image](https://user-images.githubusercontent.com/86723888/155745662-ff760a57-b0ae-40b5-9424-b22eef76275d.png)

  
  
## Demo  
Pass the two maps below.  
![image](https://user-images.githubusercontent.com/86723888/155743619-40691a19-7b4c-4040-9293-8d775ad35c5c.png) 　![image](https://user-images.githubusercontent.com/86723888/155743439-b2dcf388-6d1d-4aa3-9d28-84574e0e1cf2.png)


https://user-images.githubusercontent.com/86723888/154817033-83cd8877-9dcb-40cf-bc83-251738feacbf.mp4




