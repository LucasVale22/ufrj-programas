//Programa: Monitoracao de planta usando Arduino
//Autor: FILIPEFLOP

#define pino_sinal_analogico A0
#define pino_sinal_digital_1 D0
#define pino_sinal_digital_2 D1

int valor_analogico;
int valor_digital_1;
int valor_digital_2;
float UmidadePercentual;

void setup()
{
  Serial.begin(9600);
  pinMode(pino_sinal_analogico, INPUT);
  pinMode(pino_sinal_digital_1, INPUT);
  pinMode(pino_sinal_digital_2, INPUT);
}

void loop()
{
  //Le o valor do pino A0 do sensor
  valor_analogico = analogRead(pino_sinal_analogico);
  valor_digital_1 = digitalRead(pino_sinal_digital_1);
  valor_digital_2 = digitalRead(pino_sinal_digital_2);
  Serial.print("Valor analogico lido: ");
  Serial.println(valor_analogico);
  if(valor_digital_1 == 1){
    Serial.println("Higrometro 1: Abaixo de 50%. ");
  }
  else
  {
    Serial.println("Higrometro 1: Acima de 50%. ");
  }
  if(valor_digital_2 == 1){
    Serial.println("Higrometro 2: Abaixo de 50%. ");
  }
  else
  {
    Serial.println("Higrometro 2: Acima de 50%. ");
  }
  //Mostra o valor da porta analogica no serial monitor
  UmidadePercentual = 100 * ((978-(float)valor_analogico) / 978);
  Serial.print("[Umidade Percentual] ");
  Serial.print(UmidadePercentual);
  Serial.println("%");
  delay(1000);
}

