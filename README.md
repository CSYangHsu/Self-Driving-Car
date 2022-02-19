# Self-Driving-Car
In this project,i implemented a car that follows a track with a black line and stops when there’s an obstacle in front of it.
  
  
## Table of Contents
* [Hardware Details](#Hardware-Details)
* [Example](#Example) 
* [Complete Grammar Rules](#Complete-Grammar-Rules)
* [Operators and Variables](#Operators-and-Variables)
* [Instruction Set Architecture](#Instruction-Set-Architecture)

## Hardware Details
- Basys 3 Artix-7 FPGA Trainer Board
- Pmod connectors
- 3-way track sensor :    
![image](https://user-images.githubusercontent.com/86723888/154815908-60290024-db19-443e-b5d0-c4718fb3807a.png) 　![image](https://user-images.githubusercontent.com/86723888/154815920-97cd8817-840f-4531-b092-8ef306beed8c.png)  
This track sensor has 3 independent infrared (IR) sensors. Each IR sensor has an IR blaster and an IR
receiver. If the IR is being reflected by the floor, the sensor will output HIGH. Hence, a white floor
reflects IR, and the sensor outputs HIGH; a black floor absorbs IR, and the sensor outputs LOW.  
  
  
  Pin connections:  
   - VCC pin: connects to the supply power provided by the FPGA board.  
   - GND pin: connects to the ground of the FPGA board.  
   - L pin: outputs the status of the left IR sensor. You should connect it to an input port.  
   - C pin: outputs the status of the middle IR sensor. You should connect it to an input port.  
   - R pin: outputs the status of the right IR sensor. You should connect it to an input port.  
  
 
    

- Ultrasonic sensor :  
![image](https://user-images.githubusercontent.com/86723888/154815935-797438aa-481d-43a5-95ba-92137b9db3d6.png) 　![image](https://user-images.githubusercontent.com/86723888/154816411-fba4b50c-3658-4d55-900d-fca8e563cc24.png)  
The HC-SR04 Ultrasonic sensor can measure the distance between the sensor module and the object in front of it.  
   - First, send a 10us pulse to the “Trig” pin to trigger the sensor.   
   - The sensor will then generate eight pulses of ultrasonic soundwaves and determine the distance.   
   - After that, the “Echo” pin will output a long pulse. The length of the pulse is equal to the total travel time of the soundwave.  
   - Calculate the distance, that is, (pulse_length / 2) * 340(m/s) .  
   - Each measurement should have a >60ms interval for a better accuracy.  
   ![image](https://user-images.githubusercontent.com/86723888/154816687-aa33f456-03b8-4c9f-b9cc-8c848c4be7b7.png)  



  Pin connections:  
   - VCC pin: connected to the supply power provided by the FPGA board. 
   - Trig pin: connected to an output pin on the FPGA board to trigger the sensor
   - Echo pin: connected to an input pin on the FPGA board to measure pulse length.     
   - Gnd pin: connected to the ground of the FPGA board.   


