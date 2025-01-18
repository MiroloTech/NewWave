module ui

import os
import x.json2 as json

import lib.std { Color }


type UIType = string | int | f64 | bool | Color

pub struct Style {
	pub mut:
	src        string
	data       map[string]map[string]UIType
	variables  map[string]UIType
}

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
	
	return style
}

pub fn (style Style) get_value_of_type(typ string, field_name string) !UIType {
	return style.data[typ][field_name] or { return error("Unknown type or field name for Style Data.") }
}


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
		else {
			
		}
	}
	return error("Invalid type : ${typeof(v).name}")
}
