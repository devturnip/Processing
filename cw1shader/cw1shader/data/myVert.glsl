uniform mat4 transform;

attribute vec4 vertex;
attribute vec4 color;

varying vec4 col;

uniform float translateX;
uniform float translateY;
uniform float translateZ;

uniform float scaleX;
uniform float scaleY;
uniform float scaleZ;

uniform float angleX;
uniform float angleY;
uniform float angleZ;

void main(){

	mat4 translate = mat4(1.0, 0.0, 0.0, translateX,
                              0.0, 1.0, 0.0, translateY,
                              0.0, 0.0, 1.0, translateZ,
                              0.0, 0.0, 0.0, 1.0);
        translate = transpose(translate);
    
	mat4 scale = mat4(scaleX, 0.0, 0.0, 0.0,
                          0.0, scaleY, 0.0, 0.0,
                          0.0, 0.0, scaleZ, 0.0,
                          0.0, 0.0, 0.0, 1.0);

	mat4 rotate_x = mat4(1.0, 0.0, 0.0, 0.0,
						0.0, cos(angleX), sin(angleX), 0.0,
						0.0, sin(angleX), cos(angleX), 0.0,
						0.0, 0.0, 0.0, 1.0);
		rotate_x = transpose(rotate_x);
		
	mat4 rotate_y = mat4(cos(angleY), 0.0, sin(angleY), 0.0,
						0.0, 1.0, 0.0, 0.0,
						-sin(angleY), 0.0, cos(angleY), 0.0,
						0.0, 0.0, 0.0, 1.0);
		rotate_y = transpose(rotate_y);
		
	mat4 rotate_z = mat4(cos(angleZ), -sin(angleZ), 0.0, 0.0,
						sin(angleZ), cos(angleZ), 0.0, 0.0,
						0.0, 0.0, 1.0, 0.0,
						0.0, 0.0, 0.0, 1.0);
		rotate_z = transpose(rotate_z);

	gl_Position = (transform*translate*scale*rotate_x*rotate_y*rotate_z*vertex);
	col = color;


}