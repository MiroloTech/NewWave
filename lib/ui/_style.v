module ui

import os
import x.json2 as json

import lib.std { Color }


type UIType = string | int | f64 | bool | Color | Error

pub struct Style {
	pub mut:
	src        string
	data       map[string]map[string]UIType
	variables  map[string]UIType
	classes    map[string]map[string]UIType
}

// Returns a fully parsed style struct, given a path to a suitable .json style file
pub fn Style.load_style(path string) !Style {
	src := os.read_file(path) or { return error("Can't read raw text data from Style file : ${err} ") }
	
	mut style := Style{
		src: src
	}
	
	json_data := json.raw_decode(src) or { return error("Can't properly decode the json file entered : ${err}") }
	mut components := json_data.as_map()
	
	if raw_variables := components["-"] {
		for key, value in raw_variables.as_map() {
			style.variables[key] = json_any_to_uitype(value) or { continue } // TODO : Make this warning for invalid style variable
		}
		
		components.delete("-")
	}
	
	for raw_obj, raw_data in components {
		obj := raw_obj.str()
		if obj == "" { continue }
		
		if obj.contains(".") {
			if obj.len <= 1 { continue }
			
			style.classes[obj] = map[string]UIType{}
			
			for raw_dtag, raw_dval in raw_data.as_map() {
				mut val := json_any_to_uitype(raw_dval) or { continue } // TODO : Make this warning for invalid parse
				if mut val is string {
					if val.starts_with("--") {
						val = style.variables[val] or { continue } // TODO : Make this warning for non-existing style variable
					}
				}
				style.classes[obj][raw_dtag] = val
			}
		}
		else {
			style.data[obj] = map[string]UIType{}
			
			for raw_dtag, raw_dval in raw_data.as_map() {
				mut val := json_any_to_uitype(raw_dval) or { continue } // TODO : Make this warning for invalid parse
				if mut val is string {
					if val.starts_with("--") {
						val = style.variables[val] or { continue } // TODO : Make this warning for non-existing style variable
					}
				}
				style.data[obj][raw_dtag] = val
			}
		}
	}
	
	return style
}


// Given an object name and field name of the searched value, and an optional array of considered style classes ( or [] ),
// this function returns a suitable UIType ( or error, if no valud value is found )
pub fn (style Style) get_style_value(typ string, field_name string, classes []string) !UIType {
	// 3. Priority - type-specific value
	mut valid := false
	mut value := UIType(Error{})
	if v := style.data[typ][field_name] {
		value = v
		valid = true
	}
	
	
	// 2. Priority - generic classes
	for class_name, class in style.classes {
		if class_name.starts_with(".") {
			if class_name in classes {
				for key, val in class {
					if key == field_name {
						if val.type_name() == value.type_name() {
							value = val
							valid = true
						}
					}
				}
			}
		}
	}
	// 1. Priority - type-specific classes
	for class_name, class in style.classes {
		if class_name.starts_with(typ) {
			if ("." + class_name.split(".")[1] or { "" }) in classes {
				for key, val in class {
					if key == field_name {
						if val.type_name() == value.type_name() {
							value = val
							valid = true
						}
					}
				}
			}
		}
	}
	
	if !valid {
		return error("Unknown type or field name for Style Data.")
	}
	return value
}


// Applies all possible styleization values into the given object of any type, given the object, a style struct and an optional list of classes ( or [] )
pub fn apply_style_to_type[T](mut obj T, style Style, classes []string) {
	obj_tag := typeof(obj).name.split(".")[1] or { typeof(obj).name.replace("&", "") }
	$for field in obj.fields {
		if value := style.get_style_value(obj_tag, field.name, classes) {
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


// Takes in a json - specific any type and turns it into any valid version of UIType, or returns an error if the json type is unsupported
fn json_any_to_uitype(v json.Any) !UIType {
	match v {
		bool {
			return UIType(bool(v))
		}
		f64, f32 {
			return UIType(f64(v))
		}
		int, i8, i16, i32, i64, u8, u16, u32, u64 {
			return UIType(int(v))
		}
		string {
			if v.starts_with("#") {
				return UIType(Color.hex(v))
			}
			return UIType(v)
		}
		else { }
	}
	return error("Invalid type : ${typeof(v).name}")
}
