import  processing.serial.*;
Serial  serial;
PrintWriter data_file;

// Data
String header = "trn_crs";
String subject = "Sugimoto";
String folder = subject+"_"+dateString()+"_"+timeString();
String comment = "Test";
String note = "Test";
String program_name = "pPrcard_tc_tmgw2022";
String fn_header = header+"_"+subject+"_"+dateString()+"_"+timeString();
String data_file_name = fn_header+"_behvfile_"+comment; 

// Setting image data type
PImage img_loading;
PImage img_iti;
PImage img_cue;

// vals for serial port setting 
final int comSpeed = 115200;
boolean DEBUG = true;

// Vals for data processing and saving
int input = 1;
int output = 1;
int state = 0;

//
String start_time;

//  Screen processing parameter
final int framerate = 100;
final int screenNum = 2 ;
int c = 0;

//============================================================
void setup() {
  // Generate cue image as .png 
  stimMaking();
  // Searching serial port
  String[] ports = Serial.list();
  if (DEBUG) {
    for (int i = 0; i < ports.length; i++) {
      println(i + ": " + ports[i]);
    }
  }
  serial = new Serial(this, ports[0], comSpeed); 
  println("connected serial port:"+ports[0]);
  data_file = createWriter(folder+"/"+fn_header+"/"+data_file_name+".csv");
  data_file.println(fn_header);
  data_file.println(subject+","+dateString()+","+comment+","+note);
  data_file.println("Time,Input,Output,State");
  frameRate(framerate);
  size(1280, 720);
  //fullScreen(screenNum);
  img_loading = loadImage("0.png");
  img_iti = loadImage("1.png");
  img_cue = loadImage("2.png");
  state = 0;
}

void draw() {
   
    print("INPUT|OUTPU|STATE");
    print("|"+input);
    print("|"+output);
    println("|"+state);
    c=0;
  // Switching image data
  switch(state){
    case 0:
      image(img_loading, 0, 0);
      break;
    case 1:
      image(img_iti, 0, 0);
      break;
    case 2:
      image(img_cue, 0, 0);
      break;
  }
}

void serialEvent(Serial port) {
  if(port.available() >= 4){
    if(port.read() == 'H'){
      input = port.read();
      output = port.read();
      state = port.read();
      data_file.print(timeString());
      data_file.print(",");
      data_file.print(nf(input, 3));
      data_file.print(",");
      data_file.print(nf(output+5, 3));
      data_file.print(",");
      data_file.println(nf(state+10, 3));
      data_file.flush();
    }
  }
}

void keyPressed(){
  if(key == 's'){
    serial.write("s");
  }
  if(key == 'e'){
    data_file.println("");
    data_file.flush();
    data_file.close();
    serial.clear();
    serial.stop();
    exit();
  }
}

// ============================================================ BASIC METHODS ============================================================
String dateString(){
  String dates = nf(year(),4)+"_"+nf(month(),2)+nf(day(),2); 
  return dates;
}

String timeString(){
  String times = nf(hour(),2)+nf(minute(),2)+nf(second(), 2);
  return times;
}

// =======================================================================================================================================
void stimMaking(){
  // case 0:
  background(0);
  textSize(30);
  text("Ready", 1280/2, 720/2);
  save(str(0)+".png");
  save(folder+"/"+fn_header+"/img/"+str(0) + ".png"); 
  // case 1:
  background(128);
  save(str(1)+".png");
  save(folder+"/"+fn_header+"/img/"+str(1) + ".png");
  // case 2:
  background(128);
  fill(255,255,255);
  noStroke();
  ellipse(1280/2, 720/2, 500, 500);
  save(str(2)+".png");
  save(folder+"/"+fn_header+"/img/"+str(2) + ".png"); 
}
