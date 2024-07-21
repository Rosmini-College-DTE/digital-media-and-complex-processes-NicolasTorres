extends ProgressBar

var parent
var max_value_amount = get_max()
var min_value_amount = get_min()

func _ready():
	parent = get_parent()
	set_max(parent.health_max)
	set_min(parent.health_min)

func _process(delta):
	self.value = parent.health
	if parent.health != parent.health_max:
		self.visible = true
		if parent.health == parent.health_min:
			self.visible = false
	else:
		self.visible = false
