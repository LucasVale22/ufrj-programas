#include <SoftwareSerial.h>
#include "DHT.h"
#include <ESP8266WiFi.h>
//#include "ESP8266.h"
// Definições de constantes
#define HIGROMETRO_PIN A0
#define DHT_PIN 15
#define LDR_PIN 16
#define DHTTYPE DHT11
//#define SSID_REDE "Tiger"
//#define SENHA_REDE "f&f@fofa"
String SSID_REDE = "Tiger";
String SENHA_REDE = "f&f@fofa";
DHT dht(DHT_PIN, DHTTYPE);

//Protótipos das funções
//float LerLuminosidade(void);
//float LerUmidadeAr(void);
//float LerTemperatura(void);
//float LerUmidadeSolo(void);

SoftwareSerial esp(6,7);  // RX, TX

String data;
String server = "www.000webhost.com";
String uri = "/esppost2.php";
String host = "www.000webhost.com";
byte dat [5];
String ind;
int cont;

void setup() {
  pinMode (DHT_PIN, OUTPUT);
  esp.begin(9600);
  Serial.begin(9600);
  reset();
  connectWifi();
  cont = -1;
}
float LerLuminosidade(void){
  
  int sensorValue = analogRead(LDR_PIN);             // lendo a entrada analogica do pino A0
  float voltage = sensorValue * (3.3 / 978);    // Converte a leitura analógica (intervalo: 0 - 1023) que corresponde a (0 - 5V)
  float luminosidade = voltage * (100 / 3.3);   // Converte em porcentagem de luminosidade

  Serial.print("Luminosidade: ");
  Serial.print(luminosidade);   // print out the value you read
  Serial.println("%");

  return luminosidade;
}

float LerUmidadeAr(void){
  
  float umidadeAr = dht.readHumidity();
  
  if (isnan(umidadeAr)) 
    Serial.println("Falha ao ler a umidade do ar.");
  else 
  {
    Serial.print("Umidade do ar: ");
    Serial.println(umidadeAr);
  }
  return umidadeAr;
}

float LerTemperatura(void){

  float temperatura = dht.readTemperature();
  if (isnan(temperatura)) 
    Serial.println("Falha ao ler a temperatura.");
  else {
    Serial.print("Temperatura: ");
    Serial.print(temperatura);
    Serial.println(" *C");
  }
  return temperatura;
  
}

float LerUmidadeSolo(void){

  float umidadeSolo = analogRead(HIGROMETRO_PIN);
  Serial.print("Valor lido pelo higrometro: ");
  Serial.println(umidadeSolo);
  Serial.println("\n\n");
  return umidadeSolo;
  
}

void reset() { 
  esp.println("AT+RST"); 
  delay(1000);
  if(esp.find("OK") )
    Serial.println("Module Reset");
} 

void connectWifi() {
  String cmd = "AT+CWJAP=\"" + SSID_REDE +"\",\"" + SENHA_REDE + "\""; 
  esp.println(cmd); 
  delay(4000); 
  if(esp.find("OK"))
  Serial.println("Connected!"); 
}

void loop () {
  String luminosidade = String(LerLuminosidade());
  digitalWrite(DHT_PIN, HIGH);
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
  Serial.println(data);
  delay(1000);
}

void httppost () {

  esp.println("AT+CIPSTART=\"TCP\",\"" + server + "\",80"); //start a TCP connection. 
  if( esp.find("OK"))
     Serial.println("TCP connection ready");
  delay(1000);
  
  String postRequest = "POST " + uri + " HTTP/1.0\r\n" + "Host: " + server + "\r\n" + "Accept: *" + "/" + "*\r\n" + 
              "Content-Length: " + data.length() + "\r\n" + "Content-Type: application/x-www-form-urlencoded\r\n" + 
              "\r\n" + data;
  String sendCmd = "AT+CIPSEND=";//determine the number of caracters to be sent.
  esp.print(sendCmd); 
  esp.println(postRequest.length() ); 
  delay(500); 
  if(esp.find(">"))
    Serial.println("Sending.."); esp.print(postRequest); 
  if( esp.find("SEND OK")) {
    Serial.println("Packet sent"); 
    while (esp.available()){ 
      String tmpResp = esp.readString(); 
      Serial.println(tmpResp); 
    }
    // close the connection
    esp.println("AT+CIPCLOSE");
  } 
}

