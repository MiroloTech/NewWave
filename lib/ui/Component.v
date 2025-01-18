module ui

import gg

import lib.geom { Vec2 }

// Basic UI Component struct, used for embedding in every other UI Component
pub struct Basic {
	pub mut:
	class        string
	pos          Vec2
	size         Vec2
}

pub fn (mut basic Basic) apply_style(style Style) {
	apply_style_to_type(mut basic, style)
}




pub interface Component {
	mut:
	pos          Vec2
	size         Vec2
	class        string               // TODO : Implement this with styling
	typ          ComponentType
	
	apply_style(style Style)
}

pub enum ComponentType {
	container
	object
	reactor
}




pub interface Container {
	Component
	
	mut:
	children     []Component
	
	format() // Command to adjust all child's positions and sizes to match the type of Container
}

pub interface Object {
	Component
	
	draw(mut &gg.Context)
}

pub interface Reactor {
	Component
	
	draw(mut &gg.Context)
	
	mut:
	update(mut &gg.Context)
}