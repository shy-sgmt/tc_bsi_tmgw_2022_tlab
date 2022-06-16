#define pin_led 13
#define pin_key_switch 7

unsigned long pre_time;
unsigned long diff_time;
int key_switch = 0;


void setup(){
  Serial.begin(115200);
  pinMode(pin_led, OUTPUT);
  pinMode(pin_key_switch, INPUT);
  digitalWrite(pin_led, LOW);
  pre_time = micros();
}

void loop(){
  diff_time = micros()-pre_time;  
  if( diff_time >= 1000){
    pre_time = micros();

    key_switch = digitalRead(pin_key_switch);
    Serial.println(key_switch);
    
    if(key_switch == 1){
      digitalWrite(pin_led, HIGH);
    }else if(key_switch == 0){
      digitalWrite(pin_led, LOW);
    }
    
  }
}
