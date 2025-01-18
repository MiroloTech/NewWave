module ui

import lib.geom { Vec2 }

@[heap] @[UIC]
pub struct HBox {
	Basic
	pub mut:
	typ          ComponentType         = .container
	// self         any                   = VBox{}
	children     []Component
	
	margin       f64
}

// Formats it's chidlrens positions to fit into the VBox
pub fn (mut hbox HBox) format() {
	// Format position of children
	for mut c in hbox.children {
		if mut c is Container {
			c.format()
		}
	}
	
	// Sort by Y offset
	mut x_offset := 0.0
	for mut c in hbox.children {
		c.pos = hbox.pos + Vec2{x_offset, 0.0}
		c.size.y = hbox.size.y
		x_offset += c.size.x + hbox.margin
	}
}


pub fn (mut hbox HBox) apply_style(style Style) {
	apply_style_to_type(mut hbox, style, hbox.classes)
}
