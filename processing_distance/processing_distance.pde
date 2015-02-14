import processing.serial.*;

Serial myPort;  // Create object from Serial class

void setup() {
// Inicializando serial
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  println(portName);
  myPort = new Serial(this, portName, 9600); 
  //myPort.write('0');
}

void draw() {
  int distance = getDistance();
  println(distance);
}

int getDistance(){
  int result = 0;
  if ( myPort.available() > 0) 
  {  // If data is available,
    String val = myPort.readStringUntil('\n');
    if (val.length() > 2) {
      val = val.substring(0, val.length()-2);
      result = Integer.parseInt(val);
    }
  }
  return result; 
}
