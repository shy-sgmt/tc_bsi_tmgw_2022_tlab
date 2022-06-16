#define pin_led 13
int pre_time;
int diff_time;
void setup(){
  pinMode(pin_led, OUTPUT);
  digitalWrite(pin_led, LOW);
  pre_time = millis();
}

void loop(){
  diff_time = millis()-pre_time;  
  if( diff_time >= 0 && diff_time < 1000){
    digitalWrite(led, HIGH);
  }else if( diff_time >= 1000 && diff_time < 2000){
    digitalWrite(led, LOW);
  }else if( diff_time >= 2000){
    pre_time = millis();
  }
}
