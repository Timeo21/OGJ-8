shader_type canvas_item;
uniform float t = 0.9;

void fragment(){
	COLOR = texture(TEXTURE, UV); // Read from texture again.
	COLOR.a *= (max(UV.y, 1.0-t) - 1.0 + t) / t;
} 