#include "DHT.h"

#define DHTPIN  D2
#define DHTTYPE DHT11 
#define pino_sinal_analogico A0
#define pino_sinal_digital_1 D0
#define pino_sinal_digital_2 D1

DHT dht(DHTPIN, DHTTYPE);

int valor_analogico;
int valor_digital_1;
int valor_digital_2;

void setup()
{
  Serial.begin(9600);
  pinMode(pino_sinal_analogico, INPUT);
  pinMode(pino_sinal_digital_1, INPUT);
  pinMode(pino_sinal_digital_2, INPUT);
  pinMode(D2, OUTPUT);
  dht.begin();
}

void loop()
{
/*******************************************************************************************/
/***********************************Higrometros 1 e 2****************************************/

  valor_digital_1 = digitalRead(pino_sinal_digital_1);
  valor_digital_2 = digitalRead(pino_sinal_digital_2);
  Serial.print("Valor digital higrometro 1 lido: ");
  Serial.println(valor_digital_1);
  Serial.print("Valor digital higrometro 2 lido: ");
  Serial.println(valor_digital_2);


/*******************************************************************************************/
/***********************************LDR******************************************************/

  int sensorLDR_Value = analogRead(pino_sinal_analogico);   
  float voltage = sensorLDR_Value * (3.3 / 1024);   
  float luminosidade = voltage * (100 / 3.3);

  Serial.println("Luminosidade: ");
  Serial.println(luminosidade);   
  Serial.println("%");

  /*******************************************************************************************/
/***********************************DHT11******************************************************/

  digitalWrite(D2, HIGH);
  
  float h = dht.readHumidity();
  float t = dht.readTemperature();
  
  if (isnan(t) || isnan(h)) 
  {
    Serial.println("Failed to read from DHT");
  } 
  else 
  {
    Serial.print("Umidade do ar: ");
    Serial.print(h);
    Serial.print(" %t");
    Serial.print("Temperatura: ");
    Serial.print(t);
    Serial.println(" *C");
  }
  
  delay(1500);
}
