class Video {
  String link = '';
  String thumnbailUrl = '';
  String title = '';
  Video({required this.link, required this.thumnbailUrl, required this.title});
  String getLink() {
    return link;
  }

  String getThumnbailUrl() {
    return thumnbailUrl;
  }

  String getTitle() {
    return title;
  }
}
