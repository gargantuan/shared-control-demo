class_name Projectile
extends Area3D

const PROJECTILE = preload("res://Components/Projectile/projectile.tscn")
const SPEED = 15.0
const LIFETIME = 2.0

var _lifetime_timer := 0.0
var direction := Vector3.FORWARD

static func create() -> Projectile:
	return PROJECTILE.instantiate() as Projectile
	
func _ready():
	# Set up collision detection if needed
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	# Move the projectile
	position += direction * SPEED * delta
	
	# Update lifetime
	_lifetime_timer += delta
	if _lifetime_timer >= LIFETIME:
		queue_free()

func _on_body_entered(body: Node3D) -> void:
	# Handle collision with other bodies (optional)
	if body != get_parent():
		queue_free()