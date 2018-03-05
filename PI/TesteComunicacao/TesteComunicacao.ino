//Programa: Planta IoT com ESP8266 NodeMCU e MQTT
#include <ESP8266WiFi.h>  //essa biblioteca já vem com a IDE. Portanto, não é preciso baixar nenhuma biblioteca adicional
#include "PubSubClient.h" // Importa a Biblioteca PubSubClient

//defines
#define SSID_REDE     "v1ru5_k1ll.exe"  //coloque aqui o nome da rede que se deseja conectar
#define SENHA_REDE    "g&t_0ut.0f_h&r3_n0w.y0ur_n3tw0rk.Th13F"  //coloque aqui a senha da rede que se deseja conectar
#define INTERVALO_ENVIO_THINGSPEAK  30000  //intervalo entre envios de dados ao ThingSpeak (em ms)
#define INTERVALO_ENVIO_MQTT        10000  //intervalo entre envios de dados via MQTT (em ms)
 
//defines de id mqtt e tópicos para publicação e subscribe
#define TOPICO_SUBSCRIBE "MQTTPIPlantaEnvia"     //tópico MQTT de escuta
#define TOPICO_PUBLISH   "MQTTPIPlantaRecebe"    //tópico MQTT de envio de informações para Broker
                                                  //IMPORTANTE: recomendamos fortemente alterar os nomes
                                                  //            desses tópicos. Caso contrário, há grandes
                                                  //            chances de você controlar e monitorar o NodeMCU
                                                  //            de outra pessoa.
#define ID_MQTT  "PIPlanta"     //id mqtt (para identificação de sessão)
                                       //IMPORTANTE: este deve ser único no broker (ou seja, 
                                       //            se um client MQTT tentar entrar com o mesmo 
                                       //            id de outro já conectado ao broker, o broker 
                                       //            irá fechar a conexão de um deles).
 
//constantes e variáveis globais
const char* BROKER_MQTT = "iot.eclipse.org"; //URL do broker MQTT que se deseja utilizar
int BROKER_PORT = 1883;                      // Porta do Broker MQTT
char EnderecoAPIThingSpeak[] = "https://thingspeak.com/channels/326026";
String ChaveEscritaThingSpeak = "1KTEQ0ZPZY012A6Q";        //coloque aqui sua chave de escrita do seu canal no ThingSpeak
long lastConnectionTime; 
long lastMQTTSendTime;
WiFiClient client;
WiFiClient clientMQTT;
PubSubClient MQTT(clientMQTT); // Instancia o Cliente MQTT passando o objeto clientMQTT
 
//prototypes
void EnviaInformacoesThingspeak(String StringDados);
float FazLeituraLuminosidade(void);
void initWiFi(void);
void initMQTT(void);
void reconectWiFi(void); 
void mqtt_callback(char* topic, byte* payload, unsigned int length);
void VerificaConexoesWiFIEMQTT(void); 

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
 
//Função: inicializa e conecta-se na rede WI-FI desejada
//Parâmetros: nenhum
//Retorno: nenhum
void initWiFi() 
{
    delay(10);
    Serial.println("------Conexao WI-FI------");
    Serial.print("Conectando-se na rede: ");
    Serial.println(SSID_REDE);
    Serial.println("Aguarde");
     
    reconectWiFi();
}
  
//Função: inicializa parâmetros de conexão MQTT(endereço do 
//        broker, porta e seta função de callback)
//Parâmetros: nenhum
//Retorno: nenhum
void initMQTT() 
{
    MQTT.setServer(BROKER_MQTT, BROKER_PORT);   //informa qual broker e porta deve ser conectado
    MQTT.setCallback(mqtt_callback);            //atribui função de callback (função chamada quando qualquer informação de um dos tópicos subescritos chega)
}
  
//Função: função de callback 
//        esta função é chamada toda vez que uma informação de 
//        um dos tópicos subescritos chega)
//Parâmetros: nenhum
//Retorno: nenhum
void mqtt_callback(char* topic, byte* payload, unsigned int length) 
{
        
}
  
//Função: reconecta-se ao broker MQTT (caso ainda não esteja conectado ou em caso de a conexão cair)
//        em caso de sucesso na conexão ou reconexão, o subscribe dos tópicos é refeito.
//Parâmetros: nenhum
//Retorno: nenhum
void reconnectMQTT() 
{
    while (!MQTT.connected()) 
    {
        Serial.print("* Tentando se conectar ao Broker MQTT: ");
        Serial.println(BROKER_MQTT);
        if (MQTT.connect(ID_MQTT)) 
        {
            Serial.println("Conectado com sucesso ao broker MQTT!");
            MQTT.subscribe(TOPICO_SUBSCRIBE); 
        } 
        else
        {
            Serial.println("Falha ao reconectar no broker.");
            Serial.println("Havera nova tentatica de conexao em 2s");
            delay(2000);
        }
    }
}
  
//Função: reconecta-se ao WiFi
//Parâmetros: nenhum
//Retorno: nenhum
void reconectWiFi() 
{
    //se já está conectado a rede WI-FI, nada é feito. 
    //Caso contrário, são efetuadas tentativas de conexão
    if (WiFi.status() == WL_CONNECTED)
        return;
         
    WiFi.begin(SSID_REDE, SENHA_REDE); // Conecta na rede WI-FI
     
    while (WiFi.status() != WL_CONNECTED) 
    {
        delay(100);
        Serial.print(".");
    }
   
    Serial.println();
    Serial.print("Conectado com sucesso na rede ");
    Serial.print(SSID_REDE);
    Serial.println("IP obtido: ");
    Serial.println(WiFi.localIP());
}
 
//Função: verifica o estado das conexões WiFI e ao broker MQTT. 
//        Em caso de desconexão (qualquer uma das duas), a conexão
//        é refeita.
//Parâmetros: nenhum
//Retorno: nenhum
void VerificaConexoesWiFIEMQTT(void)
{
    if (!MQTT.connected()) 
        reconnectMQTT(); //se não há conexão com o Broker, a conexão é refeita
     
     reconectWiFi(); //se não há conexão com o WiFI, a conexão é refeita
}
 
//Função: faz a leitura do nível de Luminosidade
//Parâmetros: nenhum
//Retorno: Luminosidade percentual (0-100)
//Observação: o ADC do NodeMCU permite até, no máximo, 3,3V. Dessa forma,
//            para 3,3V, obtem-se (empiricamente) 978 como leitura de ADC
float FazLeituraLuminosidade(void)
{
  int sensorValue = analogRead(A0);   // read the input on analog pin 0

  float voltage = sensorValue * (3.3 / 978);   // Convert the analog reading (which goes from 0 - 1023) to a voltage (0 - 5V)
  float LuminosidadePercentual = voltage * (100 / 3.3);

  Serial.println("Luminosidade: ");
  Serial.println(LuminosidadePercentual);   // print out the value you read
  Serial.println("%");
  delay(100);
 
     return LuminosidadePercentual;
}
void setup()
{  
    Serial.begin(9600);
    lastConnectionTime = 0; 
    lastMQTTSendTime = 0;
    initWiFi();
    initMQTT();
    Serial.println("Planta IoT com ESP8266 NodeMCU");
}
 
//loop principal
void loop()
{
    float LuminosidadePercentualLida;
    int LuminosidadePercentualTruncada;
    char FieldLuminosidade[11];
    char MsgLuminosidadeMQTT[50];
     
    VerificaConexoesWiFIEMQTT(); 
     
    //Força desconexão ao ThingSpeak (se ainda estiver desconectado)
    if (client.connected())
    {
        client.stop();
        Serial.println("- Desconectado do ThingSpeak");
        Serial.println();
    }
 
    LuminosidadePercentualLida = FazLeituraLuminosidade();
    LuminosidadePercentualTruncada = (int)LuminosidadePercentualLida; //trunca Luminosidade como número inteiro
     
    //verifica se está conectado no WiFi e se é o momento de enviar dados ao ThingSpeak
    if(!client.connected() && 
      ((millis() - lastConnectionTime) > INTERVALO_ENVIO_THINGSPEAK))
    {
        sprintf(FieldLuminosidade,"field1=%d",LuminosidadePercentualTruncada);
        EnviaInformacoesThingspeak(FieldLuminosidade);
    }
 
    //verifica se é o momento de enviar informações via MQTT
    if ((millis() - lastMQTTSendTime) > INTERVALO_ENVIO_MQTT)
    {
        sprintf(MsgLuminosidadeMQTT,"- Luminosidade do solo: %d porcento.",LuminosidadePercentualTruncada);
        MQTT.publish(TOPICO_PUBLISH, MsgLuminosidadeMQTT);
        lastMQTTSendTime = millis();
    }
    
    delay(1000);
}
