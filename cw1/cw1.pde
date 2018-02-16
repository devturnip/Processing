import g4p_controls.*;

import peasy.*;

public PeasyCam cam;

int shapetype=1; // 1=box, 2=donut, 3=customshape, 
//change this int for the different shapes!

//GUI for panel to hold sliders
GPanel panel;
GPanel panelt;
GPanel panels;

//GUI sliders for rotation
GSlider s1;
GSlider s2;
GSlider s3;

//GUI sliders for translation
GSlider t1;
GSlider t2;
GSlider t3;

//GUI sliders for scaling
GSlider sl1;
GSlider sl2;
GSlider sl3;

float[] camRotation = new float[3];

//xyz values for peasycam
int ax,ay,az,bx,by,bz;

//store the value of the slider positions for translate GUI
int tax,tay,taz;

//stores the value of slider positions for scale GUI
int sax,say,saz;

boolean scaleCheck = false;

public void settings() {
  size(1024, 768, P3D);
}

public void setup() {
  
  //GUI portion begin
  panel = new GPanel(this, 50, 600, 300, 90, "Rotate");
  panel.setCollapsed(true);
  s1 = new GSlider(this, 10, 22, 280, 20, 13);
  s1.setLimits(0, -180, 180);
  s1.setShowTicks(false);
  
  s2 = new GSlider(this, 10, 42, 280, 20, 13);
  s2.setLimits(0, -180, 180);
  s2.setShowTicks(false);
  
  s3 = new GSlider(this, 10, 62, 280, 20, 13);
  s3.setLimits(0, -180, 180);
  s3.setShowTicks(false);
  
  panel.addControl(s1);
  panel.addControl(s2);
  panel.addControl(s3);
  
  panelt = new GPanel(this, 350, 600, 300, 90, "Translate");
  panelt.setCollapsed(true);
  t1 = new GSlider(this, 10, 22, 280, 20, 13);
  t1.setLimits(0, -300, 300);
  t1.setShowTicks(false);
  
  t2 = new GSlider(this, 10, 42, 280, 20, 13);
  t2.setLimits(0, -300, 300);
  t2.setShowTicks(false);
  
  t3 = new GSlider(this, 10, 62, 280, 20, 13);
  t3.setLimits(0, -300, 300);
  t3.setShowTicks(false);
  
  panelt.addControl(t1);
  panelt.addControl(t2);
  panelt.addControl(t3);
  
  panels = new GPanel(this, 700, 600, 300, 90, "Scale");
  panels.setCollapsed(true);
  sl1 = new GSlider(this, 10, 22, 280, 20, 13);
  sl1.setLimits(1, 1, 5);
  sl1.setShowTicks(false);
  
  sl2 = new GSlider(this, 10, 42, 280, 20, 13);
  sl2.setLimits(1, 1, 5);
  sl2.setShowTicks(false);
  
  sl3 = new GSlider(this, 10, 62, 280, 20, 13);
  sl3.setLimits(1, 1, 5);
  sl3.setShowTicks(false);
  
  panels.addControl(sl1);
  panels.addControl(sl2);
  panels.addControl(sl3);
  //GUI portion end
  
  cam = new PeasyCam(this, 400);
  
}

public void draw(){
  background(255);
  
  //if else for determining if panel is open and disabling peasycam is panel is open
  if (panel.isCollapsed() && panelt.isCollapsed() && panels.isCollapsed())
      cam.setActive(!panel.isDragging());
  else if (!panel.isCollapsed() || !panelt.isCollapsed() || !panels.isCollapsed())
  cam.setActive(false);
  
  if (!panels.isCollapsed()){
    scaleCheck=true;
    scale(1,1,1);
  }

  strokeWeight(5);
  
  //translate the object based on the translate xyz slider values
  translate(tax,tay,taz);
  if (scaleCheck == false){
    //scale(1,1,1);
  }
  else if (scaleCheck == true){
    scale(sax,say,saz);
  }
  
  //Determine which shape to use by on int values 1,2,3
  //1 for box, 2 for donut, 3 for custom shape
  if (shapetype==1){
    box(100);
  } else if (shapetype==2){
    PShape torus = getTorus(50,20,32,32);
    torus.setFill(color(48,150,200));
    shape(torus);
  } else if (shapetype==3){
    PShape N = loadShape("test1.obj");
    shape(N);

  }

  //store rotation values
  camRotation = cam.getRotations();
  for (int i=0; i<camRotation.length; i++){
    //System.out.println(camRotation[i]);
  }
  
  //set of if else to match sliders to peasycam last known rotation values
  //and to rotate based on slider values.
  //note rotation is actually the movement of the camera
  if (panel.isCollapsed()){
    ax = bx = (int)Math.toDegrees(camRotation[0]);
    s1.setValue((int)Math.toDegrees(camRotation[0]));
    
    ay = by = (int)Math.toDegrees(camRotation[1]);
    s2.setValue((int)Math.toDegrees(camRotation[1]));
    
    az = bz = (int)Math.toDegrees(camRotation[2]);
    s3.setValue((int)Math.toDegrees(camRotation[2]));
  }
  else {
    if(ax!=bx){
      cam.rotateX(Math.toRadians(ax-bx));
      bx = ax;
    }
    else if(ay!=by){
      cam.rotateY(Math.toRadians(ay-by));
      by = ay;
    }
    else if(az!=bz){
      cam.rotateZ(Math.toRadians(az-bz));
      bz = az;
    }
  }


}

void handleSliderEvents(GValueControl slider, GEvent event) {
  
  if (slider == s1)
  ax =  slider.getValueI();
  
  if (slider == s2)
  ay =  slider.getValueI();
  
  if (slider == s3)
  az =  slider.getValueI();
  
  if (slider == t1)
  tax = slider.getValueI();
  
  if (slider == t2)
  tay = slider.getValueI();
  
  if (slider == t3)
  taz = slider.getValueI();
  
  if (slider == sl1)
  sax = slider.getValueI();
  
  if (slider == sl2)
  say = slider.getValueI();
  
  if (slider == sl3)
  saz = slider.getValueI();

}

//DONUT BEGIN
PShape getTorus(float outerRad, float innerRad, int numc, int numt) {

  PShape sh = createShape();
  sh.beginShape(TRIANGLE_STRIP);
  sh.noStroke();

  float x, y, z, s, t, u, v;
  float nx, ny, nz;
  float a1, a2;
  int idx = 0;
  for (int i = 0; i < numc; i++) {
    for (int j = 0; j <= numt; j++) {
      for (int k = 1; k >= 0; k--) {
         s = (i + k) % numc + 0.5;
         t = j % numt;
         u = s / numc;
         v = t / numt;
         a1 = s * TWO_PI / numc;
         a2 = t * TWO_PI / numt;
 
         x = (outerRad + innerRad * cos(a1)) * cos(a2);
         y = (outerRad + innerRad * cos(a1)) * sin(a2);
         z = innerRad * sin(a1);
 
         nx = cos(a1) * cos(a2); 
         ny = cos(a1) * sin(a2);
         nz = sin(a1);
         sh.normal(nx, ny, nz);
         sh.vertex(x, y, z);
         
      }
    }
  }
   sh.endShape(); 
  return sh;
}
//DONUT END