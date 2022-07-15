# Functions and definitions for the gui
extends CanvasLayer

# Updates the passed in node if it is a resource meter
func update_resource_meter(element: TextureProgress, value) -> void:
                element.value = value

# Updates the passed in node if it is a label
func update_text_element(element: Label, value) -> void:
        element.text = "%.1f" % value

# Hides the provided element from player view
func hide_element(element_path: NodePath) -> bool:
        var element = get_node(element_path)
        element.hide()
        if not element.is_visible():
                return true
        else:
                return false

# Shows the specified element to the player if it is hidden
func show_element(element_path: NodePath) -> bool:
        var element = get_node(element_path)
        element.show()
        if element.is_visible():
                return true
        else:
                return false
        

# Called when the node enters the scene tree for the first time.
func _ready():
    $BoostCooldown.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
