/// @func ATEX_tag_TEMPLATE(arguments, properties, sizes, type)
/// @desc This is example of tag script, duplicate and edit it if you want to fast create new tag
/// @arg {list} arguments Arguments of tag, ds_list with values
/// @arg {map} properties Properties of tag, ds_map with keys and values
/// @arg {array} sizes Current width and height of string. 0 - width, 1 - height

var args=argument0, props=argument1, sizes=argument2, type=argument3;
var W=sizes[0], H=sizes[1];

#region tag data

if type=="depth" 
	return -1
if type=="names"
	return ["runline", "runningline", "runl", "rline"]
if type=="type"
	return ATEX.element
	
#endregion

if type=="dynamic"
	return true
else
if type=="position"
{
	return [ATEX_get_prop(props, "w", 100), string_height("A")] // first value - width, second - height. You can write your values
}
else
if type=="draw"
{
	var w=ATEX_get_prop(props, "w", 100), text=ATEX_get_prop(props, "title", "title"),
		h=string_height("A"), surf=global.ATEX_runline_surf, sw=string_width(text);
	if !surface_exists(surf) or surface_get_width(surf)!=w or surface_get_height(surf)!=h
		surf=surface_create(w, h)
		
	surface_set_target(surf)
	draw_clear_alpha(draw_get_colour(), 0)
	
	var cx=current_time*0.001*real(ATEX_get_prop(props, "spd", w/5)) mod (sw+w*0.5) + sw*0.5;
	for(var xx=-cx; xx<w; xx+=sw + w*0.5)
		ATEX_draw_ut(xx, 0, string_width(text), h, text, h, argument6, argument7)
	surface_reset_target()
	//var text=argument4, X=argument5, Y=argument6; - for "drawer" tags
	var X=argument4, Y=argument5; 
	
	draw_surface(surf, X, Y)
	global.ATEX_runline_surf=surf
	
	return true
}
else
if type=="start"
{
	var poslist=argument4, textlist=argument5;
	/*
			start of the tag, it calling when "position" event return text
	*/
}
else
if type=="end"
{
	var poslist=argument4, textlist=argument5; // array with text coordinates. You can use it to detect collision with cursor
	/*
			end of the tag, it calling when text returned in "position" event already drawn
	*/
}
else
if type=="init"
{
	global.ATEX_runline_surf=-1
}
/*
		You can use draw_set_... functions, you can draw your own things, you can doing what you want, really (just ask your mother for permission)
*/