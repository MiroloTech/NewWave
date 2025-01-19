module ui

import gg

import lib.std { Color }


@[heap] @[UIC]
pub struct Label {
	Basic
	pub mut:
	typ          ComponentType         = .object
	
	color        Color
	text_size    int
	text         string
	// TODO : Add alignment options
}

// Draws text in given size at given position
pub fn (label Label) draw(mut ctx &gg.Context) {
	ctx.draw_text(
		int(label.pos.x), int(label.pos.y + label.size.y * 0.5),
		label.text,
		color:       label.color.get_gx()
		size:        label.text_size
		vertical_align:   .middle
		// max_width:   int(label.size.x)
	)
}


pub fn (mut label Label) apply_style(style Style) {
	apply_style_to_type(mut label, style, label.classes)
}
