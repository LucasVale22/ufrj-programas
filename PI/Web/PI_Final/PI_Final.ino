#include "SoftwareSerial.h"
#include <ESP8266WiFi.h>
#include "DHT.h"

// Definições de constantes
#define DHTPIN  D2
#define DHTTYPE DHT11
#define HIGROMETRO_UM D0
#define HIGROMETRO_DOIS D1
#define SSID_REDE "NossaRede"
#define SENHA_REDE "casamiranda"

WiFiClient client;

DHT dht(DHTPIN, DHTTYPE);

//Protótipos das funções
float LerLuminosidade(void);
float LerUmidadeAr(void);
float LerTemperatura(void);
float LerUmidadeSolo(void);

//SoftwareSerial esp(6, 7);// RX, TX

String data;
String server = "piplanta.000webhostapp.com";
String uri = "/esppost2.php";
String host = "piplanta.000webhostapp.com";

void setup() {
  pinMode (DHTPIN, OUTPUT);
  esp.begin(9600);
  Serial.begin(9600);
  connectWifi();
  int cont = -1;
  String ind;
}


void connectWifi() {
  WiFi.begin(SSID_REDE, SENHA_REDE);
  while (WiFi.status() != WL_CONNECTED)
  {
      delay(500);
      Serial.print(".");
  }
  Serial.println("Connected!");
}

void loop () {

  String luminosidade = String(LerLuminosidade());
  digitalWrite(DHTPIN, HIGH);
  String umidadeAr = String(LerUmidadeAr());
  String temperatura = String(LerTemperatura());
  String umidadeSolo = String(LerUmidadeSolo());

  cont += 1;
  if(cont == 48)
    cont = 0;
  if(cont == 0)
    data = "l0=" + luminosidade + "&u0=" + umidadeAr + "&t0=" + temperatura + "&us0=" + umidadeSolo;
  else {
    ind = String(cont);
    data += "&l" + ind + "=" + luminosidade + "&u" + ind + "=" + umidadeAr + "&t" + ind + "=" + temperatura + "&us" + ind + "=" + umidadeSolo;
  }
  httppost();
  delay(1000);
}

void httppost () {

  if (!client.connect(host, 80)) {
    Serial.println("connection failed");
    return;
  }

  delay(1000);

  client.println("POST " + uri + " HTTP/1.0\r\n");
  client.print("Host: " + host + "\n");
  client.println("User Agent: ESP8266/1.0");
  client.println("Connection: close");
  client.println("Content-Type: application/x-www-form-urlencoded\r\n");
  client.print("Content-Length: " + data.length() + "\n\n");
  client.print(data);
  client.stop();

  delay(500);
  while(client.available()){
        String line = client.readStringUntil('\r');
        Serial.print(line);
  }
}
