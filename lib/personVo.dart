class PersonVo{

  // 필드
  int personId ;
  String name;
  String hp;
  String company;
  String gender;

  // 생성자
  PersonVo({
    required this.personId,
    required this.name,
    required this.hp,
    required this.company,
    required this.gender
  });

  factory PersonVo.fromJson(Map<String,dynamic> apiData){
    return PersonVo(
      personId: apiData['personId'],
      name: apiData['name'],
      hp: apiData['hp'],
      company: apiData['company'],
      gender: apiData['gender']
    );
  }
}