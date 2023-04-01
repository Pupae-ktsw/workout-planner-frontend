import 'package:flutter/material.dart';
import 'package:frontend/controllers/youtube_controller.dart';
import 'package:frontend/models/youtubeVid.dart';
import 'package:frontend/repositories/youtube_repo.dart';
import 'package:frontend/views/addProgram_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String programName = "programName";
  String searchYoutube = "";
  YoutubeController youtubeController = YoutubeController(YoutubeRepo());
  YoutubeVid youtubeVid = YoutubeVid();
  List<YoutubeVid> youtubeVidList = [];
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShowAddProgramPage()));
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 36,
                  ),
                ),
                Text(programName, style: TextStyle(fontSize: 18)),
                SizedBox(width: 20)
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 40,
                  width: 250,
                  child: TextFormField(
                    cursorHeight: 16,
                    controller: searchController,
                    decoration: InputDecoration(
                        focusColor: Colors.blue,
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.blue))),
                  ),
                ),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: (() {
                      setState(() {
                        searchYoutube = searchController.text;
                      });
                    }),
                    child: Text("Search")),
                SizedBox(
                  width: 20,
                )
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: searchYoutube == ""
                  ? Container()
                  : FutureBuilder<List<Object>>(
                      future: youtubeController.getSearchVid(searchYoutube),
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState == ConnectionState) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(child: Text("Error"));
                        }

                        return snapshot.hasData
                            ? ListView.builder(
                                itemCount: snapshot.data?.length,
                                itemBuilder: (context, index) {
                                  YoutubeVid youtubeVid =
                                      snapshot.data![index] as YoutubeVid;

                                  return Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Row(
                                          children: [
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                child: Image.network(
                                                  youtubeVid.thumbnail
                                                      as String,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    // Return a placeholder widget when the image fails to load
                                                    return Icon(Icons
                                                        .image_not_supported);
                                                  },
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      youtubeVid.title
                                                          as String,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(youtubeVid
                                                          .channel as String)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                })
                            : Center(child: Text("No data"));
                      })),
            )
          ],
        ),
      ),
    );
  }
}
