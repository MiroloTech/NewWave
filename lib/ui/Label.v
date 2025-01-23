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
	text         string                                                                @[nostyle]
	text_align   TextAlignmentH        = .left
	// TODO : Add alignment options
}

// Draws text in given size at given position
pub fn (label Label) draw(mut ctx gg.Context) {
	// TODO : Use 'ctx.set_text_style'
	ctx.set_text_cfg(
		color:            label.color.get_gx()
		size:             label.text_size
		vertical_align:   .middle
	)
	x_pos := match label.text_align {
		.left {
			0
		}
		.center {
			label.size.x / 2.0 - f64(ctx.text_width(label.text)) / 2.0
		}
		.right {
			label.size.x - f64(ctx.text_width(label.text))
		}
	}
	ctx.draw_text_default(
		int(label.pos.x + x_pos), int(label.pos.y + label.size.y * 0.5),
		label.text,
		// max_width:   int(label.size.x)
	)
}


pub fn (mut label Label) apply_style(style Style) {
	apply_style_to_type(mut label, style, label.classes)
}
