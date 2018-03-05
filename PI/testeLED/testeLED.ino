


// the setup function runs once when you press reset or power the board
void setup() {
  // initialize digital pin LED_BUILTIN as an output.
  pinMode(D0, OUTPUT);
  pinMode(D1, OUTPUT);
  pinMode(D2, OUTPUT);
  pinMode(D3, OUTPUT);
}

// the loop function runs over and over again forever
void loop() {
  digitalWrite(D0, HIGH);   // turn the LED on (HIGH is the voltage level)
  delay(100);                       // wait for a second
  digitalWrite(D0, LOW);
  digitalWrite(D1, HIGH);// turn the LED off by making the voltage LOW
  delay(100);   
  digitalWrite(D1, LOW);
  digitalWrite(D2, HIGH);// wait for a second
  delay(100);   
  digitalWrite(D2, LOW);
  digitalWrite(D3, HIGH);
  delay(100);   
  digitalWrite(D3, LOW);
 
}
