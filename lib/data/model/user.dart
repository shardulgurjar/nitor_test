class User {
  String _name;
  int _id;
  int _score;
  String _avatorUrl;
  String _profileUrl;
  String _followerUrl;
  int _publicRepos;
  int _publicGists;
  int _followers;
  int _following;
  String _location;
  String _fullName;
  String _bio;
  String _updatedAt;


  //Setters
  set id(int id) {
    this._id = id;
  }

  set imgUrl(String imgUrl) {
    this._avatorUrl = imgUrl;
  }

  set name(String name) {
    this._name = name;
  }

  set score(int score) {
    this._score = score;
  }

  set profileUrl(String url) {
    this._profileUrl = url;
  }

  set followerUrl(String followerUrl) {
    this._followerUrl = followerUrl;
  }

  set followerCount(int followers) {
    this._followers = followers;
  }

  set followingCount(int following) {
    this._following = following;
  }

  set publicRepos(int pubRepos) {
    this._publicRepos = pubRepos;
  }

  set publicGists(int pubGists) {
    this._publicGists = pubGists;
  }

  set location(String location) {
    this._location = location;
  }

  set fullName(String fullName) {
    this._fullName = fullName;
  }

  set bio(String bio) {
    this._bio = bio;
  }

  set updatedAt(String updatedAt){
    this._updatedAt = updatedAt;
  }

  // Getters
  int get id => this._id;

  String get updatedAt => this._updatedAt;

  String get imgUrl => this._avatorUrl;

  String get name => this._name;

  int get score => this._score;

  String get profileUrl => this._profileUrl;

  int get followers => this._followers;

  int get following => this._following;

  int get publicGists => this._publicGists;

  int get publicRepos => this._publicRepos;

  String get bio => this._bio;

  String get followerUrl => this._followerUrl;

  String get fullName => this._fullName;

  String get location => this._location;
}
