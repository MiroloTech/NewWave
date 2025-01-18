module ui

import lib.geom { Vec2 }

@[heap] @[UIC]
pub struct VBox {
	Basic
	pub mut:
	typ          ComponentType         = .container
	// self         any                   = VBox{}
	children     []Component
	
	margin       f64
}

// Formats it's chidlrens positions to fit into the VBox
pub fn (mut vbox VBox) format() {
	// Format position of children
	for mut c in vbox.children {
		if mut c is Container {
			c.format()
		}
	}
	
	// Sort by Y offset
	mut y_offset := 0.0
	for mut c in vbox.children {
		c.pos = vbox.pos + Vec2{0.0, y_offset}
		c.size.x = vbox.size.x
		y_offset += c.size.y + vbox.margin
	}
}


pub fn (mut vbox VBox) apply_style(style Style) {
	apply_style_to_type(mut vbox, style)
}
