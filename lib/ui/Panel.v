module ui

import gg

import lib.std { Color }


@[heap] @[UIC]
pub struct Panel {
	Basic
	pub mut:
	typ          ComponentType         = .object
	
	color        Color
	rounding     f64
}

// Draws a styleized rectangle panel at given position and size
pub fn (panel Panel) draw(mut ctx gg.Context) {
	ctx.draw_rounded_rect_filled(
		f32(panel.pos.x), f32(panel.pos.y),
		f32(panel.size.x), f32(panel.size.y),
		f32(panel.rounding),
		panel.color.get_gx()
	)
}

pub fn (mut panel Panel) apply_style(style Style) {
	apply_style_to_type(mut panel, style, panel.classes)
}
