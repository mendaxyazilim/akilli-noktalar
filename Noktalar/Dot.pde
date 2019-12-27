class Dot {
  boolean alive = true;
  boolean reached = false;
  boolean isBest = false;
  PVector pos;
  PVector vel;
  PVector acc;
  float r;
  DNA dna;
  int dnaLength = 1000;
  float cap = 0.5;
  int i = 0;
  boolean isTarget = false;
  float fitness;
    
  Dot(Dot d){
    pos = new PVector(width / 2, height - 50);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    r = d.r;
    dna = new DNA(d.dna);
    dnaLength = d.dnaLength;
    cap = d.cap;
    isTarget = false;
  }
  
  Dot(int x, int  y, float r, boolean isTarget){
    this.isTarget = isTarget;
    dna = new DNA(dnaLength, cap);
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    this.r = r;
  }
  
  Dot(int x, int y, float r, boolean isTarget, DNA passedDNA){
    this.isTarget = isTarget;
    dna = new DNA(passedDNA);
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    this.r = r;
  }
  
  void update(){
    if(pos.x > width - r || pos.x < r || pos.y > height - r || pos.y < r){
      die();
    }else if(this.isTouching(target)){
      this.reached = true;
      die();
    }else if(touchingObstacle()){
      die();
    }
    if(i < dnaLength){ 
      acc.add(dna.list[i++]);
    }else{
      die();
    }
    vel.add(acc);
    vel.limit(5);
    pos.add(vel);
    acc.setMag(0);
  }
  
  boolean touchingObstacle(){
    if(pos.y > 300 && pos.y < 310 && pos.x > 0 && pos.x < width - 300){
      return true;
    }else if(pos.y > 400 && pos.y < 410 && pos.x > 300 && pos.x < width){
      return true;
    }else if(pos.y > 500 && pos.y < 510 && pos.x > 0 && pos.x < width - 300){
      return true;
    }
    return false;
  }
  
  float dist(Dot d){
    return this.pos.dist(d.pos);
  }
  
  void die(){
    calcFitness();
    alive = false;
  }
  
  boolean isTouching(Dot d){
    if(this.dist(d) < this.r + d.r){
      return true;
    }else{
      return false;
    }
  }
  
  void calcFitness(){
    if(this.reached){
      fitness = 0.01 + (1.0 / (i * i));
    }else{
      fitness = 1 / (this.dist(target) * this.dist(target));
    }
  }
  
  void applyForce(PVector p){
    acc.add(p);
  }
  
  void display(){
    fill(255, 100);
    if(isBest){
      fill(255, 46, 76);
    }
    if(isTarget){
      fill(252, 215, 127);
    }
    stroke(100);
    ellipse(pos.x, pos.y, 2 * r, 2 * r);
  }
}
