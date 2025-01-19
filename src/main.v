module main

import gg

import lib.geom { Vec2 }
import lib.std { Color }
import lib.ui { UI,  Component,  Panel, Label, VBox, HBox, RimBox, Button }

struct App {
	mut:
	ctx               &gg.Context  = unsafe { nil }
	ui                UI           = UI{}
}

fn main() {
	println("")
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
		sample_count: 8   // Anti-Aliasing sample count
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
					size: Vec2{450.0, screen_size.y}
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
								HBox{
									pos: Vec2{0, 0}
									size: Vec2{600, 250}
									children: [
										VBox{
											pos: Vec2{0, 0}
											size: Vec2{100, 400}
											children: [
												Button{
													size: Vec2{0, 24}
													text: "'A'"
													pressed_fn: fn () { println("A") }
													text_align: .left
												},
												Button{
													size: Vec2{0, 24}
													text: "'B'"
													pressed_fn: fn () { println("B") }
													text_align: .center
												},
												Button{
													size: Vec2{0, 24}
													text: "'C'"
													pressed_fn: fn () { println("C") }
													text_align: .right
												},
											]
										},
										Panel{
											size: Vec2{500, 24}
											color: (style.get_style_value("Panel", "color", []) or { Color{} } as Color).darken(0.05)
										},
									]
								},
								Label{
									size: Vec2{100, 24}
									text: "Cucumber"
								},
							]
						},
					]
				},
			]
		},
	]
	app.ui.update_refs()
}

fn event(mut ev gg.Event, mut app App) {
}



fn frame(mut app App) {
	// Referencing:
	gg_screen_size := gg.window_size()
	screen_size := Vec2{f64(gg_screen_size.width), f64(gg_screen_size.height)}
	
	// > Easy Way
	app.ui.set_ref_data[Vec2,   Panel]("bg",                "size",   screen_size)
	
	// > Open Way
	mut screen_size_text_refs := app.ui.refs["screen_size_txt"] or { []Component{} }
	for mut cmp in screen_size_text_refs {
		if mut cmp is Label {
			cmp.text = "Screen size : ${screen_size}"
		}
	}
	
	
	// Drawing:
	app.ui.draw(mut app.ctx)
	// app.ui.draw_debug(mut app.ctx) // > Debu outlines of every component
}
