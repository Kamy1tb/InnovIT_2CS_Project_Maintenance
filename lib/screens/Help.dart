import 'package:flutter/material.dart';
import '../utilities/constants.dart';

class HelpData{
  String question;
  String answer;

  HelpData(this.question,this.answer);
}

List<HelpData> helpList=[
  HelpData("Where can I find my new tasks ?", "You can find your new tasks list in the notifications section from the bottom navigation bar."),
  HelpData("How Can I choose a task ?", "First, Open the application and navigate to 'Tasks List' using the bottom navigation bar. Then, review the list of tasks and click on the task that you want to choose to work on. Once you have completed the task, mark it as 'done' in the application."),
  HelpData("How can I change my password ?", "To change your password, go to your account settings and look for the 'Change Password' option. You will be prompted to enter your current password and then enter and confirm your new password. Make sure your new password is strong and not easily guessable."),
  HelpData("How can I logout ?", "To log out of the application, simply navigate to the profile screen by clicking on the person icon in the bottom navigation bar. From there, you should see a 'Log out' button. Click on it and you will be logged out of the application."),
];

List<HelpData> displayedList=[];
class Help extends StatefulWidget{
  const Help({super.key});
  @override
  State<StatefulWidget> createState() => HelpState();
}

class HelpState extends State<Help>{
  searchHelp(String Value){}

  @override
  void initState() {
    super.initState();
    displayedList=helpList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Help",
          style: TextStyle(
              color: Colors.black
          ),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30,horizontal: 16),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  displayedList = helpList
                      .where((item) =>
                      item.answer.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                });
              },
              style: const TextStyle(
                color: cadetGray,
              ),
              decoration: InputDecoration(
                focusedBorder:OutlineInputBorder(
                  borderSide: const BorderSide(color: cadetGray, width: 1.0),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 5),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: cadetGray),
                  borderRadius: BorderRadius.circular(30),
                ),
                hintText: 'Search',
                hintStyle: TextStyle(color: cadetGray),
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.search),
                iconColor: cadetGray,
                focusColor: cadetGray
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
              child: ListView.builder(
                itemCount: displayedList.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    title: Text(
                      displayedList[index].question,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black
                    ),),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                            displayedList[index].answer,

                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

}
