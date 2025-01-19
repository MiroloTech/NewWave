module ui

import lib.geom { Vec2 }

@[heap] @[UIC]
pub struct VBox {
	Basic
	pub mut:
	typ          ComponentType         = .container
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
	
	mut y_offset := 0.0
	
	// Clamp all overlapping components in HBox
	for mut c in vbox.children {
		if y_offset + c.size.y > vbox.size.y {
			c.size.y = vbox.size.y - y_offset
			if c.size.y < 0.0 { c.size.y = 0.0 }
		}
		y_offset += c.size.y + vbox.margin
	}
	
	// Sort by Y offset
	y_offset = 0.0
	for mut c in vbox.children {
		c.pos = vbox.pos + Vec2{0.0, y_offset}
		c.size.x = vbox.size.x
		y_offset += c.size.y + vbox.margin
	}
}


pub fn (mut vbox VBox) apply_style(style Style) {
	apply_style_to_type(mut vbox, style, vbox.classes)
}
