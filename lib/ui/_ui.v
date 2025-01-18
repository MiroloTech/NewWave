module ui

import gg
import sokol.sapp

import lib.std { Color }


pub struct UI {
	pub mut:
	components        []Component
	style             Style                      = Style{}
	refs              map[string][]Component
}

pub fn (mut ui UI) draw(mut ctx &gg.Context) {
	// Clear and reset screen to allow for screenclearing
	ctx.begin()
	ctx.end()
	
	// Default resets
	sapp.set_mouse_cursor(.arrow)
	
	
	// Apply styling
	for mut cmp in ui.get_all_components() {
		cmp.apply_style(ui.style)
	}
	
	// Format all positions of Components inside Containers
	for mut c in ui.components {
		if c.typ == .container {
			if mut c is Container {
				c.format()
			}
		}
	}
	
	// Update all reactors for event handled stuff
	for mut rea in ui.get_all_reactors() {
		rea.update(mut ctx)
	}
	
	
	// Draw all UI Objects in one drawcall
	ctx.begin()
	for obj in ui.get_all_objects() {
		obj.draw(mut ctx)
	}
	for rea in ui.get_all_reactors() {
		rea.draw(mut ctx)
	}
	ctx.end(how: .passthru)
}

pub fn (ui UI) draw_debug(mut ctx &gg.Context) {
	// Allow for drawing bounds of every container and obnject in seperate draw call
	ctx.begin()
	for c in ui.get_all_components() {
		mut color := Color.hex("#2600ff")
		if c is Container { color = Color.hex("#ffea00") }
		if c is Reactor { color = Color.hex("#fc3d3d") }
		ctx.draw_rect_empty(
			f32(c.pos.x), f32(c.pos.y),
			f32(c.size.x), f32(c.size.y),
			color.get_gx()
		)
	}
	ctx.end(how: .passthru)
}



pub fn (ui UI) get_all_objects() []Object {
	mut objects := []Object{}
	
	for c in ui.get_all_components() {
		if c.typ == .object {
			objects << (c as Object)
		}
	}
	
	return objects
}

pub fn (ui UI) get_all_reactors() []Reactor {
	mut reactors := []Reactor{}
	
	for c in ui.get_all_components() {
		if c.typ == .reactor {
			reactors << (c as Reactor)
		}
	}
	
	return reactors
}

pub fn (ui UI) get_all_components() []Component {
	mut components := []Component{}
	
	// Fill with references to top level ui components
	for c in ui.components {
		components << get_all_children(c)
	}
	
	return components
}

pub fn get_all_children(parent Component) []Component {
	mut result := []Component{}
	result << parent
	if parent.typ == .container {
		for child in (parent as Container).children {
			result << get_all_children(child)
		}
	}
	return result
}



pub fn apply_style_to_type[T](mut obj T, style Style) {
	obj_tag := typeof(obj).name.split(".")[1] or { typeof(obj).name.replace("&", "") }
	$for field in obj.fields {
		if value := style.get_value_of_type(obj_tag, field.name) {
			// Make sure, that defualt Component values can't be set
			mut value_invalid := false
			$for component_field in Component.fields {
				if field.name == component_field.name { // field.typ == component_field.typ && 
					value_invalid = true
				}
			}
			if !value_invalid {
				$if field.typ is string {
					if obj.$(field.name) == "" {
						obj.$(field.name) = value as string
					}
				}
				$if field.typ is Color {
					if obj.$(field.name) == Color{} {
						obj.$(field.name) = value as Color
					}
				}
				$if field.typ is int {
					if obj.$(field.name) == 0 {
						obj.$(field.name) = value as int
					}
				}
				$if field.typ is f64 {
					if obj.$(field.name) == 0.0 {
						obj.$(field.name) = value as f64
					}
				}
				$if field.typ is bool {
					if obj.$(field.name) == false {
						obj.$(field.name) = value as bool
					}
				}
			}
		}
	}
}


// --- REFERENCES ---
// Reloads the list of component references in the UI struct
pub fn (mut ui UI) update_refs() {
	ui.refs = map[string][]Component{}
	
	for cmp in ui.get_all_components() {
		if cmp.ref != "" {
			if !(cmp.ref in ui.refs.keys()) {
				ui.refs[cmp.ref] = []Component{}
			}
			ui.refs[cmp.ref] << cmp
		}
	}
}


// Sets the value to every component with the given reference, if the component has the given field
// TODO : Make this return an error if anything doesn't work
pub fn (mut ui UI) set_ref_data[T, G](ref string, field_name string, value T) {
	if ref in ui.refs.keys() {
		for mut cmp in ui.refs[ref] {
			if mut cmp is G {
				println("Component ${typeof(cmp).name} is examined for abillity to set field ${field_name} to ${value}")
				$for field in cmp.fields {
					// Check, if the value setting is adressed to the embedded Basic struct of a Component, and if so, access and check all fields in that embedded Basic struct
					$if field.typ is Basic {
						b := cmp.Basic
						$for bfield in b.fields {
							$if bfield.typ is T {
								if bfield.name == field_name {
									cmp.Basic.$(bfield.name) = value
								}
							}
						}
					} $else {
						$if field.typ is T {
							if field.name == field_name {
								cmp.$(field.name) = value
							}
						}
					}
				}
			}
		}
	}
}
