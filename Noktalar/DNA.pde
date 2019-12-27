class DNA{
  PVector[] list;
  int n;
  float mutateChance = 0.01;
  float cap;
  
  DNA(int n, float cap){
    this.n = n;
    this.cap = cap;
    list = new PVector[this.n];
    for(int i = 0; i < n; i++){
      list[i] = new PVector(random(-cap, cap), random(-cap, cap));
    }
  }
  
  DNA(DNA dna){
    this.n = dna.n;
    this.cap = dna.cap;
    this.mutateChance = dna.mutateChance;
    list = new PVector[this.n];
    for(int i = 0; i < this.n; i++){
      list[i] = new PVector(dna.list[i].x, dna.list[i].y);
    }
  }
  void mutate(){
    for(int i = 0; i < n; i++){
      if(random(1) < mutateChance){
        list[i] = new PVector(random(-cap, cap), random(-cap, cap));
      }
    }
  }
}
