PShader myShader;
import peasy.*;
import g4p_controls.*;

public PeasyCam cam;
PShape shape;

int shapeType=1;//1=box, 2=donut, 3=customshape

float rax=0.0, ray=0.0, raz=0.0;
int tax,tay,taz;
float sax=1.0,say=1.0,saz=1.0;

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

void setup(){
  size(1024,768,P3D);
  myShader = loadShader("myFrag.glsl", "myVert.glsl");
  
  if (shapeType==2){
    shape = getTorus(60,30,32,32);
  } else if (shapeType==3){
    shape = loadShape("test1.obj");
  } 
  
  G4P.setGlobalColorScheme(GCScheme.GREEN_SCHEME);
  
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
  sl1.setLimits(1.0, 1.0, 5.0);
  sl1.setShowTicks(false);
  
  sl2 = new GSlider(this, 10, 42, 280, 20, 13);
  sl2.setLimits(1.0, 1.0, 5.0);
  sl2.setShowTicks(false);
  
  sl3 = new GSlider(this, 10, 62, 280, 20, 13);
  sl3.setLimits(1.0, 1.0, 5.0);
  sl3.setShowTicks(false);
  
  panels.addControl(sl1);
  panels.addControl(sl2);
  panels.addControl(sl3);
  //GUI portion end
  
  cam = new PeasyCam(this,400);
  
  
}

void draw(){
  shader(myShader);

  myShader.set("translateX", tax*1.0);
  myShader.set("translateY", tay*1.0);
  myShader.set("translateZ", taz*1.0);
  myShader.set("scaleX", sax);
  myShader.set("scaleY", say);
  myShader.set("scaleZ", saz);
  
  //since the slider values range from -180 to 180, multiplying the slider by 0.02
  //causes the rotation to be more gradual.
  myShader.set("angleX", rax*0.02); 
  myShader.set("angleY", ray*0.02);
  myShader.set("angleZ", raz*0.02);
  
  background(0);
  noStroke();
  
  if(shapeType!=1){
  shape(shape);
  } else {
    box(50);
  }
  
  resetShader(); //important to ensure that the shader code does not process the GUI elements
  
  if (panel.isCollapsed() && panelt.isCollapsed() && panels.isCollapsed())
      cam.setActive(!panel.isDragging());
  else if (!panel.isCollapsed() || !panelt.isCollapsed() || !panels.isCollapsed())
  cam.setActive(false);
  

  
}

void handleSliderEvents(GValueControl slider, GEvent event) {
  
  if (slider == s1)
  rax =  slider.getValueI();
  
  if (slider == s2)
  ray =  slider.getValueI();
  
  if (slider == s3)
  raz =  slider.getValueI();
  
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

//BEGIN DONUT
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