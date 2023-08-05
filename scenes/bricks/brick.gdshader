shader_type canvas_item;

uniform float hits;
uniform sampler2D cracks;
uniform vec4 region_rect;
uniform bool region = false;

vec2 uv_to_region_uv(vec2 uv, vec2 texture_pixel_size) {
	return (uv-(region_rect.xy*texture_pixel_size))/(region_rect.zw*texture_pixel_size);
}

vec2 region_uv_to_uv(vec2 region_uv, vec2 texture_pixel_size) {
	return (region_rect.xy*texture_pixel_size)+region_uv*(region_rect.zw*texture_pixel_size);
}

void fragment() {
	vec2 sampler_uv = UV;
	if (region) {
		sampler_uv = uv_to_region_uv(UV, TEXTURE_PIXEL_SIZE);
	}
	float alpha = texture(cracks, sampler_uv).a;
	vec4 texture_color = texture(TEXTURE, UV);
	if (alpha > 0.0) {
		COLOR = mix(texture_color, vec4(texture_color.rgb * 0.6, texture_color.a), hits);
	} else {
		COLOR = texture_color;
	}
}
