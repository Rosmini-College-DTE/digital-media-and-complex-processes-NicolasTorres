extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

func _ready():
	$Label.visible = false

func action() -> void:
	DialogueManager.show_dialogue_balloon(dialogue_resource, dialogue_start)

func _on_body_exited(body):
	if body.name == "Player":
		$Label.visible = false
func _on_body_entered(body):
	if body.name == "Player":
		$Label.visible = true

