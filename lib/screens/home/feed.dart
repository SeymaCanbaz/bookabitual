import 'dart:ui';
import 'package:bookabitual/states/currentUser.dart';
import 'package:bookabitual/widgets/ProjectContainer.dart';
import 'package:bookabitual/widgets/QuotePost.dart';
import 'package:bookabitual/widgets/reviewPost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatefulWidget{
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  int _selectedItemIndex = 0;
  List<Widget> postList = [
    QuotePost(
      author: "J.R.R. Tolkien",
      bookName: "The Hobbit, or There and Back Again",
      createTime: Timestamp.now(),
      imageUrl: "https://images-na.ssl-images-amazon.com/images/I/A1E+USP9f8L.jpg",
      likeCount: 245,
      profileUrl: "https://images.pexels.com/photos/1499327/pexels-photo-1499327.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
      quote: "“There is nothing like looking, if you want to find something. "
          "You certainly usually find something, if you look, but it is not always quite "
          "the something you were after.”",
      status: "Reading",
      username: "Tom Smith",
    ),
    ReviewPost(
      author: "Colin Grant",
      bookName: "A Smell Of Burning",
      createTime: Timestamp.now(),
      imageUrl: "https://img.rasset.ie/000d7a28-614.jpg?ratio=0.6",
      likeCount: 476,
      profileUrl: "https://images.pexels.com/photos/1081685/pexels-photo-1081685.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
      review: "I realise this might be of minority interest if, unlike me, you haven’t spent your whole adult life with epilepsy being front and centre, but bear with me."
          "\nIt’s part thorough history of the condition, part look into what it actually is and how it works and part movingly human story about"
          " Grant’s own personal interest in epilepsy through the story of his brother.",
      status: "Finished",
      username: "Alan Wake",
      rating: 3.5,
    ),


  ];
  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = new ScrollController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          "bookabitual",
          style: TextStyle(
            fontSize: 22,
            fontWeight:
            FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Theme.of(context).bottomAppBarColor,
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
        ),
        centerTitle: true,

      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                physics: BouncingScrollPhysics(),
                itemCount: postList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    margin: EdgeInsets.only(bottom: 5),
                    child: postList[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        height: 50,
        child: FittedBox(
          child: ButtonTheme(
            minWidth: 100,
            height: 40,
            child: RaisedButton(
              color: Colors.grey[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              onPressed: () => _onButtonPressed(postList, setState, _scrollController),
              child: Row(
                children: [
                  Icon(Icons.add, color: Colors.grey[200]),
                  Text(
                    "Create Post",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[200],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            buildNavBarItem(Icons.home, 0),
            buildNavBarItem(Icons.search, 1),
            buildNavBarItem(Icons.person, 2),
          ],
        ),
      ),
    );
  }

  void _onButtonPressed(List<Widget> postList, StateSetter viewState, ScrollController control) {
    bool _firstChoice = true;
    bool _secondChoice = false;
    TextEditingController _author = TextEditingController();
    TextEditingController _book = TextEditingController();
    TextEditingController _rating = TextEditingController();
    TextEditingController _profileUrl = TextEditingController();
    TextEditingController _imageUrl = TextEditingController();
    TextEditingController _text = TextEditingController();


    showModalBottomSheet<dynamic>(context: context,
        isScrollControlled: true,
        backgroundColor: Colors.red[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25),),

        ),
        builder: (context) {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Wrap(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(25),
                        topRight: const Radius.circular(25),
                      ),
                    ),
                    margin: EdgeInsets.only(left: 5, right: 5),
                    child: _firstChoice ? Column(
                      children: [
                        SizedBox(height: 5,),
                        Text(
                          "Create a Post",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Column(
                          children: [
                            SizedBox(height: 5,),
                            Text(
                              "Select",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(height: MediaQuery.of(context).size.width / 20,),
                                ButtonTheme(
                                  minWidth: MediaQuery.of(context).size.width / 3,
                                  height: 40,
                                  child: RaisedButton(
                                    color: Colors.redAccent,
                                    onPressed: () {
                                      setState(() {
                                        _firstChoice = false;
                                        _secondChoice = true;
                                      });
                                    },
                                    child: Text(
                                      "Quote",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.grey[300],
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.width / 20,),
                                ButtonTheme(
                                  minWidth: MediaQuery.of(context).size.width / 3,
                                  height: 40,
                                  child: RaisedButton(
                                    color: Colors.redAccent,
                                    onPressed: () {
                                      setState(() {
                                        _firstChoice = false;
                                        _secondChoice = false;
                                      });
                                    },
                                    child: Text(
                                      "Review",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.grey[300],
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.width / 20,),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ) : Container(
                      child: _secondChoice ? Column(
                        children: [
                          SizedBox(height: 5,),
                          Text(
                            "Create a Quote",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            controller: _author,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person_outline),
                              hintText: "Author",
                            ),
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            controller: _book,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.book),
                              hintText: "Book Name",
                            ),
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            controller: _imageUrl,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.link),
                              hintText: "Image URL",
                            ),
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            controller: _profileUrl,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.link),
                              hintText: "Profile URL",
                            ),
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            maxLines: 5,
                            controller: _text,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.link),
                              hintText: "Quote",
                            ),
                          ),
                          ButtonTheme(
                            minWidth: MediaQuery.of(context).size.width / 3,
                            height: 40,
                            child: RaisedButton(
                              color: Colors.redAccent,
                              onPressed: () {
                                viewState(() {
                                  postList.insert(0, QuotePost(
                                    username: Provider.of<CurrentUser>(context, listen: false).getCurrentUser.username,
                                    status: "Reading",
                                    profileUrl: _profileUrl.text,
                                    quote: _text.text,
                                    likeCount: 0,
                                    imageUrl: _imageUrl.text,
                                    createTime: Timestamp.now(),
                                    bookName: _book.text,
                                    author: _author.text,
                                  ));
                                  control.animateTo(
                                    0.0,
                                    curve: Curves.bounceOut,
                                    duration: const Duration(milliseconds: 1000),
                                  );
                                });
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Share",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.grey[300],
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                        ],
                      ) : Column(
                        children: [
                          SizedBox(height: 5,),
                          Text(
                            "Create a Quote",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          ),
        ),
      );
    });
  }


  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemIndex = index;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        height: 50,
        child: Container(
          child: Icon(
            icon,
            size: 30,
            color: index == _selectedItemIndex ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }
}