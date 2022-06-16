#define pin_key_switch 7
#define pin_lick_port 13

//Micro Controller Setting
int key_switch;                       

//Data Setting
int data_input;
int data_output;
int state =1;
int state_next;

// data
int lick_port;
int task = 0;
unsigned long start_time_ms;
unsigned long diff_time; 
unsigned long pre_time; 
unsigned long lickport_onoff_stm = 0;
unsigned long reward_stm = 0;
int lickport_onoff = 0;
int reward = 0;
int logging_hz = 100;
int logging_tm = 1000000/ logging_hz;



unsigned long iti_ms = 2000;
unsigned long cue_time_ms = 10000;
int reward_duration_ms = 500;
int reward_delay_ms = 500; 

void setup(){
  Serial.begin(115200);
  pinMode(pin_key_switch, INPUT);
  pinMode(pin_lick_port, OUTPUT);
  digitalWrite(pin_lick_port, LOW);
  pre_time = micros();
  start_time_ms = millis();
}

void loop(){
  while(task == 0){
    if(Serial.available() > 0) {
      task = 1;
      state_next = 1;
    }
  }
  while(task == 1){
    diff_time = micros()-pre_time;  
    if( diff_time >= logging_tm){
      pre_time = micros();
      key_switch    = digitalRead(pin_key_switch);
      data_input = 2*key_switch + 1;
      data_output = 2*lick_port + 1;
      state = state_next;
      Serial.write('H');
      Serial.write(data_input);
      Serial.write(data_output);
      Serial.write(state);
      switch(state){
        case 1:
          if(millis()-start_time_ms <= iti_ms){
            if(key_switch == 1){
              start_time_ms = millis();
              state_next = 1;
            }
          }else{
            start_time_ms = millis();
            state_next = 2;
          }
          break;
        case 2:
          if(millis()-start_time_ms <= cue_time_ms){
            if(key_switch == 1){
              start_time_ms = millis();
              state_next = 1;
              lickport_onoff_stm = millis();
              lickport_onoff = 1;
              /*
              reward_stm = millis();
              reward = 1;
              */
            }
          }else{
            start_time_ms = millis();
            state_next = 1;
          }
          break;
      }

      /*
      if(reward == 1){
        if (millis() - reward_stm >= reward_delay_ms) {
          lickport_onoff_stm = millis();
          lickport_onoff = 1;
          reward = 0;
        }
      }
      */
      
      
      if (millis() - lickport_onoff_stm >= reward_duration_ms) {
        lickport_onoff  = 0;
      }
      if ( lickport_onoff == 1) {
        digitalWrite(pin_lick_port, HIGH);
        lick_port = 1;
      }else{
        digitalWrite(pin_lick_port, LOW);
        lick_port = 0;
      }
    }
  }
}
