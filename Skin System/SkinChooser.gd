extends OptionButton

var skinsNode;

# Called when the node enters the scene tree for the first time.
func _ready():
	var applyToNode = get_node(get_meta("ApplyToNode"));
	skinsNode = applyToNode.get_node(applyToNode.get_meta("SkinsNode"));
	print(skinsNode.get_sprite_frames().get_animation_names());
	var skins = skinsNode.get_sprite_frames().get_animation_names();
	for id in len(skins):
		var skin = skins[id];
		add_item(skin, id);


func onItemSelected(index):
	skinsNode.play(get_item_text(index));
