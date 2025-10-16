// add_counter.dart
import 'package:flutter/material.dart';

class AddCounter extends StatefulWidget {
  const AddCounter({super.key});

  @override
  State<AddCounter> createState() => _AddCounterState();
}

class _AddCounterState extends State<AddCounter> {
  final TextEditingController tasbihtitle = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    tasbihtitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("إضافة ذكر"),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: tasbihtitle,
                decoration: InputDecoration(
                  labelText: "عنوان الذكر",
                  hintText: "مثال: سبحان الله وبحمده",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (a) {
                  if (a == null || a.trim().isEmpty) return "من فضلك اكتب عنوان";
                  return null;
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.check),
                  label: Text("إضافة"),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context, tasbihtitle.text.trim());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}