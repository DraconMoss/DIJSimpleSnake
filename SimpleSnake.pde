final int NORTH = 1; 
final int EAST = 2; 
final int SOUTH = 3; 
final int WEST = 4; 


int gridSize = 20 * 2; //Circle size will scale to size of grid, left number is desired grid size(Only even numbers work)
byte direction = 0; 
byte prevDirection = 0;
boolean gameOver = false;
boolean beenEaten = false;

ArrayList<Dot> snake = new ArrayList<Dot>();
Dot apple = new Dot(genApplePos(), genApplePos());


void setup() {
    size(1000,1000);  
    background(0);
    smooth(8);
    snake.add(0, new Dot(gridSize/2 + 1, gridSize/2 + 1));
    noStroke();
    fill(0, 255, 0);
    snake.get(0).drawDot();
    fill(255, 0, 0);
    apple.drawDot();
    

}



public class Dot {
    int dotX;
    int dotY;
    
    public Dot(int x, int y){
      dotX = x;
      dotY = y;
      
    }  
    
    public int getX(){
      return dotX;
      
    }  
    
    public int getY(){
      return dotY;
      
    }
    
    public void changeX(int i){
      dotX = i;  
      
    }  
  
    public void changeY(int i){
      dotY = i;  
      
    }  
    
    public void drawDot(){
      circle(width / gridSize * dotX, height / gridSize * dotY, width / (gridSize / 2));   
      
    }  
  
  
}  



public void appleGen(){
    if(beenEaten){    
      apple.changeX(genApplePos());
      apple.changeY(genApplePos());
      
      beenEaten = false;
      
    }  
  
      
}



public void collision(){
   for(byte i = 1; i < snake.size(); i++){
     if(snake.get(0).getX() == snake.get(i).getX() && snake.get(0).getY() == snake.get(i).getY()){
        gameOver = true;
          
          
      } 
      
   }
  
   if(snake.get(0).getX() < 1 || snake.get(0).getX() > gridSize || snake.get(0).getY() < 1 || snake.get(0).getY() > gridSize){
     gameOver = true;
     
   }  
     
   if(snake.get(0).getX() == apple.getX() && snake.get(0).getY() == apple.getY()){
     snake.add(snake.size(), new Dot((snake.get(snake.size() - 1)).getX(), snake.get(snake.size() - 1).getY()));
 
     beenEaten = true;
     
   }  
  
  
}  



public void connectSnake(){     
    ArrayList<Integer> prevPosX = new ArrayList<Integer>();
    ArrayList<Integer> prevPosY = new ArrayList<Integer>();
    
    for(byte i = 0; i < snake.size(); i++ ){
      prevPosX.add(i, snake.get(i).getX());
      prevPosY.add(i, snake.get(i).getY());
      
      
    }  
    
    if(snake.size() > 1){      
      snake.get(1).changeX(snake.get(0).getX());
      snake.get(1).changeY(snake.get(0).getY());
      
    }  
    

    for(byte i = 2; i < snake.size(); i++ ){
      if(!(snake.get(i).getX() == prevPosX.get(i - 1) && snake.get(i).getY() == prevPosY.get(i - 1))){
        snake.get(i).changeX(prevPosX.get(i - 1));  
        snake.get(i).changeY(prevPosY.get(i - 1)); 
        
      }
      
    }     
  
  
}


  
public void game(){ 
    connectSnake();
    
    switch(direction){
        case 1: //up
          snake.get(0).changeY((snake.get(0).getY() - 2));
          break;
         
        case 2: //right
          snake.get(0).changeX((snake.get(0).getX() + 2));
          break;
          
        case 3: //down
          snake.get(0).changeY((snake.get(0).getY() + 2));
          break;
          
        case 4: //left
          snake.get(0).changeX((snake.get(0).getX() - 2));
          break;
        
     }
    
    background(0);
    collision();
    
    if(!beenEaten){
      fill(255, 0, 0);
      apple.drawDot();
 
      
    } else {
      appleGen();  
        
    }
    
    for(byte i = 0; i < snake.size(); i++){
      if(i > 0){
        fill(0, 255, 0);
        
      } else {
        fill(0, 100, 0);
        
      }  
      
      snake.get(i).drawDot();

    }
       
    prevDirection = direction;
    
    
}  



public boolean gameSpeed() {
    float updateFrame = 6;
    boolean update = false;
    
    if(frameCount % updateFrame == 0){
       update = true;
      
    }
    
    return update;
  
  
}  


public byte genApplePos(){
    byte a = byte(random(1, gridSize));
 
    if(a % 2 == 0){
      a -= 1;
      
    }  
           
    return(a);
  
  
}



public void input(){
  
    switch(key){
        case 'w':
          direction = NORTH;
          break;
           
        case 'd':
          direction = EAST;
          break;
            
        case 's':
          direction = SOUTH;
          break;
            
        case 'a':
          direction = WEST;
          break;
              
        case 'i':
          direction = NORTH;
          break;
           
        case 'l':
          direction = EAST;
          break;
            
        case 'k':
          direction = SOUTH;
          break;
           
        case 'j':
          direction = WEST;
          break;
            
     }  
     
     if(isBackwards()){
       direction = prevDirection;
       
     }  
  
  
}  



public boolean isBackwards(){
    boolean backwards = false;
    
    switch(direction){
        case 1: //up
          if(prevDirection == 3){
             backwards = true;
             
          }  
          break;
         
        case 2: //right
          if(prevDirection == 4){
             backwards = true;
             
          }       
          break;
          
        case 3: //down
          if(prevDirection == 1){
             backwards = true;
             
          }   
          break;
          
        case 4: //left
          if(prevDirection == 2){
             backwards = true;
             
          }  
          break;
        
      }
  
    return backwards;
  
  
}  



void draw() {
    input();

    if(!gameOver){
      if(gameSpeed()){
         game();
        
      }    
      
    } else {
      textAlign(CENTER); 
      textSize(width / 6);
      fill(255, 0, 0);
      text("GAME OVER", width / 2, height / 2);
      
    } 
    
  
}
