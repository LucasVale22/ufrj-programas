void setup() {
  Serial.begin(9600); 
}
void loop() {

  int sensorValue = analogRead(A0);             // lendo a entrada analogica do pino A0
  float voltage = sensorValue * (3.3 / 978);    // Converte a leitura analógica (intervalo: 0 - 1023) que corresponde a (0 - 5V)
  float luminosidade = voltage * (100 / 3.3);   // Converte em porcentagem de luminosidade

  Serial.print("Luminosidade: ");
  Serial.print(luminosidade);   // print out the value you read
  Serial.println("%");
  
}
