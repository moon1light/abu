 import controlP5.*;


import de.voidplus.myo.*;
ControlP5 cp5;
Myo myo;
Textfield file;
boolean p=false;
boolean s=false;
boolean submit=false;
ArrayList<ArrayList<Integer>> sensors;
PrintWriter emgWrite;
void setup() {
  size(800, 800);
 //fullScreen();
  background(255);
  noFill();
  stroke(0);
  
  cp5= new ControlP5(this);
 cp5.addButton("play")
     .setValue(0)
     .setPosition(0,0)
     .setSize(100,19)
     ;
    cp5.addButton("save")
     .setValue(0)
     .setPosition(100,0)
     .setSize(100,19)
     ;
     
    file= cp5.addTextfield("File Name")
     .setAutoClear(false)
     .setPosition(200,0)
     .setSize(100,19)
     ;
     
      cp5.addButton("submit")
     .setValue(0)
     .setPosition(300,0)
     .setSize(100,19)
     ;
 
     
  myo = new Myo(this, true); // true, with EMG data
  
  sensors = new ArrayList<ArrayList<Integer>>();
  for (int i=0; i<8; i++) {
    sensors.add(new ArrayList<Integer>()); 
   
    
  }
  
}

void draw() {
  background(0);

  if(!p){
  
  
  // Drawing:
  synchronized (this) {
    for (int i=0; i<8; i++) {
      if (!sensors.get(i).isEmpty()) {
        beginShape();
        for (int j=0; j<sensors.get(i).size(); j++) {
          vertex(j, sensors.get(i).get(j)+(i*100));
          stroke(255);
        }
        endShape();
      } 
    }
  }
}else{
}
 
}

// ----------------------------------------------------------

void myoOnEmgData(Device myo, long timestamp, int[] data) {
  // println("Sketch: myoOnEmgData, device: " + myo.getId());
  // int[] data <- 8 values from -128 to 127
  if(!p){
  // Data:
  synchronized (this) {
    for (int i = 0; i<data.length; i++) {
      sensors.get(i).add((int) map(data[i], 0, 200, 0, 50)); // [-128 - 127]
    }
    while (sensors.get(0).size() > width) {
      for(ArrayList<Integer> sensor : sensors) {
        sensor.remove(0);
      }
    }
  }
  }else{
  }
}

// ----------------------------------------------------------
//data writing

void myoOn(Myo.Event event, Device myo, long timestamp) {
 if(!p && s){
  switch(event) {
  case EMG_DATA:
   int[] emg = myo.getEmg();
   // println("myoOn EMG & Device: "+myo.getId());
    // int[] data =- 8 values from -128 to 127
    int[] data = myo.getEmg();
    for(int i = 0; i<data.length; i++){
      println(map(data[i], 0, 200, 0, 50)); // [-128 - 127] 
      for( i = 0; i < emg.length; i++) {
    emgWrite.print(emg[i] + ", " );    
  }
        for( int j = 0; j < emg.length; j++) {
           
          emgWrite.print(emg[j]*emg[j] + ", " );    
  
}
  
 emgWrite.println();

    break;
  }
  }
 }else{
 }
}
//-------------------------------------------------------------
public void play(){
println("abu");
p=!p;
}
public void save(){
println("abu1");
s=!s;
}
public void submit() {
  submit=!submit;
   if(!submit){
println(file.getText());
 emgWrite= createWriter(""+file.getText());
  }
}
