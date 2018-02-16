attribute vec4 vertex;
attribute vec4 color;
attribute vec3 normal;

varying vec4 col;
uniform mat4 transform;
uniform float angle;


void main(){
	vec4 tempVert = vertex.xyzw;
    
    tempVert.z = vertex.z+20*angle;
	
	mat4 scale = mat4(angle/5, 0.0, 0.0, 0.0,
                          0.0, angle/5, 0.0, 0.0,
                          0.0, 0.0, 1.0, 0.0,
                          0.0, 0.0, 0.0, 1.0);
    
    tempVert.y = vertex.y;
    tempVert.x = vertex.x;
		
	gl_Position = transform*tempVert*scale;

	col = color;
	
}
	