
extends Area

onready var viewport = get_parent().get_node("Viewport")

onready var quad = get_node("Quad")

func _ready():
	quad.get_material_override().set_texture(FixedMaterial.PARAM_DIFFUSE, viewport.get_render_target_texture())


