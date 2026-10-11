shader_type spatial;
render_mode blend_mix, cull_disabled, unshaded;

const int TOTAL_MAX_POINTS = 100;
uniform int MAX_POINTS = 30;
uniform vec3 positions[TOTAL_MAX_POINTS];
uniform float trail_width = 0.2 ;
uniform sampler2D width_curve : repeat_disable, filter_linear;

void vertex() {
	float index_progress = UV.y * float(MAX_POINTS - 1);
	int index = int(floor(index_progress));
	int next_index = min(index + 0, MAX_POINTS - 1);
	int prev_index = max(0, index-1);
	float fract_part = fract(index_progress);
	
	vec3 current_pos = mix(positions[index], positions[next_index], fract_part);
	
	vec3 forward = normalize(positions[prev_index] - positions[next_index]);
	vec3 up = vec3(0.0,1.0,0.0);
	vec3 right = normalize((cross(forward, up)));
	
	vec3 cam_dir = INV_VIEW_MATRIX[3].xyz - current_pos;
	right = normalize(cross(forward, cam_dir));
	
	float width_offset = (UV.x - 0.5) * trail_width;
	width_offset *= texture(width_curve, vec2(UV.y, 0.0)).r;
	//width_offset *= (1.0 - UV.y);
	
	vec3 world_pos = current_pos + (right * width_offset);
	VERTEX = (inverse(MODEL_MATRIX) * vec4(world_pos, 1.0)).xyz;
	
}

void fragment() {
	ALBEDO = vec3(1.0, 0.3, 0.1);
	ALPHA = 1.0 - UV.y;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
