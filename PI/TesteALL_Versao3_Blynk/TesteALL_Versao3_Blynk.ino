/* ESP & Blynk */
#include <ESP8266WiFi.h>
#include "DHT.h"
#include <BlynkSimpleEsp8266.h>
/* TIMER */
#include "SimpleTimer.h"
SimpleTimer timer;

#define BLYNK_PRINT Serial    // Comment this out to disable prints and save space
char auth[] = "97d478a19d4b44f7adb4d53b41e23821";

// Definições de pinos
#define DHTPIN  D2
#define DHTTYPE DHT11
#define pino_sinal_digital_1 D0
#define pino_sinal_digital_2 D1

/* WiFi credentials */
char ssid[] = "v1ru5_k1ll.exe";
char pass[] = "g&t_0ut.0f_h&r3_n0w.y0ur_n3tw0rk.Th13F";

DHT dht(DHTPIN, DHTTYPE);

//Protótipos das funções
float LerLuminosidade(void);
float LerUmidadeAr(void);
float LerTemperatura(void);
float LerUmidadeSolo(void);

//Rotina para obter dados do sensor de luminosidade
float LerLuminosidade(void){
  
  int sensorValue = analogRead(A0);             // lendo a entrada analogica do pino A0
  float voltage = sensorValue * (3.3 / 978);    // Converte a leitura analógica (intervalo: 0 - 1023) que corresponde a (0 - 5V)
  float luminosidade = voltage * (100 / 3.3);   // Converte em porcentagem de luminosidade

  Serial.print("Luminosidade: ");
  Serial.print(luminosidade);   // print out the value you read
  Serial.println("%");

  return luminosidade;
}

float LerUmidadeAr(void){
  
  float h = dht.readHumidity();
  
  if (isnan(h)) 
  {
    Serial.println("Falha ao ler a umidade do ar.");
  } 
  else 
  {
    Serial.print("Umidade do ar: ");
    Serial.println(h);
  }
  return h;
  
}

float LerTemperatura(void){

  float t = dht.readTemperature();
  
  if (isnan(t)) 
  {
    Serial.println("Falha ao ler a temperatura.");
  } 
  else 
  {
    Serial.print("Temperatura: ");
    Serial.print(t);
    Serial.println(" *C");
  }
  return t;
  
}

float LerUmidadeSolo(void){

  int valor_digital_1 = digitalRead(pino_sinal_digital_1);
  int valor_digital_2 = digitalRead(pino_sinal_digital_2);
  float umidadeSolo;
  
  Serial.print("Valor digital higrometro 1 lido: ");
  Serial.println(valor_digital_1);
  Serial.print("Valor digital higrometro 2 lido: ");
  Serial.println(valor_digital_2);
  if(valor_digital_1 == 0 && valor_digital_2 == 0){
    umidadeSolo = 10;
  }
  if(valor_digital_1 == 0 && valor_digital_2 == 1){
    umidadeSolo = 30;
  }
  if(valor_digital_1 == 1 && valor_digital_2 == 0){
    umidadeSolo = 50;
  }
  if(valor_digital_1 == 1 && valor_digital_2 == 1){
    umidadeSolo = 70;
  }
  Serial.print("Limiar de teste: ");
  Serial.print(umidadeSolo);
  Serial.println("\n\n");
  return umidadeSolo;
  
}


void setup() 
{
  Serial.begin(115200);
  Blynk.begin(auth, ssid, pass);
  Blynk.notify("Conectado ao blynk!");
  timer.setInterval(60000, mandaDadosBlynk);
}

void loop() 
{
  timer.run(); // Initiates SimpleTimer
  Blynk.run();
}

/***************************************************
 * Mandando os dados dos sensores para o Blynk
 **************************************************/
void mandaDadosBlynk()
{
  //LDR - Luminosidade
  float luminosidade = LerLuminosidade();
  
  //DHT11 - Umidade do Ar e Temperatura
  digitalWrite(DHTPIN, HIGH);
  float umidadeAr = LerUmidadeAr();
  float temperatura = LerTemperatura();
  
  //Higrômetros - Umidade do Solo
  float umidadeSolo = LerUmidadeSolo();

  Blynk.notify("L="+String(luminosidade)+" A="+String(umidadeAr)+" T="+String(temperatura)+" S="+String(umidadeSolo));
  
  //Associa os dados dos sensores através de cada pinto virtual
  Blynk.virtualWrite(V0, luminosidade); //virtual pin V0
  Blynk.virtualWrite(V1, umidadeAr); //virtual pin V1
  Blynk.virtualWrite(V2, temperatura); //virtual pin V2
  Blynk.virtualWrite(V3, umidadeSolo); //virtual pin V3
}


