class YoutubeVid {
  String? id;
  String? url;
  String? thumbnail;
  String? title;
  String? channel;
  int? duration;

  YoutubeVid({
    this.id,
    this.url,
    this.thumbnail,
    this.title,
    this.channel,
    this.duration,
  });

  YoutubeVid.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    url = json['url'];
    thumbnail = json['thumbnail'];
    title = json['title'];
    channel = json['channel'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = id;
    data['url'] = url;
    data['thumbnail'] = thumbnail;
    data['title'] = title;
    data['channel'] = channel;
    data['duration'] = duration;

    return data;
  }
}
