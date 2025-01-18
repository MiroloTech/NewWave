module main

import gg

import lib.geom { Vec2 }
import lib.std { Color }
import lib.ui { UI, Panel, Label, VBox, RimBox, Button }

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
			pos: Vec2{0, 0}
			size: screen_size
		},
		RimBox{
			pos: Vec2{0, 0}
			size: Vec2{450.0, screen_size.y}
			margin: 20.0
			children: [
				Panel{
					color: (style.get_value_of_type("Panel", "color") or { Color{} } as Color).darken(0.03)
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
									size: Vec2{100, 24}
									text: "Apple"
								},
								Label{
									size: Vec2{100, 24}
									text: "Banana"
								},
								Button{
									size: Vec2{100, 24}
									text: "Print Hello World!"
									pressed_fn: fn () { println("Hello World!") }
								},
							]
						}
					]
				}
			]
		}
	]
}

fn event(mut ev gg.Event, mut app App) {
}



fn frame(mut app App) {
	app.ui.draw(mut app.ctx)
	// app.ui.draw_debug(mut app.ctx)
}
