import 'package:flutter/material.dart';
import 'package:flutter_17/drawer_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:open_file/open_file.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostPage createState() => _CreatePostPage();
}

class _CreatePostPage extends State<CreatePost> {
  DateTime _dueDate = DateTime.now();
  final currentDate = DateTime.now();
  Color _currentColor = Colors.orange;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
      ),
      drawer: DrawerScreen(),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            buildFilePicker(),
            const SizedBox(height: 20,),
            buildDataPicker(context),
            const SizedBox(height: 20,),
            buildColorPicker(context),
          ],
        ),
      ),
    );
  }

  Widget buildFilePicker(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Pick File'),
        const SizedBox(height: 10,),
        Center(
          child: ElevatedButton(
            onPressed: (){
              _pickFile();
            }, 
            child: const Text('Pick and Open File'),
          ),
        ),
      ],
    );
  }

  void _pickFile () async{
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    final file = result.files.first;
    _openFile(file);
  }

  void _openFile (PlatformFile file){
    OpenFile.open(file.path);
  }

  Widget buildDataPicker(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Publish At'),
            TextButton(
              onPressed: () async {
                final selectDate = await showDatePicker(
                  context: context, 
                  initialDate: currentDate, 
                  firstDate: DateTime(1990), 
                  lastDate: DateTime(currentDate.year + 5),
                );

                setState(() {
                  if (selectDate != null){
                    _dueDate = selectDate;
                  }
                });
              }, 
              child: const Text('Select'),
            ),
          ],
        ),
        Text(
          DateFormat('dd-MM-yyyy').format(_dueDate),
        ),
      ],
    );
  }

  Widget buildColorPicker(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Color Theme'),
        const SizedBox(height: 10,),
        Container(
          height: 100,
          width: double.infinity,
          color: _currentColor,
        ),
        const SizedBox(height: 10,),
        Center(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(_currentColor)),
            onPressed: (){
              showDialog(
                context: context, 
                builder: (context){
                  return AlertDialog(
                    title: const Text('Pick Your Color'),
                    content: BlockPicker(  //BlockPicker //ColorPicker //
                      pickerColor: _currentColor,
                      onColorChanged: (color) {
                        setState(() {
                          _currentColor = color;
                        });
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        }, 
                        child: const Text('Save'),
                      ),
                    ],
                  );
                }
              );
            }, 
            child: const Text('Pick Color'),
          ),
        ),
      ],
    );
  }
}