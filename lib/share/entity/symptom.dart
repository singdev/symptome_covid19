class Symptom {
  bool temperature;
  bool toux;
  bool asthenie;
  bool difficultes_respiratoires;
  bool douleurs_musculaires;
  bool diarrhees;
  bool cephalees;
  bool maux_de_gorges;
  bool yeux_rouges;
  bool ecoulement_nasal;
  bool autres;
  bool prelevement;

  Symptom(
      {this.prelevement,
      this.temperature,
      this.asthenie,
      this.toux,
      this.difficultes_respiratoires,
      this.douleurs_musculaires,
      this.diarrhees,
      this.cephalees,
      this.maux_de_gorges,
      this.ecoulement_nasal,
      this.autres,
      this.yeux_rouges});

  factory Symptom.fromJson(Map<String, dynamic> map) {
    return Symptom(
        temperature: map["temperature"],
        toux: map["toux"],
        asthenie: map["asthenie"],
        difficultes_respiratoires: map["difficulte_respiratoire"],
        douleurs_musculaires: map["douleurs_musculaire"],
        diarrhees: map["diarrhe"],
        cephalees: map["cephalees"],
        maux_de_gorges: map["maux_de_gorges"],
        yeux_rouges: map["yeux_rouges"],
        ecoulement_nasal: map["ecoulement_nasal"],
        autres: map["autres"],
        prelevement: map["prelevement"]);
  }

  Map<String, dynamic> toJson() => {
        "temperature": this.temperature,
        "toux": this.toux,
        "asthenie": this.asthenie,
        "difficulte_respiratoire": this.difficultes_respiratoires,
        "douleurs_musculaire": this.douleurs_musculaires,
        "diarrhe": this.diarrhees,
        "cephalees": this.cephalees,
        "maux_de_gorges": this.maux_de_gorges,
        "yeux_rouges": this.yeux_rouges,
        "ecoulement_nasal": this.ecoulement_nasal,
        "autres": this.autres,
        "prelevement": this.prelevement
      };
}
