module main

import gg

import lib.geom { Vec2 }
import lib.std { Color }
import lib.ui { UI,  Component, Panel, Label, VBox, RimBox, Button }

struct App {
	mut:
	ctx               &gg.Context  = unsafe { nil }
	ui                UI           = UI{}
}

fn main() {
	mut app := &App{}
	app.ctx = gg.new_context(
		bg_color:     Color.hex("#000000").get_gx()
		width:        1600
		height:       900
		window_title: 'UI Preview'
		frame_fn:     frame
		event_fn:     event
		init_fn:      init
		user_data:    app
	)
	app.ctx.run()
}

fn init(mut app App) {
	style_path := @VMODROOT + "/lib/ui/styles/simple_dark.json"
	style := ui.Style.load_style(style_path) or { panic("Style Parse Error : ${err}") }
	app.ui.style = style
	
	screen_size := Vec2{1600, 900}
	app.ui.components << [
		Panel{
			ref: "bg"
			rounding: 0.001
			pos: Vec2{0, 0}
			size: screen_size
			classes: [".hard-corners"]
		},
		RimBox{
			pos: Vec2{0, 0}
			size: Vec2{450.0, screen_size.y}
			margin: 20.0
			children: [
				Panel{
					color: (style.get_style_value("Panel", "color", []) or { Color{} } as Color).darken(0.03)
					pos: Vec2{0, 0}
					size: Vec2{100, 50}
				},
				RimBox{
					margin: 20.0
					children: [
						VBox{
							pos: Vec2{0, 0}
							size: Vec2{600, 400}
							children: [
								Label{
									ref: "screen_size_txt"
									size: Vec2{100, 24}
									text: "Screen size : ???"
								},
								Label{
									size: Vec2{100, 24}
									text: "Apple"
								},
								Label{
									size: Vec2{100, 24}
									text: "Banana"
								},
								Button{
									size: Vec2{100, 24}
									text: "Print 'Hello World!'"
									pressed_fn: fn () { println("Hello World!") }
								},
								Label{
									ref: "screen_size_txt"
									size: Vec2{100, 24}
									text: "Screen size : ???"
									classes: [".dark"]
								},
							]
						}
					]
				}
			]
		}
	]
	app.ui.update_refs()
	// println(app.ui.refs)
}

fn event(mut ev gg.Event, mut app App) {
}



fn frame(mut app App) {
	gg_screen_size := gg.window_size()
	screen_size := Vec2{f64(gg_screen_size.width), f64(gg_screen_size.height)}
	
	// Easy Way
	app.ui.set_ref_data[Vec2,   Panel]("bg",                "size",   screen_size)
	
	// Open Way
	mut screen_size_text_refs := app.ui.refs["screen_size_txt"] or { []Component{} }
	for mut cmp in screen_size_text_refs {
		if mut cmp is Label {
			cmp.text = "Screen size : ${screen_size}"
		}
	}
	
	app.ui.draw(mut app.ctx)
	// app.ui.draw_debug(mut app.ctx)
}

/*
TEMP:

Behaviour for classes:

During styleisation, first the struct-exclusive style values are set, and then for every extra defined style class in the object, the style sheet applies all possible valid values of that class into the object's style, prefering type - specific classes, if the type of the object matches the type of the class

*/
