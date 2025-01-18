module geom

import math

// --- STRUCT ---
pub struct Vec2 {
	pub mut:
	x f64
	y f64
}


// --- OPERATORS ---
pub fn (a Vec2) + (b Vec2) Vec2 {
	return Vec2{a.x + b.x, a.y + b.y}
}
pub fn (a Vec2) - (b Vec2) Vec2 {
	return Vec2{a.x - b.x, a.y - b.y}
}
pub fn (a Vec2) * (b Vec2) Vec2 {
	return Vec2{a.x * b.x, a.y * b.y}
}
pub fn (a Vec2) / (b Vec2) Vec2 {
	return Vec2{a.x / b.x, a.y / b.y}
}

pub fn (a Vec2) % (b Vec2) Vec2 {
	return Vec2{math.fmod(a.x, b.x), math.fmod(a.y, b.y)}
}
pub fn (a Vec2) == (b Vec2) bool {
	return ( a.x == b.x ) && ( a.y == b.y )
}
pub fn (a Vec2) < (b Vec2) bool {
	return ( a.x < b.x ) && ( a.y < b.y )
}


// --- GENERAL ---
pub fn (v Vec2) str() string {
	return "(${v.x}, ${v.y})"
}

// --- IMPLEMENTED ---
pub fn (v Vec2) length() f64 {
	return math.sqrt( v.x * v.x + v.y * v.y )
}

pub fn (v Vec2) normalized() Vec2 {
	l := v.length()
	return Vec2{ v.x / l, v.y / l }
}

pub fn (a Vec2) direction_to(b Vec2) Vec2 {
	return (b - a).normalized()
}

pub fn (a Vec2) distance_to(b Vec2) f64 {
	return (b - a).length()
}

pub fn (v Vec2) to_grid(gridx f64, gridy f64) Vec2 {
	return Vec2{ math.floor(v.x / gridx) * gridx , math.floor(v.y / gridy) * gridy }
}

// --- STATIC ---
pub fn Vec2.dot(a Vec2, b Vec2) f64 {
	return a.x * b.x + a.y * b.y
}

pub fn Vec2.angle_between(a Vec2, b Vec2) f64 {
	d := Vec2.dot(a, b)
	la := a.length()
	lb := b.length()
	return math.acos( d / ( la * lb ) )
}

pub fn Vec2.rad2dir(r f64) Vec2 {
	return Vec2{ math.cos(r), math.sin(r) }
}
