/*
  Arduino code for reading from sensors and sending to PC via serial conn.
 */
#include <SoftwareSerial.h>
#include <TinyGPS.h>

#define sendingDelay 100

// package to send the data
String str;

// value read from pressure sensor
int outValue = 0;

// Ultrasound
int Echo = 7;
int Trig = 6;

// GPS
TinyGPS gps;
SoftwareSerial ss(4, 3); // rx, tx

// setup routine runs once when you press reset
void setup() {
  Serial.begin(9600);

//ports gps
   ss.begin(9600);

//Definim els pins de l'emissor d'ultrasons
  pinMode(Echo, INPUT); //Echo input perque rep l'ultraso
  pinMode(Trig, OUTPUT); //Trig output perque emet l'ultraso

}

// loop routine runs over and over again forever
void loop() {
  // pressure sensor ####################
  // read data on analog pin A0
  outValue = analogRead(A0);
  
  // add data to the package
  str = String(outValue) + ";";
  
  // ultrasound sensor ####################
  //Bucle que realitza l'emisor d'ultrasons
  digitalWrite(Trig, LOW);                        // Nos cercioramos de que Trig no esta emitiendo
  delayMicroseconds(2);                           // Esperamos 2 milisegundos
  digitalWrite(Trig, HIGH);                       // Emitimos un ultrasonido durante 20 milisegundos
  delayMicroseconds(20);
  digitalWrite(Trig, LOW);                        // Paramos de emitir

  float Fdistance = pulseIn(Echo, HIGH);          // Guardamos en la variable Fdistance, el valor recibido del pin Echo
  Fdistance = Fdistance / 58;                     // Aplicamos la formula para calcular la distancia con respecto al tiempo de envio y recibo

  // add data to package
  str = str + String(Fdistance) + ";";

  // GPS ####################
  bool newData = false;
  unsigned long chars;
  unsigned short sentences, failed;

  // For one second we parse GPS data and report some key values
  for (unsigned long start = millis(); millis() - start < 1000;)
  {
    while (ss.available())
    {
      char c = ss.read();
      if (gps.encode(c)) // Did a new valid sentence come in?
        newData = true;
    }
  }

  if (newData)
  {
    float flat, flon;
    unsigned long age;
    gps.f_get_position(&flat, &flon, &age);

    // add data to the package
    str = str + "LAT=";
    str = str + String(flat == TinyGPS::GPS_INVALID_F_ANGLE ? 0.0 : flat, 6) + ";";
    str = str + "LON=";
    str = str + String(flon == TinyGPS::GPS_INVALID_F_ANGLE ? 0.0 : flon, 6);
  }
  else
  {
    // if no data is recieved send X
    str = str + ("X");
  }

  // send data package
  Serial.println(str);
  str = "";
}
