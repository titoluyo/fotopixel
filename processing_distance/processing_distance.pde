import processing.video.*;
import processing.serial.*;

Serial myPort;
Capture cam;
PImage img;
float lado;
float factor = 500;

void setup() {
 setupSerial();
 setupCamara();
}

void setupSerial() {
// Inicializando serial
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  println(portName);
  myPort = new Serial(this, portName, 9600); 
  //myPort.write('0');
}

void setupCamara() {
  size(640, 468);
  
  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("No hay camaras disponibles");
    exit();
  } else {
    println("Camaras disponibles:");
    for (int i=0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    cam = new Capture(this, cameras[0]);
    cam.start();
  }
  noStroke();
}


void draw() {
  lado = obtenerLado();
  obtenerImagen();
  dibujarCuadrados(lado);

  println(lado);
}

float obtenerLado(){
  int result = 0;
  
  if ( myPort.available() > 0) 
  {  // If data is available,
    String val = myPort.readStringUntil('\n');
    if (val.length() > 2) {
      val = val.substring(0, val.length()-2);
      try{
        result = Integer.parseInt(val);
      } catch (Exception e) {
        result = 5;
      }
    }
  }
  
  return result; 
}

void obtenerImagen() {
  obtenerSnapshot();
}

void obtenerSnapshot () {
  if (cam.available()) {
    cam.read();
  }
  img = cam;
}


void dibujarCuadrados(float lado){
  for(int i=0; i<width/lado; i++) {
    for(int j=0; j<height/lado; j++) {
      int x = (int)((i+1/2)*lado);
      int y = (int)((j+1/2)*lado);
      
      color c = img.get(x,y);
      fill(c);
      rect(x-lado/2,y-lado/2, lado, lado);
    }
  }
}

