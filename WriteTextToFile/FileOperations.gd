extends Control

@onready var lineEdit = $SavingArea/LineEdit
@onready var textEdit = $SavingArea/TextEdit
@onready var chooseFileOptionButton = $ReadingArea/ChooseFile
@onready var readTextEdit = $ReadingArea/TextEdit

const OPERATIONS_DIRECTORY = "user://";

func _ready():
	testReadFileNames();
	testUpdateChooseFileOptionButton();
	
	updateChooseFileOptionButton(chooseFileOptionButton);

func readFileNames(path):
	var dir = DirAccess.open(path)
	var fileNames = [];
	if dir:
		dir.list_dir_begin()
		var fileName = dir.get_next()
		while fileName != "":
			if !dir.current_is_dir():
				fileNames.append(fileName)
			fileName = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return fileNames;

func testReadFileNames():
	print(readFileNames(OPERATIONS_DIRECTORY));
	
func updateChooseFileOptionButton(chooseFileOptionButtonReference : OptionButton):
	chooseFileOptionButtonReference.clear();
	var fileNames = readFileNames(OPERATIONS_DIRECTORY);
	for id in range(len(fileNames)):
		var fileName = fileNames[id];
		chooseFileOptionButtonReference.add_item(fileName, id);

func testUpdateChooseFileOptionButton():
	var chooseFileOptionButtonReference = $ReadingArea/ChooseFile;
	updateChooseFileOptionButton(chooseFileOptionButtonReference);

func writeFile(fileName, fileContent):
	var file = FileAccess.open(OPERATIONS_DIRECTORY + "%s.dat" % fileName, FileAccess.WRITE)
	file.store_string(fileContent);

func readChooseFileCurrent(chooseFileOptionButtonReference : OptionButton):
	var currentId = chooseFileOptionButtonReference.get_selected_id();
	var fileName = chooseFileOptionButtonReference.get_item_text(currentId);
	return fileName;
	
func readFile(fileName):
	var file = FileAccess.open(OPERATIONS_DIRECTORY + fileName, FileAccess.READ);
	var content = file.get_as_text();
	return content;

func deleteFile(fileName):
	var dir = DirAccess.open(OPERATIONS_DIRECTORY);
	dir.remove(fileName);

func onSaveButtonPressed():
	var fileName = lineEdit.text;
	var fileContent = textEdit.text;
	writeFile(fileName, fileContent);
	updateChooseFileOptionButton(chooseFileOptionButton);

func onReadButtonPressed():
	var fileName = readChooseFileCurrent(chooseFileOptionButton);
	var text = readFile(fileName);
	readTextEdit.text = text;

func onDeleteButtonPressed():
	var fileName = readChooseFileCurrent(chooseFileOptionButton);
	deleteFile(fileName);
	updateChooseFileOptionButton(chooseFileOptionButton);
