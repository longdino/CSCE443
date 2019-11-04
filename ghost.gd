extends Sprite


func _ready():
	$alpha_tween.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.2, Tween.TRANS_SINE, Tween.EASE_OUT)
	$alpha_tween.start()

func _on_alpha_tween_tween_completed(object, key):
	queue_free()
