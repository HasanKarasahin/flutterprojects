class TabModel {
  final String id;
  final String tabName;
  final String tabUrl;
  final String tabIcon;

  TabModel({this.id, this.tabName, this.tabUrl, this.tabIcon});

  /// objeden map oluşturan

  Map<String, dynamic> toMap() =>
      {'id': id, 'tabName': tabName, 'tabUrl': tabUrl, 'tabIcon': tabIcon};

  /// mapTen obje oluşturan yapıcı

  factory TabModel.fromMap(Map map) => TabModel(
      id: map['id'],
      tabName: map['tabName'],
      tabUrl: map['tabUrl'],
      tabIcon: map['tabIcon']);
}
