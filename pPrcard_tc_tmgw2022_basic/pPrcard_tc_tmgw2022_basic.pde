import  processing.serial.*;
Serial  serial;
PrintWriter data_file;

String dates = nf(year(),4)+"_"+nf(month(),2)+nf(day(),2); 
String times = nf(hour(),2)+nf(minute(),2)+nf(second(), 2);
String data_file_name = dates+"_"+times;

int input;

// vals for serial port setting 
final int comSpeed = 115200;
boolean DEBUG = true;


//============================================================
void setup() {
  size(1920, 1080);
  String[] ports = Serial.list();
  if (DEBUG) {
    for (int i = 0; i < ports.length; i++) {
      println(i + ": " + ports[i]);
    }
  }
  serial = new Serial(this, ports[0], comSpeed); 
  data_file = createWriter(data_file_name+"/"+data_file_name+".csv");
}

void draw() {
  /*
  println(input);
  background(128);
  fill(255,255,255);
  noStroke();
  ellipse((width/2-300) + input*200, 540, 500, 500);
  */
}

void serialEvent(Serial port) {
  if(port.available() >= 2){
    if(port.read() == 'H'){
      input = port.read();
      data_file.println(nf(input, 3));
    }
  }
}
