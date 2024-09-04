shader_type canvas_item;

uniform vec3 color : source_color;
uniform float transparency : hint_range(0.0, 1.0, 0.01);
//uniform vec3 ignored_color : source_color;
uniform float intensity : hint_range(0.0, 1.0, 0.01);

void fragment() {
	vec4 tex_color = texture( TEXTURE, UV );
	COLOR.rgb = mix( tex_color.rgb, color, intensity );
	COLOR.a = tex_color.a - transparency;
}
