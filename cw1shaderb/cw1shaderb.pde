PShape man;
PShader myShader;
float angle=0.0;

void setup(){
  size(1024, 768, P3D);
  man = loadShape("test1.obj");
  man.scale(4);
  myShader = loadShader("squareFrag.glsl", "squareVert.glsl");
}

void draw(){
  background(0);
  translate(width/2, height/2);
  shader(myShader);  
  rotateY(angle);

  angle+=0.05;
  myShader.set("angle", angle);
 
  shape(man);
  
}