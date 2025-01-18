module ui

import lib.geom { Vec2 }

@[heap] @[UIC]
pub struct RimBox {
	Basic
	pub mut:
	typ          ComponentType         = .container
	// self         any                   = RimBox{}
	children     []Component
	
	margin       f64
}

// Formats it's chidlrens positions to fit into the VBox
pub fn (mut rimbox RimBox) format() {
	// Format position of children
	for mut c in rimbox.children {
		if mut c is Container {
			c.format()
		}
	}
	
	// Make sure, that position and size match the RimBox position and size
	for mut c in rimbox.children {
		m := Vec2{rimbox.margin, rimbox.margin}
		c.pos = rimbox.pos + m
		c.size = rimbox.size - m - m
	}
}


pub fn (mut rimbox RimBox) apply_style(style Style) {
	apply_style_to_type(mut rimbox, style, rimbox.classes)
}