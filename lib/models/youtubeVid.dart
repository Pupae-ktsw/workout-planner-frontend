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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['url'] = this.url;
    data['thumbnail'] = this.thumbnail;
    data['title'] = this.title;
    data['channel'] = this.channel;
    data['duration'] = this.duration;

    return data;
  }
}
