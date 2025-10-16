import 'package:counter_task/config/routes/routes_name.dart';
import 'package:flutter/material.dart';

class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  List tasbih = [
    {"title": "سبحان الله", "count": 0, "color": Colors.green},
    {"title": "الحمد لله", "count": 0, "color": Colors.green},
    {"title": "لا اله الا الله", "count": 0, "color": Colors.green},
    {"title": "الله اكبر", "count": 0, "color": Colors.green},
    {"title": "لا حول ولا قوه الا بالله", "count": 0, "color": Colors.green},
    {"title": "اسغفر الله", "count": 0, "color": Colors.green},
     
  ];

  int? selectedIndex; // العنصر اللي ضغطت عليه ضغطه مطولة

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: selectedIndex == null
            ? const Text("الأذكار")
            : Text(tasbih[selectedIndex!]['title']),
        backgroundColor:selectedIndex==null?  Colors.white:Colors.grey,
        actions: [
          if (selectedIndex == null)
            IconButton(
              onPressed: () async {
                final newtitle =
                    await Navigator.pushNamed(context, RoutesName.add);
                if (newtitle != null) {
                  setState(() {
                    tasbih.add({
                      "title": newtitle,
                      "count": 0,
                      "color": Colors.green,
                    });
                  });
                }
              },
              icon: const Icon(Icons.add),
            )
          else ...[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                _editTasbih(selectedIndex!);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _deleteTasbih(selectedIndex!);
              },
            ),
          ]
        ],
        leading: selectedIndex != null
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    selectedIndex = null;
                  });
                },
              )
            : null,
      ),
      body: ListView.builder(
        itemCount: tasbih.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              decoration: BoxDecoration(
                color: tasbih[index]["color"],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(2, 2),
                  )
                ],
              ),
              child: Row(
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        if (tasbih[index]["count"] > 0) {
                          tasbih[index]["count"]--;
                        }
                      });
                    },
                    color: Colors.red[200],
                    shape: const CircleBorder(),
                    child: const Text("-", style: TextStyle(fontSize: 20)),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          tasbih[index]["title"],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          tasbih[index]["count"].toString(),
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        tasbih[index]["count"]++;
                      });
                    },
                    color: Colors.lightGreen,
                    shape: const CircleBorder(),
                    child: const Text("+", style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // تعديل الذكر
  void _editTasbih(int index) {
    TextEditingController controller =
        TextEditingController(text: tasbih[index]['title']);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("تعديل الذكر"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: "العنوان الجديد",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("إلغاء"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                tasbih[index]['title'] = controller.text;
                selectedIndex = null;
              });
              Navigator.pop(context);
            },
            child: const Text("حفظ"),
          ),
        ],
      ),
    );
  }

  // حذف الذكر
  void _deleteTasbih(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("تأكيد الحذف"),
        content: Text("هل تريد حذف '${tasbih[index]['title']}'؟"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("إلغاء"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                tasbih.removeAt(index);
                selectedIndex = null;
              });
              Navigator.pop(context);
            },
            child: const Text("حذف", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}