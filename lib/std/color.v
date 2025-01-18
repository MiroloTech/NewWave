module std

import math  { max, min }
import gx
import term.ui as tui

const hex_chars = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f']


// TODO : Add conversions : rgb - hsv , rgb - lab , rgb - hex , rgb - ... ( cmyk )


pub struct Color {
	// BUILTIN
	// https://docs.godotengine.org/en/stable/classes/class_color.html
	/*
	pub:
	NONE                      Color = Color{-1,         -1,         -1,         -1}
	ALICE_BLUE                Color = Color{0.941176,   0.972549,   1,          1}
	ANTIQUE_WHITE             Color = Color{0.980392,   0.921569,   0.843137,   1}
	AQUA                      Color = Color{0,          1,          1,          1}
	AQUAMARINE                Color = Color{0.498039,   1,          0.831373,   1}
	AZURE                     Color = Color{0.941176,   1,          1,          1}
	BEIGE                     Color = Color{0.960784,   0.960784,   0.862745,   1}
	BISQUE                    Color = Color{1,          0.894118,   0.768627,   1}
	BLACK                     Color = Color{0,          0,          0,          1}
	BLANCHED_ALMOND           Color = Color{1,          0.921569,   0.803922,   1}
	BLUE                      Color = Color{0,          0,          1,          1}
	BLUE_VIOLET               Color = Color{0.541176,   0.168627,   0.886275,   1}
	BROWN                     Color = Color{0.647059,   0.164706,   0.164706,   1}
	BURLYWOOD                 Color = Color{0.870588,   0.721569,   0.529412,   1}
	CHARTREUSE                Color = Color{0.498039,   1,          0,          1}
	CHOCOLATE                 Color = Color{0.823529,   0.411765,   0.117647,   1}
	CORAL                     Color = Color{1,          0.498039,   0.313726,   1}
	CORNFLOWER_BLUE           Color = Color{0.392157,   0.584314,   0.929412,   1}
	CORNSILK                  Color = Color{1,          0.972549,   0.862745,   1}
	CRIMSON                   Color = Color{0.862745,   0.0784314,  0.235294,   1}
	CYAN                      Color = Color{0,          1,          1,          1}
	DARK_BLUE                 Color = Color{0,          0,          0.545098,   1}
	DARK_CYAN                 Color = Color{0,          0.545098,   0.545098,   1}
	DARK_GOLDENROD            Color = Color{0.721569,   0.52549,    0.0431373,  1}
	DARK_GRAY                 Color = Color{0.662745,   0.662745,   0.662745,   1}
	DARK_GREEN                Color = Color{0,          0.392157,   0,          1}
	DARK_KHAKI                Color = Color{0.741176,   0.717647,   0.419608,   1}
	DARK_MAGENTA              Color = Color{0.545098,   0,          0.545098,   1}
	DARK_OLIVE_GREEN          Color = Color{0.333333,   0.419608,   0.184314,   1}
	DARK_ORANGE               Color = Color{1,          0.54902,    0,          1}
	DARK_ORCHID               Color = Color{0.6,        0.196078,   0.8,        1}
	DARK_RED                  Color = Color{0.545098,   0,          0,          1}
	DARK_SALMON               Color = Color{0.913725,   0.588235,   0.478431,   1}
	DARK_SEA_GREEN            Color = Color{0.560784,   0.737255,   0.560784,   1}
	DARK_SLATE_BLUE           Color = Color{0.282353,   0.239216,   0.545098,   1}
	DARK_SLATE_GRAY           Color = Color{0.184314,   0.309804,   0.309804,   1}
	DARK_TURQUOISE            Color = Color{0,          0.807843,   0.819608,   1}
	DARK_VIOLET               Color = Color{0.580392,   0,          0.827451,   1}
	DEEP_PINK                 Color = Color{1,          0.0784314,  0.576471,   1}
	DEEP_SKY_BLUE             Color = Color{0,          0.74902,    1,          1}
	DIM_GRAY                  Color = Color{0.411765,   0.411765,   0.411765,   1}
	DODGER_BLUE               Color = Color{0.117647,   0.564706,   1,          1}
	FIREBRICK                 Color = Color{0.698039,   0.133333,   0.133333,   1}
	FLORAL_WHITE              Color = Color{1,          0.980392,   0.941176,   1}
	FOREST_GREEN              Color = Color{0.133333,   0.545098,   0.133333,   1}
	FUCHSIA                   Color = Color{1,          0,          1,          1}
	GAINSBORO                 Color = Color{0.862745,   0.862745,   0.862745,   1}
	GHOST_WHITE               Color = Color{0.972549,   0.972549,   1,          1}
	GOLD                      Color = Color{1,          0.843137,   0,          1}
	GOLDENROD                 Color = Color{0.854902,   0.647059,   0.12549,    1}
	GRAY                      Color = Color{0.745098,   0.745098,   0.745098,   1}
	GREEN                     Color = Color{0,          1,          0,          1}
	GREEN_YELLOW              Color = Color{0.678431,   1,          0.184314,   1}
	HONEYDEW                  Color = Color{0.941176,   1,          0.941176,   1}
	HOT_PINK                  Color = Color{1,          0.411765,   0.705882,   1}
	INDIAN_RED                Color = Color{0.803922,   0.360784,   0.360784,   1}
	INDIGO                    Color = Color{0.294118,   0,          0.509804,   1}
	IVORY                     Color = Color{1,          1,          0.941176,   1}
	KHAKI                     Color = Color{0.941176,   0.901961,   0.54902,    1}
	LAVENDER                  Color = Color{0.901961,   0.901961,   0.980392,   1}
	LAVENDER_BLUSH            Color = Color{1,          0.941176,   0.960784,   1}
	LAWN_GREEN                Color = Color{0.486275,   0.988235,   0,          1}
	LEMON_CHIFFON             Color = Color{1,          0.980392,   0.803922,   1}
	LIGHT_BLUE                Color = Color{0.678431,   0.847059,   0.901961,   1}
	LIGHT_CORAL               Color = Color{0.941176,   0.501961,   0.501961,   1}
	LIGHT_CYAN                Color = Color{0.878431,   1,          1,          1}
	LIGHT_GOLDENROD           Color = Color{0.980392,   0.980392,   0.823529,   1}
	LIGHT_GRAY                Color = Color{0.827451,   0.827451,   0.827451,   1}
	LIGHT_GREEN               Color = Color{0.564706,   0.933333,   0.564706,   1}
	LIGHT_PINK                Color = Color{1,          0.713726,   0.756863,   1}
	LIGHT_SALMON              Color = Color{1,          0.627451,   0.478431,   1}
	LIGHT_SEA_GREEN           Color = Color{0.12549,    0.698039,   0.666667,   1}
	LIGHT_SKY_BLUE            Color = Color{0.529412,   0.807843,   0.980392,   1}
	LIGHT_SLATE_GRAY          Color = Color{0.466667,   0.533333,   0.6,        1}
	LIGHT_STEEL_BLUE          Color = Color{0.690196,   0.768627,   0.870588,   1}
	LIGHT_YELLOW              Color = Color{1,          1,          0.878431,   1}
	LIME                      Color = Color{0,          1,          0,          1}
	LIME_GREEN                Color = Color{0.196078,   0.803922,   0.196078,   1}
	LINEN                     Color = Color{0.980392,   0.941176,   0.901961,   1}
	MAGENTA                   Color = Color{1,          0,          1,          1}
	MAROON                    Color = Color{0.690196,   0.188235,   0.376471,   1}
	MEDIUM_AQUAMARINE         Color = Color{0.4,        0.803922,   0.666667,   1}
	MEDIUM_BLUE               Color = Color{0,          0,          0.803922,   1}
	MEDIUM_ORCHID             Color = Color{0.729412,   0.333333,   0.827451,   1}
	MEDIUM_PURPLE             Color = Color{0.576471,   0.439216,   0.858824,   1}
	MEDIUM_SEA_GREEN          Color = Color{0.235294,   0.701961,   0.443137,   1}
	MEDIUM_SLATE_BLUE         Color = Color{0.482353,   0.407843,   0.933333,   1}
	MEDIUM_SPRING_GREEN       Color = Color{0,          0.980392,   0.603922,   1}
	MEDIUM_TURQUOISE          Color = Color{0.282353,   0.819608,   0.8,        1}
	MEDIUM_VIOLET_RED         Color = Color{0.780392,   0.0823529,  0.521569,   1}
	MIDNIGHT_BLUE             Color = Color{0.0980392,  0.0980392,  0.439216,   1}
	MINT_CREAM                Color = Color{0.960784,   1,          0.980392,   1}
	MISTY_ROSE                Color = Color{1,          0.894118,   0.882353,   1}
	MOCCASIN                  Color = Color{1,          0.894118,   0.709804,   1}
	NAVAJO_WHITE              Color = Color{1,          0.870588,   0.678431,   1}
	NAVY_BLUE                 Color = Color{0,          0,          0.501961,   1}
	OLD_LACE                  Color = Color{0.992157,   0.960784,   0.901961,   1}
	OLIVE                     Color = Color{0.501961,   0.501961,   0,          1}
	OLIVE_DRAB                Color = Color{0.419608,   0.556863,   0.137255,   1}
	ORANGE                    Color = Color{1,          0.647059,   0,          1}
	ORANGE_RED                Color = Color{1,          0.270588,   0,          1}
	ORCHID                    Color = Color{0.854902,   0.439216,   0.839216,   1}
	PALE_GOLDENROD            Color = Color{0.933333,   0.909804,   0.666667,   1}
	PALE_GREEN                Color = Color{0.596078,   0.984314,   0.596078,   1}
	PALE_TURQUOISE            Color = Color{0.686275,   0.933333,   0.933333,   1}
	PALE_VIOLET_RED           Color = Color{0.858824,   0.439216,   0.576471,   1}
	PAPAYA_WHIP               Color = Color{1,          0.937255,   0.835294,   1}
	PEACH_PUFF                Color = Color{1,          0.854902,   0.72549,    1}
	PERU                      Color = Color{0.803922,   0.521569,   0.247059,   1}
	PINK                      Color = Color{1,          0.752941,   0.796078,   1}
	PLUM                      Color = Color{0.866667,   0.627451,   0.866667,   1}
	POWDER_BLUE               Color = Color{0.690196,   0.878431,   0.901961,   1}
	PURPLE                    Color = Color{0.627451,   0.12549,    0.941176,   1}
	REBECCA_PURPLE            Color = Color{0.4,        0.2,        0.6,        1}
	RED                       Color = Color{1,          0,          0,          1}
	ROSY_BROWN                Color = Color{0.737255,   0.560784,   0.560784,   1}
	ROYAL_BLUE                Color = Color{0.254902,   0.411765,   0.882353,   1}
	SADDLE_BROWN              Color = Color{0.545098,   0.270588,   0.0745098,  1}
	SALMON                    Color = Color{0.980392,   0.501961,   0.447059,   1}
	SANDY_BROWN               Color = Color{0.956863,   0.643137,   0.376471,   1}
	SEA_GREEN                 Color = Color{0.180392,   0.545098,   0.341176,   1}
	SEASHELL                  Color = Color{1,          0.960784,   0.933333,   1}
	SIENNA                    Color = Color{0.627451,   0.321569,   0.176471,   1}
	SILVER                    Color = Color{0.752941,   0.752941,   0.752941,   1}
	SKY_BLUE                  Color = Color{0.529412,   0.807843,   0.921569,   1}
	SLATE_BLUE                Color = Color{0.415686,   0.352941,   0.803922,   1}
	SLATE_GRAY                Color = Color{0.439216,   0.501961,   0.564706,   1}
	SNOW                      Color = Color{1,          0.980392,   0.980392,   1}
	SPRING_GREEN              Color = Color{0,          1,          0.498039,   1}
	STEEL_BLUE                Color = Color{0.27451,    0.509804,   0.705882,   1}
	TAN                       Color = Color{0.823529,   0.705882,   0.54902,    1}
	TEAL                      Color = Color{0,          0.501961,   0.501961,   1}
	THISTLE                   Color = Color{0.847059,   0.74902,    0.847059,   1}
	TOMATO                    Color = Color{1,          0.388235,   0.278431,   1}
	TRANSPARENT               Color = Color{1,          1,          1,          0}
	TURQUOISE                 Color = Color{0.25098,    0.878431,   0.815686,   1}
	VIOLET                    Color = Color{0.933333,   0.509804,   0.933333,   1}
	WEB_GRAY                  Color = Color{0.501961,   0.501961,   0.501961,   1}
	WEB_GREEN                 Color = Color{0,          0.501961,   0,          1}
	WEB_MAROON                Color = Color{0.501961,   0,          0,          1}
	WEB_PURPLE                Color = Color{0.501961,   0,          0.501961,   1}
	WHEAT                     Color = Color{0.960784,   0.870588,   0.701961,   1}
	WHITE                     Color = Color{1,          1,          1,          1}
	WHITE_SMOKE               Color = Color{0.960784,   0.960784,   0.960784,   1}
	YELLOW                    Color = Color{1,          1,          0,          1}
	YELLOW_GREEN              Color = Color{0.603922,   0.803922,   0.196078,   1}
	
	// STUFF
	*/
	pub mut:
	r  f64
	g  f64
	b  f64
	a  f64  = 1.0
}

// --- Custom Const. Conversions ---

// Creates and returns a Color instance constructed from hsv components, where h : 0 > 359 , s : 0 > 1 , v : 0 > 1
pub fn Color.hsv(h f64, s f64, v f64) Color {
	// Snap / mod values
	hh := math.fmod(h, 360.0)
	ss := math.clamp(s, 0.0, 1.0)
	vv := math.clamp(v, 0.0, 1.0)
	
	// https://www.rapidtables.com/convert/color/hsv-to-rgb.html
	c := vv * ss
	x := c * ( 1.0 - math.abs( math.fmod( hh / 60.0, 2.0) - 1.0 ) )
	m := vv - c
	
	mut r, mut g, mut b := 0.0, 0.0, 0.0
	if 0   <= hh && hh < 60    { r, g, b = c, x, 0 }
	if 60  <= hh && hh < 120   { r, g, b = x, c, 0 }
	if 120 <= hh && hh < 180   { r, g, b = 0, c, x }
	if 180 <= hh && hh < 240   { r, g, b = 0, x, c }
	if 240 <= hh && hh < 300   { r, g, b = x, 0, c }
	if 300 <= hh && hh < 360   { r, g, b = x, 0, c }
	
	rr, gg, bb := (r + m) , (g + m) , (b + m)
	
	return Color{ rr, gg, bb, 1.0 }
}

// Creates and returns a Color instance constructed from hsv components, where h : 0 > 359 , s : 0 > 1 , v : 0 > 1 , a : 0 > 1
pub fn Color.hsva(h f64, s f64, v f64, a f64) Color {
	mut c := Color.hsv(h, s, v)
	c.a = a
	return c
}

// Returns a color from the given r, g, b components ( a = 1.0 )
pub fn Color.rgb(r f64, g f64, b f64) Color {
	return Color { r, g, b, 1.0 }
}

// Returns a color from the given r, g, b, a components
pub fn Color.rgba(r f64, g f64, b f64, a f64) Color {
	return Color { r, g, b, a }
}

// a color from the given string hex - returns 
pub fn Color.hex(hex string) Color {
	// Remove Every unnescecarry charecter from hex
	mut clean_hex := ""
	
	for c in hex.bytes() {
		cc := c.ascii_str().to_lower()
		if cc in hex_chars {
			clean_hex += cc
		}
	}
	
	// Turn clean_hex into list of numbers :: FF20CD -> [15, 15, 2, 0, 12, 13]
	mut hex_bits := []int{len: clean_hex.len}
	
	for hid, h in clean_hex {
		mut id := hex_chars.index(h.ascii_str().to_lower())
		if id == -1 { id = 0 }
		hex_bits[hid] = id
	}
	
	// Split into type of conversions ( size of hex )
	if clean_hex.len == 8 { // FFFFFFFF
		return Color{
			f64(hex_bits[0] * 16 + hex_bits[1]) / 255.0,
			f64(hex_bits[2] * 16 + hex_bits[3]) / 255.0,
			f64(hex_bits[4] * 16 + hex_bits[5]) / 255.0,
			f64(hex_bits[6] * 16 + hex_bits[7]) / 255.0,
		}
	}
	if clean_hex.len == 6 { // FFFFFF
		return Color{
			f64(hex_bits[0] * 16 + hex_bits[1]) / 255.0,
			f64(hex_bits[2] * 16 + hex_bits[3]) / 255.0,
			f64(hex_bits[4] * 16 + hex_bits[5]) / 255.0,
			1.0
		}
	}
	if clean_hex.len == 4 { // FFFF
		return Color{
			f64(hex_bits[0] * 16) / 255.0,
			f64(hex_bits[1] * 16) / 255.0,
			f64(hex_bits[2] * 16) / 255.0,
			f64(hex_bits[3] * 16) / 255.0,
		}
	}
	if clean_hex.len == 3 { // FFF
		return Color{
			f64(hex_bits[0] * 16) / 255.0,
			f64(hex_bits[1] * 16) / 255.0,
			f64(hex_bits[2] * 16) / 255.0,
			1.0
		}
	}
	if clean_hex.len == 2 { // FF
		return Color{
			f64(hex_bits[0] * 16 + hex_bits[1]) / 255.0,
			f64(hex_bits[0] * 16 + hex_bits[1]) / 255.0,
			f64(hex_bits[0] * 16 + hex_bits[1]) / 255.0,
			1.0
		}
	}
	if clean_hex.len == 1 { // F
		return Color{
			f64(hex_bits[0] * 16) / 255.0,
			f64(hex_bits[0] * 16) / 255.0,
			f64(hex_bits[0] * 16) / 255.0,
			1.0
		}
	}
	
	// Return Black if hex is invalid
	return Color{0.0, 0.0, 0.0, 1.0}
}


// Returns the 8-bit variant of the r, g, b components
pub fn (c Color) get_rgb8() (u8, u8, u8) {
	return u8(c.r * 255.0), u8(c.g * 255.0), u8(c.b * 255.0)
}

// Returns the 8-bit variant of the r, g, b, a components
pub fn (c Color) get_rgba8() (u8, u8, u8, u8) {
	return u8(c.r * 255.0), u8(c.g * 255.0), u8(c.b * 255.0), u8(c.a * 255.0)
}

// Returns the color in the term.ui format
pub fn (c Color) get_tui() tui.Color {
	r, g, b := c.get_rgb8()
	return tui.Color{r, g, b}
}

// Returns the color in the gx format
pub fn (c Color) get_gx() gx.Color {
	r, g, b, a := c.get_rgba8()
	return gx.Color{r, g, b, a}
}


// --- Integrated modifiers / methods ---

// Returns a string type of the color
pub fn (c Color) str() string {
	return "(${c.r}, ${c.g}, ${c.b}, ${c.a})"
}

// Returns a clean, pretty version of the color > (0.1159, 0.0, 0.796, 1.0)  >>  ( 0.12, 0.00, 0.80, 1.00 )
pub fn (c Color) pretty_str() string {
	return "( ${c.r:2}, ${c.g:2}, ${c.b:2}, ${c.a:2} )"
}

// >> Utillity

// Returns a darkened ( and clamped ) copy of the orignal color, based on the given darking value
// This function excludes darkening of the alpha channel
pub fn (c Color) darken(v f64) Color {
	return Color{
		max(0.0, c.r - v)
		max(0.0, c.g - v)
		max(0.0, c.b - v)
		c.a
	}
}

// Returns a brightened ( and clamped ) copy of the orignal color, based on the given brighting value
// This function excludes brightening of the alpha channel
pub fn (c Color) brighten(v f64) Color {
	return Color{
		min(1.0, c.r + v)
		min(1.0, c.g + v)
		min(1.0, c.b + v)
		c.a
	}
}


// --- Blending ---

pub fn Color.blend_normal(a Color, b Color) Color {
	return Color{
		b.r,
		b.g,
		b.b,
		b.a
	}
}
pub fn Color.blend_multiply(a Color, b Color) Color {
	return Color{
		a.r * b.r,
		a.g * b.g,
		a.b * b.b,
		a.a * b.a
	}
}
pub fn Color.blend_screen(a Color, b Color) Color {
	return Color{
		1.0 - ( 1.0 - a.r ) * ( 1.0 - b.r ),
		1.0 - ( 1.0 - a.g ) * ( 1.0 - b.g ),
		1.0 - ( 1.0 - a.b ) * ( 1.0 - b.b ),
		1.0 - ( 1.0 - a.a ) * ( 1.0 - b.a ),
	}
}
pub fn Color.blend_overlay(a Color, b Color) Color {
	return Color{
		if a.r < 0.5  { 2.0 * a.r * b.r }  else  { 1.0 - 2.0 * ( 1.0 - a.r ) * ( 1.0 - b.r ) },
		if a.g < 0.5  { 2.0 * a.g * b.g }  else  { 1.0 - 2.0 * ( 1.0 - a.g ) * ( 1.0 - b.g ) },
		if a.b < 0.5  { 2.0 * a.b * b.b }  else  { 1.0 - 2.0 * ( 1.0 - a.b ) * ( 1.0 - b.b ) },
		if a.a < 0.5  { 2.0 * a.a * b.a }  else  { 1.0 - 2.0 * ( 1.0 - a.a ) * ( 1.0 - b.a ) },
	}
}
pub fn Color.blend_darken(a Color, b Color) Color {
	return Color{
		math.min(a.r, b.r),
		math.min(a.g, b.g),
		math.min(a.b, b.b),
		math.min(a.a, b.a),
	}
}
pub fn Color.blend_lighten(a Color, b Color) Color {
	return Color{
		math.max(a.r, b.r),
		math.max(a.g, b.g),
		math.max(a.b, b.b),
		math.max(a.a, b.a),
	}
}
pub fn Color.blend_dodge(a Color, b Color) Color {
	return Color{
		math.min(1.0, a.r / (1.0 - b.r)),
		math.min(1.0, a.g / (1.0 - b.g)),
		math.min(1.0, a.b / (1.0 - b.b)),
		math.min(1.0, a.a / (1.0 - b.a)),
	}
}
pub fn Color.blend_burn(a Color, b Color) Color {
	return Color{
		1.0 - math.min(1.0, (1.0 - a.r) / b.r),
		1.0 - math.min(1.0, (1.0 - a.g) / b.g),
		1.0 - math.min(1.0, (1.0 - a.b) / b.b),
		1.0 - math.min(1.0, (1.0 - a.a) / b.a),
	}
}
pub fn Color.blend_soft_light(a Color, b Color) Color {
	return Color{
		(a.r * b.r) + (a.r * a.r * (1.0 - 2.0 * b.r)),
		(a.g * b.g) + (a.g * a.g * (1.0 - 2.0 * b.g)),
		(a.b * b.b) + (a.b * a.b * (1.0 - 2.0 * b.b)),
		(a.a * b.a) + (a.a * a.a * (1.0 - 2.0 * b.a)),
	}
}
pub fn Color.blend_hard_light(a Color, b Color) Color {
	return Color{ // Color.blend_overlay(b, a)
		if b.r < 0.5  { 2.0 * b.r * a.r }  else  { 1.0 - 2.0 * ( 1.0 - b.r ) * ( 1.0 - a.r ) },
		if b.g < 0.5  { 2.0 * b.g * a.g }  else  { 1.0 - 2.0 * ( 1.0 - b.g ) * ( 1.0 - a.g ) },
		if b.b < 0.5  { 2.0 * b.b * a.b }  else  { 1.0 - 2.0 * ( 1.0 - b.b ) * ( 1.0 - a.b ) },
		if b.a < 0.5  { 2.0 * b.a * a.a }  else  { 1.0 - 2.0 * ( 1.0 - b.a ) * ( 1.0 - a.a ) },
	}
}
pub fn Color.blend_difference(a Color, b Color) Color {
	return Color{
		math.abs(a.r - b.r),
		math.abs(a.g - b.g),
		math.abs(a.b - b.b),
		math.abs(a.a - b.a),
	}
}
pub fn Color.blend_exclusion(a Color, b Color) Color {
	return Color{
		a.r + b.r - 2.0 * a.r * b.r,
		a.g + b.g - 2.0 * a.g * b.g,
		a.b + b.b - 2.0 * a.b * b.b,
		a.a + b.a - 2.0 * a.a * b.a,
	}
}
