//Include da lib de Wifi do ESP8266
#include <ESP8266WiFi.h>
 
//Definir o SSID da rede WiFi
const char* ssid = "v1ru5_k1ll.exe";
//Definir a senha da rede WiFi
const char* password = "g&t_0ut.0f_h&r3_n0w.y0ur_n3tw0rk.Th13F";
 
//Colocar a API Key para escrita neste campo
//Ela é fornecida no canal que foi criado na aba API Keys
String apiKey = "1KTEQ0ZPZY012A6Q";
const char* server = "api.thingspeak.com";
 
WiFiClient client;
 
void setup() {
  //Configuração da UART
  Serial.begin(9600);
  //Inicia o WiFi
  WiFi.begin(ssid, password);
 
  //Espera a conexão no router
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
 
 
  //Logs na porta serial
  Serial.println("");
  Serial.print("Conectado na rede ");
  Serial.println(ssid);
  Serial.print("IP: ");
  Serial.println(WiFi.localIP());
}
 
void loop() {
 
  //Espera 20 segundos para fazer a leitura
  delay(20000);

  int sensorValue = analogRead(A0);   // read the input on analog pin 0
  float voltage = sensorValue * (3.3 / 978);   // Convert the analog reading (which goes from 0 - 1023) to a voltage (0 - 5V)
  float luminosidade = voltage * (100 / 3.3);
 
  //Inicia um client TCP para o envio dos dados
  if (client.connect(server,80)) {
    String postStr = apiKey;
           postStr +="field1=";
           postStr += String(luminosidade);
           postStr +="field2=";
           postStr += String(voltage);
           postStr += "\r\n\r\n";
 
     client.print("POST /update HTTP/1.1\n");
     client.print("Host: api.thingspeak.com\n");
     client.print("Connection: close\n");
     client.print("X-THINGSPEAKAPIKEY: "+apiKey+"\n");
     client.print("Content-Type: application/x-www-form-urlencoded\n");
     client.print("Content-Length: ");
     client.print(postStr.length());
     client.print("\n\n");
     client.print(postStr);
 
     //Logs na porta serial
     Serial.print("Luminosidadea: ");
     Serial.print(luminosidade);
     Serial.print(" Voltage: ");
     Serial.println(voltage);
  }
  client.stop();
}
