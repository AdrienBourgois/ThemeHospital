
extends Control

onready var viewport = get_node("Viewport")
onready var area = get_node("Area")
onready var quad = area.get_node("Quad")
onready var label = viewport.get_node("Panel/Label")

func _ready():
	quad.get_material_override().set_texture(FixedMaterial.PARAM_DIFFUSE, viewport.get_render_target_texture())

func display(text):
	label.set_text(text)

func setPosition(new_pos):
	area.set_translation(new_pos)

func _on_AnimationPlayer_finished():
	queue_free()
