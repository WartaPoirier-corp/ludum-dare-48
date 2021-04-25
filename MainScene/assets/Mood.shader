shader_type canvas_item;

uniform float mood : hint_range(0, 1);

// https://www.laurivan.com/rgb-to-hsv-to-rgb-for-shaders/ {

vec3 rgb2hsv(vec3 c) {
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

// }

void fragment() {
	vec3 color_rgb = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0).rgb;
	
	// Aberration
	
	float ab_lvl = (clamp(mood, 0.5, 1.) - 0.5) * 2.;
	
	float offset = 0.05 * pow(distance(SCREEN_UV, vec2(.5, .5)) / sqrt(2.), 1.5) + 0.001;
	offset *= ab_lvl;
	
	float r = textureLod(SCREEN_TEXTURE, SCREEN_UV - vec2(offset, 0), 0).r;
	float g = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0).g;
	float b = textureLod(SCREEN_TEXTURE, SCREEN_UV + vec2(offset, 0), 0).b;
	
	color_rgb = vec3(r, g, b);
	
	// Desat / saturation
	
	vec3 color_hsv = rgb2hsv(color_rgb);
	color_hsv.y *= (mood * 2.);
	
	float bad_lvl = 1. - clamp(2. * mood, 0., 1.);
	color_hsv.z *= 1. - bad_lvl * 0.5;
	
	color_rgb = hsv2rgb(color_hsv);
	
	COLOR = vec4(color_rgb, 1.0);
}