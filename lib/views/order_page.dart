import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:not_apple_solutions/other/enums.dart';
import 'package:not_apple_solutions/other/ui_helpers.dart';
import 'package:not_apple_solutions/widgets/chip_list.dart';
import 'package:not_apple_solutions/widgets/color_preview.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({ Key? key }) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with AutomaticKeepAliveClientMixin<OrderPage> {

  TextEditingController _controllerName = TextEditingController();
  FocusNode _nodeName = FocusNode();
  TextEditingController _controllerDept = TextEditingController();
  FocusNode _nodeDept = FocusNode();
  TextEditingController _controllerUSN = TextEditingController();
  FocusNode _nodeUSN = FocusNode();
  TextEditingController _controllerPhone = TextEditingController();
  FocusNode _nodePhone = FocusNode();

  String? _fileError;
  BindingColor? _selectedColor;
  File? _file;

  final _form = GlobalKey<FormState>();

  void _processForm() {
    bool? isValid = _form.currentState?.validate();
    if (_file == null) {
      setState(() {
        _fileError = "Choose a file";
      });
      isValid = false;
    }
    if (isValid != null && !isValid) {
      return;
    }
    // razorpay
  }

  String? _emptyValidator(String? text) {
    if(text == null || text.isEmpty)
      return "Cannot be left empty";
    return null;
  }

  String? _startsWithValidator(String? text) {
    if(text == null || text.isEmpty)
      return "Cannot be left empty";
    else if(!text.startsWith('1RV'))
      return "Enter valid USN";
    return null;
  }

  String? _regExpValidator(String? text, String rawExpr, String err) {
    final regExp = RegExp(rawExpr);
    if(text == null || text.isEmpty)
      return "Cannot be left empty";
    else if(!regExp.hasMatch(text))
      return err;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Form(
        key: _form,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            ChipList(
              chips: [
                "Fields are case-sensitive",
                "All fields are mandatory"
            ]),
            TextFormField(
              controller: _controllerName,
              decoration: InputDecoration(border: InputBorder.none, labelText: "Name", hintText: "Lorem Ipsum"),
              textInputAction: TextInputAction.next,
              focusNode: _nodeName,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              validator: _emptyValidator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            virginDivider,
            TextFormField(
              controller: _controllerDept,
              decoration: InputDecoration(border: InputBorder.none, labelText: "Departmart", hintText: "ISE"),
              textInputAction: TextInputAction.next,
              focusNode: _nodeDept,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.characters,
              validator: _emptyValidator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            virginDivider,
            TextFormField(
              controller: _controllerUSN,
              decoration: InputDecoration(border: InputBorder.none, labelText: "USN", hintText: "1RV17XXYYY"),
              textInputAction: TextInputAction.next,
              focusNode: _nodeUSN,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.characters,
              validator: _startsWithValidator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            virginDivider,
            TextFormField(
              controller: _controllerPhone,
              decoration: InputDecoration(border: InputBorder.none, labelText: "Phone", hintText: "1234567890", labelStyle: Theme.of(context).inputDecorationTheme.labelStyle),
              textInputAction: TextInputAction.done,
              focusNode: _nodePhone,
              keyboardType: TextInputType.number,
              validator: (text) => _regExpValidator(text, r'^\d{10}$', "Enter 10 digit phone number"),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            bottomSpacedDivider,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Color of Binding", style: Theme.of(context).textTheme.bodyText1),
                if(_selectedColor != null)
                  ...[
                  Text(": ", style: Theme.of(context).textTheme.bodyText1),
                  ColorPreview(_selectedColor!),
                  ]
              ],
            ),
            DropdownButtonFormField<BindingColor>(
              decoration: InputDecoration(border: InputBorder.none),
              items: BindingColor.values.map((c) => DropdownMenuItem<BindingColor>(
                child: Text(c.toString().split('.').last),
                value: c,
              )).toList(),
              value: _selectedColor,
              hint: Text("Select"),
              onChanged: (c) { setState(() {
                _selectedColor = c;
              });},
              isExpanded: true,
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              validator: (color) {
                if(color == null)
                  return "Select a binding paper color";
                return null;
              },
            ),
            virginDivider,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    children: [
                      Text("Report", overflow: TextOverflow.visible, style: Theme.of(context).textTheme.bodyText1),
                      if(_file != null)
                        ...[
                        Text(": ", style: Theme.of(context).textTheme.bodyText1),
                        Text(_file!.path.split(Platform.pathSeparator).last, overflow: TextOverflow.visible, style: TextStyle(fontStyle: FontStyle.italic)),
                        ]
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf'], allowCompression: false);
                    if(result != null) {
                      setState(() {
                        _file = File(result.files.single.path!);
                        _fileError = null;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('File added successfully.'),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Theme.of(context).errorColor,
                          content: Text('Did not pick a file!'),
                        ),
                      );
                    }
                  },
                  child: Text('Add PDF'),
                  style: TextButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.padded,
                  ),
                ),
                if(_file != null)
                  ...[
                  OutlinedButton(
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                    },
                    child: Text('Preview PDF'),
                    style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        _file = null;
                      });
                      FilePicker.platform.clearTemporaryFiles().then((result) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: result! ? null : Theme.of(context).errorColor,
                            content: Text((result
                              ? 'Files cleaned successfully.'
                              : 'Failed to clean files!')),
                          ),
                        );
                      });
                    },
                    child: Text('Remove Files'),
                    style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.padded,
                    ),
                  ),
                ],
                verticalSpaceSmallMedium,
                if(_fileError != null)
                  Text(_fileError!, style: TextStyle(color: Theme.of(context).errorColor, fontSize: 12.0)),
              ],
            ),
            extraSmallBottomSpacedDivider,
            ChipList(
              chips: [
                "Cheapest rates gauranteed",
                "Price is calculated from the number of pages",
                "Checkout via RazorPay",
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  child: Text('Submit and Pay'),
                  onPressed: () => _processForm(),
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    _controllerUSN.dispose();
    _controllerDept.dispose();
    _controllerUSN.dispose();
    _controllerPhone.dispose();
  }
}
