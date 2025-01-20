# NewWave

NewWave is an easy-to-use UI library, written in VLang, with a focus on simplicity and expandabillity.

![Screenshot of NewWave in action, the Demo Scene with the basic SimpleDark style.](/screenshots/screenshot1.png)


## Features:
- Modular component types -> Object ( for rendering ), Container ( for orientation of components ), Reactor ( for interactivity )
- Expandable file structure
- custom style sheet implementation in .json format, with the power of style variables.
- Object oriented component structure
- Easy referencing of objects through the ui struct to selected components.

## Roadmap:
- More individual component formatting settings ( text orientation, etc. )
- More components -> Text Input, Switch, Slider

## TODO:
- Add more commentary to internal functions and components, explaining what they are doing
- Add option for internal Component variables to not be able to be set through the style sheet
- Add font support for all text components


# EXAMPLES:


## Minimal Project
```v
module main

import gg

import lib.geom { Vec2 }
import lib.std { Color }
import lib.ui { UI, Button }

struct App {
	mut:
	ctx               &gg.Context  = unsafe { nil }
	ui                UI           = UI{}
}

fn main() {
	mut app := &App{}
	app.ctx = gg.new_context(
		width:        1600
		height:       900
		window_title: 'UI Preview'
		frame_fn:     frame
		init_fn:      init
		user_data:    app
	)
	app.ctx.run()
}

// Runs once at start
fn init(mut app App) {
    // Read Style
	style_path := @VMODROOT + "/lib/ui/styles/simple_dark.json"
	style := ui.Style.load_style(style_path) or { panic("Style Parse Error : ${err}") }
	app.ui.style = style
	
    // Make scene structure
	screen_size := Vec2{1600, 900}
	app.ui.components << [
        Button{
            pos: Vec2{100, 100}
            size: Vec2{100, 24}
            text: "Print 'Hello World!'"
            pressed_fn: fn () { println("Hello World!") }
        },
    ]
}

// Runs every frame
fn frame(mut app App) {
	// Draw
	app.ui.draw(mut app.ctx)
	// app.ui.draw_debug(mut app.ctx) // > Debu outlines of every component
}
```


## Referenceing

```v
// [...]
Button{
    ref: ["btn_hello_world"] // Allows yout to easely read this component ( Button ) from the UI struct in App
    // [...]
}
// [...]



// Runs every frame
fn frame(mut app App) {
	gg_screen_size := gg.window_size()
	button_size := Vec2{f64(gg_screen_size.width), f64(gg_screen_size.height)} - Vec2{200, 200}
	
    // Apply size based on screen size to all objects of type button with the given reference
	app.ui.set_ref_data[Vec2,   Button]("btn_hello_world",   "size",   button_size)
	//                                  Reference            Field     Value
    
	// Draw
	app.ui.draw(mut app.ctx)
	// app.ui.draw_debug(mut app.ctx) // > Debu outlines of every component
}
```
