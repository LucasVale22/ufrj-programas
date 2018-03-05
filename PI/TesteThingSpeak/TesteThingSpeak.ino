#include <ESP8266WiFi.h>  //essa biblioteca já vem com a IDE. Portanto, não é preciso baixar nenhuma biblioteca adicional

//defines
//#define SSID_REDE     "LABECA"  //coloque aqui o nome da rede que se deseja conectar
//#define SENHA_REDE    "labecah215b"  //coloque aqui a senha da rede que se deseja conectar
#define SSID_REDE     "v1ru5_k1ll.exe"  //coloque aqui o nome da rede que se deseja conectar
#define SENHA_REDE    "g&t_0ut.0f_h&r3_n0w.y0ur_n3tw0rk.Th13F"  //coloque aqui a senha da rede que se deseja conectar
#define INTERVALO_ENVIO_THINGSPEAK  3000  //intervalo entre envios de dados ao ThingSpeak (em ms)

//constantes e variáveis globais
char EnderecoAPIThingSpeak[] = "api.thingspeak.com";
String ChaveEscritaThingSpeak = "CSAIG42CHKYO8XIT";
long lastConnectionTime; 
WiFiClient client;

//prototypes
void EnviaInformacoesThingspeak(String StringDados);
void FazConexaoWiFi(void);
float FazLeituraLuminosidade(void);

/*
 * Implementações
 */

//Função: envia informações ao ThingSpeak
//Parâmetros: String com a  informação a ser enviada
//Retorno: nenhum
void EnviaInformacoesThingspeak(String StringDados)
{
    if (client.connect(EnderecoAPIThingSpeak, 80))
    {         
        //faz a requisição HTTP ao ThingSpeak
        Serial.println(EnderecoAPIThingSpeak);
        client.print("POST /update HTTP/1.1n");
        client.print("Host: api.thingspeak.comn");
        client.print("Connection: closen");
        client.print("X-THINGSPEAKAPIKEY: "+ChaveEscritaThingSpeak+"n");
        client.print("Content-Type: application/x-www-form-urlencodedn");
        client.print("Content-Length: ");
        client.print(StringDados.length());
        client.print("nn");
        client.print(StringDados);
  
        lastConnectionTime = millis();
        Serial.println("- Informações enviadas ao ThingSpeak!");
     }   
}

//Função: faz a conexão WiFI
//Parâmetros: nenhum
//Retorno: nenhum
void FazConexaoWiFi(void)
{
    client.stop();
    Serial.println("Conectando-se à rede WiFi...");
    Serial.println();  
    delay(1000);
    WiFi.begin(SSID_REDE, SENHA_REDE);

    while (WiFi.status() != WL_CONNECTED) 
    {
        delay(500);
        Serial.print(".");
    }

    Serial.println("");
    Serial.println("WiFi connectado com sucesso!");  
    Serial.println("IP obtido: ");
    Serial.println(WiFi.localIP());

    delay(1000);
}


float FazLeituraLuminosidade(void)
{
  int sensorValue = analogRead(A0);   // read the input on analog pin 0

  float voltage = sensorValue * (3.3 / 978);   // Convert the analog reading (which goes from 0 - 1023) to a voltage (0 - 5V)
  float luminosidade = voltage * (100 / 3.3);

  return luminosidade;
}
void setup()
{  
    Serial.begin(9600);
    lastConnectionTime = 0; 
    FazConexaoWiFi();
    Serial.println("Planta IoT com ESP8266 NodeMCU");
}

//loop principal
void loop()
{
    float luminosidadeLida;
    char FieldLuminosidade[11];
    
    //Força desconexão ao ThingSpeak (se ainda estiver desconectado)
    if (client.connected())
    {
        client.stop();
        Serial.println("- Desconectado do ThingSpeak");
        Serial.println();
    }

    luminosidadeLida = FazLeituraLuminosidade();
    
    //verifica se está conectado no WiFi e se é o momento de enviar dados ao ThingSpeak
    if(!client.connected() && 
      (millis() - lastConnectionTime > INTERVALO_ENVIO_THINGSPEAK))
    {
        sprintf(FieldLuminosidade,"field1=%d",luminosidadeLida);
        EnviaInformacoesThingspeak(FieldLuminosidade);
    }
    Serial.println(FieldLuminosidade);
    Serial.println(luminosidadeLida);
    

     delay(1000);
}
