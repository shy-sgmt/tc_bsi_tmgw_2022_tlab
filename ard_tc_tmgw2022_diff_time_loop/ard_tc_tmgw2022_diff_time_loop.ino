int pre_time;
int diff_time;

void setup(){
  pre_time = millis();
}

void loop(){
  diff_time = millis()-pre_time;  
  if( diff_time >= 5){
    pre_time = millis();
    /*
     *  Code
     */
  }
}
