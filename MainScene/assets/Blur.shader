shader_type canvas_item;

uniform float sharp_radius : hint_range(0, 1) = 0.25;
uniform float inv_strength = 20.;

const float PI = 3.14159265358979323846;
const float PI2 = 2. * PI;

void fragment() {
    float b_dir = 16.0;
    float b_quality = 8.0;
   
	float r = clamp(distance(SCREEN_UV, vec2(.5, .5)) - sharp_radius, 0., 1.);
    vec2 radius = vec2(r, r) / inv_strength;

    vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV, 0);
    
	int it = 0;
	
    for (float d = 0.; d < PI; d += PI2 / b_dir) {
		for (float i = 1. / b_quality; i <= 1.; i += 1. / b_quality) {
			color += textureLod(SCREEN_TEXTURE, SCREEN_UV + vec2(cos(d), sin(d)) * radius * i, 0);
			it += 1;
        }
    }
    
    COLOR = color / float(it);
}
