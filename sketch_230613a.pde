import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;

Serial myPort;
String angle = "";
String distance = "";
String data = "";
String noObject;
float pixsDistance;
int iAngle, iDistance;
int index1 = 0;
int index2 = 0;
PFont orcFont;

void setup() {
  size(1200, 700);
  smooth();
  String portName = Serial.list()[0];  // Change this to the correct port name
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('.');
}

void draw() {
  background(0);
  fill(98, 245, 31);
  noStroke();
  rect(0, 0, width, height - height * 0.065);

  fill(98, 245, 31);
  drawRadar();
  drawLine();
  drawObject();
  drawText();
}

void serialEvent(Serial myPort) {
  data = myPort.readStringUntil('.');
  data = data.substring(0, data.length() - 1);

  index1 = data.indexOf(",");
  angle = data.substring(0, index1);
  distance = data.substring(index1 + 1, data.length());

  iAngle = int(angle);
  iDistance = int(distance);
}

void drawRadar() {
  pushMatrix();
  translate(width / 2, height - height * 0.074);

  // Draw black background
  fill(0);
  noStroke();
  float radius = width - width * 0.0625;
  float startAngle = PI;
  float endAngle = TWO_PI;
  beginShape(TRIANGLE_FAN);
  vertex(0, 0);
  for (float angle = startAngle; angle <= endAngle; angle += 0.01) {
    float x = radius * cos(angle);
    float y = radius * sin(angle);
    vertex(x, y);
  }
  endShape();

  // Draw concentric circles
  for (int i = 1; i <= 4; i++) {
    float circleRadius = width - width * 0.0625 * i * 0.208;
    noFill();
    stroke(98, 245, 31);
    ellipse(0, 0, circleRadius, circleRadius);
  }

  // Draw radar lines
  stroke(98, 245, 31);
  line(-width / 2, 0, width / 2, 0);
  line(0, 0, (-width / 2) * cos(radians(30)), (-width / 2) * sin(radians(30)));
  line(0, 0, (-width / 2) * cos(radians(60)), (-width / 2) * sin(radians(60)));
  line(0, 0, (-width / 2) * cos(radians(90)), (-width / 2) * sin(radians(90)));
  line(0, 0, (-width / 2) * cos(radians(120)), (-width / 2) * sin(radians(120)));
  line(0, 0, (-width / 2) * cos(radians(150)), (-width / 2) * sin(radians(150)));
  line((-width / 2) * cos(radians(30)), 0, width / 2, 0);

  popMatrix();
}

void drawObject() {
  pushMatrix();
  translate(width / 2, height - height * 0.074);
  strokeWeight(9);
  stroke(255, 10, 10);

  pixsDistance = iDistance * ((height - height * 0.1666) * 0.025);

  if (iDistance < 40) {
    line(
      pixsDistance * cos(radians(iAngle)),
      -pixsDistance * sin(radians(iAngle)),
      (width - width * 0.505) * cos(radians(iAngle)),
      -(width - width * 0.505) * sin(radians(iAngle))
    );
  }

  popMatrix();
}

void drawLine() {
  pushMatrix();
  strokeWeight(9);
  stroke(30, 250, 60);
  translate(width / 2, height - height * 0.074);
  line(
    0,
    0,
    (height - height * 0.12) * cos(radians(iAngle)),
    -(height - height * 0.12) * sin(radians(iAngle))
  );

  popMatrix();
}

void drawText() {
  pushMatrix();

  if (iDistance > 40) {
    noObject = "Out of Range";
  } else {
    noObject = "In Range";
  }

  fill(0);
  noStroke();
  rect(0, height - height * 0.0648, width, height);

  fill(98, 245, 31);
  textSize(20);
  text("10cm", width - width * 0.3854, height - height * 0.0833);
  text("20cm", width - width * 0.281, height - height * 0.0833);
  text("30cm", width - width * 0.177, height - height * 0.0833);
  text("40cm", width - width * 0.0729, height - height * 0.0833);

  textSize(40);
  text("Nathnael Minuta's Radar", width - width * 0.875, height - height * 0.0277);
  text("Angle: " + iAngle + "°", width - width * 0.48, height - height * 0.0277);

  text("D: ", width - width * 0.26, height - height * 0.0277);

  if (iDistance < 40) {
    textSize(30);
    text(" " + iDistance + " cm", width - width * 0.225, height - height * 0.0277);
  }

  textSize(25);
  fill(98, 245, 60);

  translate((width - width * 0.4994) + width / 2 * cos(radians(30)), (height - height * 0.0907) - width / 2 * sin(radians(30)));
  rotate(-radians(-60));
  text("30°", 0, 0);
  resetMatrix();

  translate((width - width * 0.503) + width / 2 * cos(radians(60)), (height - height * 0.0888) - width / 2 * sin(radians(60)));
  rotate(-radians(-30));
  text("60°", 0, 0);
  resetMatrix();

  translate((width - width * 0.507) + width / 2 * cos(radians(90)), (height - height * 0.0833) - width / 2 * sin(radians(90)));
  rotate(radians(0));
  text("90°", 0, 0);
  resetMatrix();

  translate(width - width * 0.513 + width / 2 * cos(radians(120)), (height - height * 0.07129) - width / 2 * sin(radians(120)));
  rotate(radians(-30));
  text("120°", 0, 0);
  resetMatrix();

  translate(width - width * 0.525 + width / 2 * cos(radians(150)), (height - height * 0.0638) - width / 2 * sin(radians(150)));
  rotate(radians(-60));
  text("150°", 0, 0);
  resetMatrix();

  fill(98, 245, 31);
  textSize(40);
  text("Object: " + noObject, width - width * 0.875, height - height * 0.0277 * 2.8);

  popMatrix();
}

void keyPressed() {
  if (key == 'q') {
    myPort.write('q');
  }
}
