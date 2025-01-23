module ui

import gg
import sokol.sapp

import lib.std { Color }

@[heap] @[UIC]
pub struct Button {
	Basic
	pub mut:
	typ                       ComponentType      = .reactor
	
	rounding                  f64
	margin                    f64
	
	text_color_normal         Color
	text_color_hover          Color
	text_color_pressed        Color
	
	bg_color_normal           Color
	bg_color_hover            Color
	bg_color_pressed          Color
	
	pressed                   bool                                                       @[nostyle]
	hovering                  bool                                                       @[nostyle]
	last_mouse_mode           bool                                                       @[nostyle]
	pressed_fn                fn ()              = unsafe { nil }
	hovering_fn               fn ()              = unsafe { nil }
	
	text_size                 int
	text_align                TextAlignmentH     = .left
	text                      string                                                     @[nostyle]
	
	text_color                Color
	bg_color                  Color
	
	// TODO : Add alignment options
}

// Draws text in given size at given position
pub fn (button Button) draw(mut ctx gg.Context) {
	// Button BG
	ctx.draw_rounded_rect_filled(
		f32(button.pos.x), f32(button.pos.y),
		f32(button.size.x), f32(button.size.y),
		f32(button.rounding),
		button.bg_color.get_gx()
	)
	
	// Button Text
	// TODO : Use 'ctx.set_text_style'
	ctx.set_text_cfg(
		color:            button.text_color.get_gx()
		size:             button.text_size
		vertical_align:   .middle
	)
	x_pos := match button.text_align {
		.left {
			button.margin
		}
		.center {
			button.size.x / 2.0 - f64(ctx.text_width(button.text)) / 2.0
		}
		.right {
			button.size.x - f64(ctx.text_width(button.text)) - button.margin
		}
	}
	ctx.draw_text_default(
		int(button.pos.x + x_pos), int(button.pos.y + button.size.y * 0.5),
		button.text
		// max_width:   int(label.size.x)
	)
}

pub fn (mut button Button) update(mut ctx gg.Context) {
	button.text_color = button.text_color_normal
	button.bg_color = button.bg_color_normal
	
	button.hovering = mouse_hover(Component(button), mut ctx)
		
	if button.hovering {
		sapp.set_mouse_cursor(.pointing_hand)
		if button.hovering_fn != unsafe { nil } {
			button.hovering_fn()
		}
		button.text_color = button.text_color_hover
		button.bg_color = button.bg_color_hover
		
		button.pressed = ctx.mouse_buttons == .left
	} else {
		button.pressed = false
	}
	
	if button.pressed {
		button.text_color = button.text_color_pressed
		button.bg_color = button.bg_color_pressed
	}
	
	if button.pressed && button.last_mouse_mode == false {
		if button.pressed_fn != unsafe { nil } {
			button.pressed_fn()
		}
	}
	
	button.last_mouse_mode = ctx.mouse_buttons == .left
}

pub fn (mut button Button) event(_ &gg.Event) {  }


pub fn (mut button Button) apply_style(style Style) {
	apply_style_to_type(mut button, style, button.classes)
}