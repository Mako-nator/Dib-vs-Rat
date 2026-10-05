shader_type canvas_item;

// Ajusta este color al del fondo que quieres quitar (usa el selector de color)
uniform vec4 color_a_quitar : source_color = vec4(0.169, 0.184, 0.271, 1.0);
uniform float tolerancia : hint_range(0.0, 1.0) = 0.05;

void fragment() {
	vec4 tex_color = texture(TEXTURE, UV);
	float distancia = distance(tex_color.rgb, color_a_quitar.rgb);
	if (distancia < tolerancia) {
		tex_color.a = 0.0;
	}
	COLOR = tex_color;
}