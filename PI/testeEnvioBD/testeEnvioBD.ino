#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include "DHT.h"
#define DHTPIN  D2
#define DHTTYPE DHT11
DHT dht(DHTPIN, DHTTYPE);
// WiFi - Coloque aqui suas configurações de WI-FI
const char ssid[] = "NossaRede";
const char psw[] = "casamiranda";

// Site remoto - Coloque aqui os dados do site que vai receber a requisição GET
const char http_site[] = "http://mycomputer";
const int http_port = 8080;

// Variáveis globais
WiFiClient client;
IPAddress server(192,168,1,106); //Endereço IP do servidor - http_site
//int pinDHT11 = D2;
//SimpleDHT11 dht11;

void setup() {
  delay(30000); //Aguarda 30 segundos 
  Serial.begin(9600);
  Serial.println("NodeMCU - Gravando dadios no BD via GET");
  Serial.println("Aguardando conexão");
  
  // Tenta conexão com Wi-fi
  WiFi.begin(ssid, psw);
  while ( WiFi.status() != WL_CONNECTED ) {
    delay(2000);
    Serial.print("...\n");
  }
  Serial.print("\nWI-FI conectado com sucesso: ");
  Serial.println(ssid);

}

void loop() {
  
  //Leitura do sensor DHT11
  delay(3000); //delay entre as leituras

   float humid = dht.readHumidity();
   float temp = dht.readTemperature();
  
  Serial.println("Gravando dados no BD: ");
  Serial.print(temp); Serial.print(" *C, "); 
  Serial.print(humid); Serial.println(" %");

  // Envio dos dados do sensor para o servidor via GET
  if (!getPage(temp,humid)) {
    Serial.println("GET request failed");
  }
}

// Executa o HTTP GET request no site remoto
bool getPage(float temp, float humid) {
  if ( !client.connect(server, http_port) ) {
    Serial.println("Falha na conexao com o site ");
    return false;
  }
  String param = "/?temp=" + String(temp) + "&humid=" + String(humid); //Parâmetros com as leituras
  Serial.println(param);
  client.println("GET /weather/insert_plantacond.php" + param + " HTTP/1.1");
  client.println("Host: ");
  client.println(http_site);
  client.println("Connection: close");
  client.println();
  client.println();

    // Informações de retorno do servidor para debug
  while(client.available()){
    String line = client.readStringUntil('\r');
    Serial.print(line);
  }
  return true;
}
