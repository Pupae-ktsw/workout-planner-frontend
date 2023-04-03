import 'package:flutter/material.dart';
import 'package:frontend/controllers/youtube_controller.dart';
import 'package:frontend/models/dayOfProgram.dart';
import 'package:frontend/models/youtubeVid.dart';
import 'package:frontend/repositories/youtube_repo.dart';
import 'package:frontend/views/addProgram_page.dart';
import 'package:frontend/views/dayOfProgramManage_page.dart';
import 'package:provider/provider.dart';

import '../provider/programProvider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _programName = "programName";
  String _searchYoutube = "";
  YoutubeController _youtubeController = YoutubeController(YoutubeRepo());
  YoutubeVid _youtubeVid = YoutubeVid();
  List<YoutubeVid> _youtubeVidList = [];
  TextEditingController _searchController = TextEditingController();
  List<DayOfProgram> _dayOfProgramList = [];
  DayOfProgram dayOfProgram = DayOfProgram();

  @override
  Widget build(BuildContext context) {
    var programProvider = Provider.of<ProgramProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DayOfProgramManage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 36,
                    ),
                  ),
                ),
                Text(programProvider.programName!,
                    style: TextStyle(fontSize: 18)),
                SizedBox(width: 40)
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
                    cursorHeight: 20,
                    controller: _searchController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10, top: 5),
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
                        _searchYoutube = _searchController.text;
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
              child: _searchYoutube == ""
                  ? Container()
                  : FutureBuilder<List<Object>>(
                      future: _youtubeController.getSearchVid(_searchYoutube),
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
                                  print(youtubeVid.title);
                                  String playlistId = "";
                                  bool _isPlaylist =
                                      youtubeVid.url!.contains("playlist");
                                  if (_isPlaylist) {
                                    playlistId = youtubeVid.url!.substring(9);
                                  }

                                  return Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: InkWell(
                                          onTap: () {
                                            if (_isPlaylist) {
                                              _youtubeController
                                                  .getVidInPlayList(playlistId)
                                                  .then((value) {
                                                _youtubeVidList =
                                                    value as List<YoutubeVid>;

                                                for (var i in _youtubeVidList) {
                                                  programProvider
                                                      .addDayOfProgram(i);
                                                }
                                              });
                                            } else {
                                              programProvider
                                                  .addDayOfProgram(youtubeVid);
                                            }
                                            dayOfProgram = DayOfProgram(
                                                youtubeVid: youtubeVid);

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DayOfProgramManage(),
                                                ));
                                          },
                                          child: Row(
                                            children: [
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Stack(
                                                  children: [
                                                    ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                        child: Image.network(
                                                          youtubeVid.thumbnail!,
                                                          errorBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  Object
                                                                      exception,
                                                                  StackTrace?
                                                                      stackTrace) {
                                                            return Image.network(
                                                                "https://www.shape.com/thmb/DjCIHGX6cWaIniuqHeBAAreNE08=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/best-cardio-exercises-promo-2000-498cbfb8f07541b78572bf810e7fb600.jpg");

                                                            // re-throw the exception if it's not a NetworkImageLoadException
                                                          },
                                                        )),
                                                    Positioned(
                                                        top: 4,
                                                        left: 4,
                                                        child: Container(
                                                          height: 30,
                                                          width: 60,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.8),
                                                          ),
                                                          child: _isPlaylist
                                                              ? Center(
                                                                  child: Text(
                                                                    "playlist",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                )
                                                              : Center(
                                                                  child: Text(
                                                                      "video",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              16)),
                                                                ),
                                                        ))
                                                  ],
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
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                            youtubeVid.channel
                                                                as String)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                })
                            : Center(child: CircularProgressIndicator());
                      })),
            )
          ],
        ),
      ),
    );
  }
}
