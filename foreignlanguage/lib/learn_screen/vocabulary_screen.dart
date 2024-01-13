import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foreignlanguage/learn_screen/definition_screen.dart';

class VocabularyPage extends StatefulWidget {
  const VocabularyPage({Key? key, required this.words}) : super(key: key);

  final Map words;

  @override
  State<VocabularyPage> createState() => _VocabularyPageState();
}

class _VocabularyPageState extends State<VocabularyPage> {
  List<Map<String, dynamic>> data = [];
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(70, 130, 169, 1),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50.0),
            bottomRight: Radius.circular(50.0),
          ),
        ),
        toolbarHeight: 60,
        flexibleSpace: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 50,
                width: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/logo.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: widget.words.isNotEmpty
          ? Container(
        color: const Color.fromRGBO(246, 244, 235, 1),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              const Text(
                "Vocabulary",
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(50, 50, 50, 1),
                ),
              ),
              Container(
                height: 3,
                color: const Color.fromRGBO(50, 50, 50, 1),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: widget.words.length,
                itemBuilder: (BuildContext context, int index) {
                  String word = widget.words.keys.elementAt(index);
                  print(word);
                  return Card(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              word,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.info),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DefinitionPage(
                                            definition: widget.words[word],
                                            word: word)));
                              },
                            ),
                          ),
                        ],
                      ));
                },
              ),
            ],
          ),
        ),
      )
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('There is not history')],
        ),
      ),
    );
  }
}


