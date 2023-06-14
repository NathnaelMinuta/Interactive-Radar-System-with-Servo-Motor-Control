# Interactive-Radar-System-with-Servo-Motor-Control
This is an interactive radar system implemented using the Processing programming language and Arduino Uno. The system utilizes an ultrasonic sensor for distance measurement and a servo motor for controlling the sensor's angle. It provides a graphical representation of the detected distance and angle, creating a radar-like display on the screen.
Key Features:
Real-time visualization: The system reads data from the ultrasonic sensor via Arduino Uno and displays the detected objects on the screen in real-time.
Interactive display: The radar display shows the angle and distance of detected objects, with the angle controlled by the servo motor.
Adjustable range: Users can customize the maximum range for detecting objects by modifying the Arduino code.
Object status indication: The system indicates whether an object is within range or out of range based on the set maximum range.
User-friendly interface: The graphical user interface provides clear visual feedback and displays the angle, distance, and object status in a readable format.
Easy customization: The code can be easily modified to adapt to different sensor configurations or incorporate additional functionalities.

Hardware Components:
Arduino Uno: The Arduino board controls the servo motor and handles the communication between the ultrasonic sensor and the Processing program.
Ultrasonic sensor: The sensor is used for distance measurement and object detection.
Servo motor: The servo motor controls the angle of the ultrasonic sensor, allowing it to sweep across the range.
