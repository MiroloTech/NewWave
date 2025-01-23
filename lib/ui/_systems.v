module ui

import gg

pub enum TextAlignmentH as int {
	left
	center
	right
}

// This script contains several utillity functions for different UI Components, mainly for type Component itself, to handle certain UI Events

// Returns true, if the current mouse position is inside the Components area
pub fn mouse_hover(obj Component, mut ctx gg.Context) bool {
	tl := f64(ctx.mouse_pos_x) > obj.pos.x               &&  f64(ctx.mouse_pos_y) > obj.pos.y
	br := f64(ctx.mouse_pos_x) < obj.pos.x + obj.size.x  &&  f64(ctx.mouse_pos_y) < obj.pos.y + obj.size.y
	return tl && br
}
