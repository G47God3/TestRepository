import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefinitionPage extends StatefulWidget {
  const DefinitionPage({Key? key, required this.definition, required this.word})
      : super(key: key);

  final Map definition;
  final String word;

  @override
  State<DefinitionPage> createState() => _DefinitionPageState();
}

class _DefinitionPageState extends State<DefinitionPage> {
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
      body: widget.definition.isNotEmpty
          ? Container(
          color: const Color.fromRGBO(246, 244, 235, 1),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(children: [
                Text(
                  widget.word,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(50, 50, 50, 1),
                  ),
                ),
                Container(
                  height: 3,
                  color: const Color.fromRGBO(50, 50, 50, 1),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: widget.definition.length,
                  itemBuilder: (BuildContext context, int index) {
                    String pos = widget.definition.keys.elementAt(index);
                    print(pos);

                    return ListView(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        Text(
                          pos,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: widget.definition[pos].length,
                            itemBuilder: (BuildContext context, int index) {
                              return Text(
                                '$index. ${widget.definition[pos][index]}',
                                style: const TextStyle(
                                  fontSize: 25,
                                ),
                              );
                            })
                      ],
                    );
                  },
                )
              ])))
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const Text('There is not history')],
        ),
      ),
    );
  }
}


