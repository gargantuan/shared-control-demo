# InputManager.gd (AutoLoad)
extends Node

# Track which players can perform which actions
var action_assignments: Dictionary[String, Array] = {
    "move": ["player1"],  # Both can move
    "jump": ["player1"],             # Only P1 can jump
    "attack": ["player2"]            # Only P2 can attack
}

func _ready() -> void:
    # Create compound actions that combine player inputs
    update_action_mappings()

func update_action_mappings()  -> void:
    # Clear existing mappings
    for action in ["move", "jump", "attack"]:
        InputMap.action_erase_events(action)
    
    # Add events based on current assignments
    for action in action_assignments:
        for player in action_assignments[action]:
            _add_player_events_to_action(action, player)

func _add_player_events_to_action(action: String, player: String)  -> void:
    # Get the original player-specific action events
    var player_action = action + "_" + player
    if InputMap.has_action(player_action):
        for event in InputMap.action_get_events(player_action):
            InputMap.action_add_event(action, event)

func assign_action_to_player(action: String, player: String, exclusive: bool = false)  -> void:
    if exclusive:
        action_assignments[action] = [player]
    else:
        if not player in action_assignments[action]:
            action_assignments[action].append(player)
    update_action_mappings()

func remove_player_from_action(action: String, player: String)  -> void:
    action_assignments[action].erase(player)
    update_action_mappings()