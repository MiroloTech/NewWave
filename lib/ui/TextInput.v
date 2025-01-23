module ui

import gg
import sokol.sapp

import lib.std { Color }

@[heap] @[UIC]
pub struct TextInput {
	Basic
	pub mut:
	typ                       ComponentType      = .reactor
	
	rounding                  f64
	margin                    f64
	
	text_color                Color
	bg_color                  Color
	
	hovering                  bool                                                       @[nostyle]
	hovering_fn               fn ()              = unsafe { nil }
	
	text_size                 int
	text_align                TextAlignmentH     = .left
	text                      string                                                     @[nostyle]
	caret_pos                 int                                                        @[nostyle]
	select_pos                int                = -1                                    @[nostyle]
	
	
	// TODO : Add alignment options
}

// Draws text in given size at given position
pub fn (input TextInput) draw(mut ctx gg.Context) {
	// Button BG
	ctx.draw_rounded_rect_filled(
		f32(input.pos.x), f32(input.pos.y),
		f32(input.size.x), f32(input.size.y),
		f32(input.rounding),
		input.bg_color.get_gx()
	)
	
	// Button Text
	// TODO : Use 'ctx.set_text_style'
	ctx.set_text_cfg(
		color:            input.text_color.get_gx()
		size:             input.text_size
		vertical_align:   .middle
	)
	x_pos := match input.text_align {
		.left {
			input.margin
		}
		.center {
			input.size.x / 2.0 - f64(ctx.text_width(input.text)) / 2.0
		}
		.right {
			input.size.x - f64(ctx.text_width(input.text)) - input.margin
		}
	}
	ctx.draw_text_default(
		int(input.pos.x + x_pos), int(input.pos.y + input.size.y * 0.5),
		input.text
		// max_width:   int(label.size.x)
	)
	
	// Caret
	caret_x := input.pos.x + x_pos + ctx.text_width( input.text.substr(0, input.caret_pos) ) - 1
	caret_y := input.pos.y + input.size.y * 0.5 - f64(input.text_size) * 0.5
	ctx.draw_rect_filled(
		f32(caret_x), f32(caret_y),
		f32(2.0),     f32(input.text_size),
		input.text_color.get_gx()
	)
}

pub fn (mut input TextInput) update(mut ctx gg.Context) {
	input.hovering = mouse_hover(Component(input), mut ctx)
		
	if input.hovering {
		sapp.set_mouse_cursor(.ibeam)
	}
	// TDOO : Add typing only while focused
}

pub fn (mut input TextInput) event(event &gg.Event) {
	if event.typ == .char {
		key := u8(event.char_code)
		if key.ascii_str() != "" {
			mut txt := input.text.bytes()
			txt.insert(input.caret_pos, key)
			input.text = txt.bytestr()
			input.caret_pos += 1
		}
		
	} else if event.typ == .key_down {
		match event.key_code {
			.backspace {
				if input.text == "" { return }
				if input.caret_pos <= 0 { return }
				mut txt := input.text.bytes()
				txt.delete(input.caret_pos - 1)
				input.text = txt.bytestr()
				input.caret_pos -= 1
				if input.caret_pos < 0 { input.caret_pos = 0 }
			}
			.left {
				input.caret_pos -= 1
				if input.caret_pos < 0 { input.caret_pos = 0 }
			}
			.right {
				input.caret_pos += 1
				if input.caret_pos > input.text.len { input.caret_pos = input.text.len }
			}
			else {  }
		}
	}
}


pub fn (mut input TextInput) apply_style(style Style) {
	apply_style_to_type(mut input, style, input.classes)
}
