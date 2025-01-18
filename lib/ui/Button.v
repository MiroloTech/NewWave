module ui

import gg
import sokol.sapp

import lib.std { Color }


@[heap] @[UIC]
pub struct Button {
	Basic
	pub mut:
	typ                       ComponentType         = .reactor
	// self         any                   = Label{}
	
	rounding                  f64
	margin                    f64
	
	text_color_normal         Color
	text_color_hover          Color
	text_color_pressed        Color
	
	bg_color_normal           Color
	bg_color_hover            Color
	bg_color_pressed          Color
	
	pressed                   bool
	pressed_fn                fn ()              = unsafe { nil }
	
	text_size                 int
	text                      string
	
	text_color                Color
	bg_color                  Color
	
	// TODO : Add alignment options
}

// Draws text in given size at given position
pub fn (button Button) draw(mut ctx &gg.Context) {
	ctx.draw_rounded_rect_filled(
		f32(button.pos.x), f32(button.pos.y),
		f32(button.size.x), f32(button.size.y),
		f32(button.rounding),
		button.bg_color.get_gx()
	)
	ctx.draw_text(
		int(button.pos.x + button.margin), int(button.pos.y + button.size.y * 0.5),
		button.text,
		color:            button.text_color.get_gx()
		size:             button.text_size
		vertical_align:   .middle
		// max_width:   int(label.size.x)
	)
}

pub fn (mut button Button) update(mut ctx &gg.Context) {
	button.text_color = button.text_color_normal
	button.bg_color = button.bg_color_normal
	
	if mouse_hover(Component(button), mut ctx) {
		sapp.set_mouse_cursor(.pointing_hand)
		if ctx.mouse_buttons == .left {
			button.text_color = button.text_color_pressed
			button.bg_color = button.bg_color_pressed
			
			if !button.pressed && button.pressed_fn != unsafe { nil } {
				button.pressed_fn()
			}
			button.pressed = true
		} else {
			button.text_color = button.text_color_hover
			button.bg_color = button.bg_color_hover
			button.pressed = false
		}
	} else {
		button.pressed = false
	}
}


pub fn (mut button Button) apply_style(style Style) {
	apply_style_to_type(mut button, style, button.classes)
}