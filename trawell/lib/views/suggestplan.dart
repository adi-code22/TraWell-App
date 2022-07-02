import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuggestPlan extends StatefulWidget {
  const SuggestPlan({Key? key}) : super(key: key);

  @override
  State<SuggestPlan> createState() => _SuggestPlanState();
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems() {
  return [
    Item(
        expandedValue:
            "Current Location: Bela, Kasaragod\nVisit in order\n1)Muttathody\n2)Kundadukkam\n3)Bevinje Valley View Point\n",
        headerValue: "Plan 1 - 56 mins | 32 kms | 4.5⭐"),
    Item(
        expandedValue:
            "Current Location: Bela, Kasaragod\nVisit in order\n1)Kudlu\n2)Parappadi\n3)Ananthapura Park\n",
        headerValue: "Plan 2 - 1 hr 20 mins | 50 kms | 5⭐"),
    Item(
        expandedValue:
            "Current Location: Bela, Kasaragod\nVisit in order\n1)Padladka\n2)Pajjanam\n3)Nanankall Waterfalls\n",
        headerValue: "Plan 2 - 1 hr 5 mins | 45 kms | 4.2⭐"),
    Item(
        expandedValue:
            "Current Location: Bela, Kasaragod\nVisit in order\n1)Cherladukka\n2)Ethirthod\n3)Pottipala Waterfalls\n",
        headerValue: "Plan 2 - 40 mins | 20 kms | 3.8⭐"),
    Item(
        expandedValue:
            "Current Location: Bela, Kasaragod\nVisit in order\n1)Kalnad\n2)Chemmanad\n3)Bekal Fort\n",
        headerValue: "Plan 2 - 1 hr 10 mins | 60 kms | 5⭐")
  ].toList();
}

class _SuggestPlanState extends State<SuggestPlan> {
  final List<Item> _data = generateItems();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: RichText(
            text: TextSpan(
                style: GoogleFonts.poppins(
                    fontSize: 30, fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                  text: "Suggest",
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).primaryColorLight)),
              TextSpan(
                  text: "Plan",
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).primaryColor)),
            ])),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "Choose your perfect plan!",
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            ),
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  _data[index].isExpanded = !isExpanded;
                });
              },
              children: _data.map<ExpansionPanel>((Item item) {
                return ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(item.headerValue),
                    );
                  },
                  body: ListTile(
                      title: Text(item.expandedValue),
                      subtitle: const Text(
                          'To delete this panel, tap the trash can icon'),
                      trailing: const Icon(Icons.delete),
                      onTap: () {
                        setState(() {
                          _data.removeWhere(
                              (Item currentItem) => item == currentItem);
                        });
                      }),
                  isExpanded: item.isExpanded,
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
