#define trigPin 13
#define echoPin 12

void setup() 
{
//initialize serial communications at a 9600 baud rate
Serial.begin(9600);
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

}

void loop()
{
  long duration, distance;
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH);
  distance = (duration/2) / 29.1;
//  Serial.println(String(distance)};
Serial.println(duration);
//Serial.print("-");
//Serial.println(distance);
}