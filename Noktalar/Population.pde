class Population{
  Dot[] dots;
  float maxFitness = 1000;
  float totalFitness = 0;
  int maxFitI = 0;
  int x, y, n, leastStep = 1000;
  int gen = 0;
  
  Population(int x, int y, int n, boolean random){
    this.x = x; this.y = y; this.n = n;
    dots = new Dot[n];
    if(random){
      for(int i = 0; i < n; i++){
        dots[i] = new Dot(x, y, 5, false);
      }
    }
  }
  
  boolean allDead(){
    for(Dot d : dots){
      if(d.alive){
        return false;
      }
    }
    return true;
  }
  
  void calcMaxFitness(){
    maxFitness = 0;
    for(int i = 0; i < this.n; i++){
      if(dots[i].fitness > maxFitness){
        maxFitness = dots[i].fitness;
        maxFitI = i;
      }
    }
    if(dots[maxFitI].reached){
      leastStep = dots[maxFitI].i; 
    }
    println();
    print(maxFitness);
    println();
  }
  
  Dot chooseParent(){
    totalFitness = 0;
    for(int i = 0; i < this.n; i++){
      totalFitness += dots[i].fitness;
    }
    float luckyNumber = random(totalFitness);
    float runningSum = 0;
    for(int i = 0; i < this.n; i++){
       runningSum += dots[i].fitness;
       if(runningSum >= luckyNumber){
         return dots[i];
       }
    }
    return null;
  }
  
  void reproduce(){
    Dot[] next = new Dot[this.n];
    for(int i = 1; i < this.n; i++){
      DNA newDNA = new DNA(chooseParent().dna);
      next[i] = new Dot(this.x, this.y, 5, false, newDNA);
    }
    next[0] = new Dot(dots[maxFitI]);
    next[0].isBest = true;
    //next[1].isTarget = true;
    for(int i = 1; i < this.n; i++){
      dots = next.clone();
    }
  }
  
  void mutate(){
    for(int i = 1; i < this.n; i++){
      dots[i].dna.mutate();
    }
    gen++;
  }
  
  void display(){
    for(int i = 0; i < this.n; i++){
      dots[i].display();
    }
  }
   
  void update(){
    for(int i = 0; i < this.n; i++){
      if(dots[i].i > leastStep){
        dots[i].die();
      }else if(dots[i].alive){
        dots[i].update();
      }
    }
  }
}
