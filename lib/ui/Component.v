module ui

import gg

import lib.geom { Vec2 }

// Basic UI Component struct, used for embedding in every other UI Component
pub struct Basic {
	pub mut:
	classes      []string               @[nostyle]
	ref          string                 @[nostyle]
	pos          Vec2                   @[nostyle]
	size         Vec2                   @[nostyle]
}

pub fn (mut basic Basic) apply_style(style Style) {
	apply_style_to_type(mut basic, style, basic.classes)
}




pub interface Component {
	mut:
	pos          Vec2
	size         Vec2
	ref          string
	classes      []string
	typ          ComponentType
	
	apply_style(Style)
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
	
	draw(mut gg.Context)
}

pub interface Reactor {
	Component
	
	draw(mut gg.Context)
	
	mut:
	update(mut gg.Context)
	event(&gg.Event)
}