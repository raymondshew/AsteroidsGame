//your variable declarations here 
Star [] starfield; 
ArrayList <Asteroid> asteroidList;
SpaceShip gar; 
public boolean upKey = false;
public boolean leftKey = false;
public boolean rightKey = false;
public boolean downKey = false;
public void setup() 
{
  size(600,600);
  background(0);
  gar = new SpaceShip(); 


  starfield = new Star[175]; 
  asteroidList = new ArrayList <Asteroid> ();
  for(int i = 0; i < starfield.length; i++)
    starfield[i] = new Star(); 
    for(int j = 0; j < 10; j++)
    asteroidList.add(j, new Asteroid());
}
public void draw() 
{
  background(0);
  for(int i = 0; i < starfield.length; i++)
    starfield[i].show(); 
     for(int j = 0; j < asteroidList.size(); j++) 
     { 
         asteroidList.get(j).move();
    asteroidList.get(j).show();
  }
  gar.show();
  gar.move();
  if(upKey == true) gar.accelerate(Math.random()*0.18);
  if(downKey == true) gar.accelerate(Math.random()*-0.18);
  if(leftKey == true) gar.rotate(-5);
  if(rightKey == true) gar.rotate(5); 
  for(int i = 0; i < asteroidList.size(); i++)
  {
    if( dist(asteroidList.get(i).getX(), asteroidList.get(i).getY(), gar.getX(), gar.getY())<20 )
      asteroidList.remove(i);
  }
  if(asteroidList.size()<1)
    setup();
}
class SpaceShip extends Floater  
{   
  public SpaceShip()
  {
   corners = 4;
        xCorners = new int[corners];
        yCorners = new int[corners];
        xCorners[0] = -10;
        yCorners[0] = -10;
        xCorners[1] = -7;
        yCorners[1] = 0;
        xCorners[2] = -10;
        yCorners[2] = 10;
        xCorners[3] = 10;
        yCorners[3] = 0;
   
    
    myColor = color(255,140,0);
    //coordinates
    myCenterX = (int)width/2;
    myCenterY = (int)height/2;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
  }
  public void setX(int x){myCenterX = x;}
  public int getX(){return (int)myCenterX;}
  public void setY(int y){myCenterY = y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX = x;}
  public double getDirectionX(){return myDirectionX;}
  public void setDirectionY(double y){myDirectionY = y;}
  public double getDirectionY(){return myDirectionY;}
  public void setPointDirection(double degrees){myPointDirection = degrees;}
  public double getPointDirection(){return myPointDirection;}   
}  

class Asteroid extends Floater
{ 
  private int rotSpeed, mySize;
  public Asteroid()
  { 
    // corners = 6;
    // xCorners = new int[corners]; yCorners = new int[corners];
    // xCorners[0] = -(int)(1.3*Math.random()*10+9); yCorners[0] = -(int)(1.3*Math.random()*4+7);
    // xCorners[1] = 7; yCorners[1] = -8; 
    // xCorners[2] = (int)(1.3*Math.random()*6+10); yCorners[2] = (int)(1.3*Math.random()*6-3);
    // xCorners[3] = (int)(1.3*Math.random()*4+5); yCorners[3] = (int)(1.3*Math.random()*10+9);
    // xCorners[4] = (int)(-3*1.3); yCorners[4] = (int)(1.3*8); 
    // xCorners[5] = -(int)(1.3*Math.random()*10+3); yCorners[5] = (int)(1.3*Math.random()*10-5);
    mySize = (int)(Math.random()*0.01*width)+4; 
    corners = (int)(Math.random()*1)+4; 
    xCorners = new int[corners];
    yCorners = new int[corners];
    //coordinates for the corners of ship
    for (int i = 0; i < corners; i++)
    {
      int randomizer = (int)(Math.random()*1)+1; //puts points in random places
      xCorners[i] = 3*(int)(randomizer*mySize*Math.cos(i*(2*Math.PI/(1*corners)))); //randomly chooses, starting from zero degrees
      yCorners[i] = 3*(int)(randomizer*mySize*Math.sin(i*(2*Math.PI/(1*corners)))); //goes around the backwards unit circle
    }

    myColor = color(0,255,0);
    rotSpeed = (int)(Math.random()*6)+2;
    myCenterX = (int)(Math.random()*600);
    myCenterY = (int)(Math.random()*600);
    myDirectionX = Math.random()*4-2;
    myDirectionY = Math.random()*4-2;
    myPointDirection = (Math.random()*360-180);

  }
 public void move()
  {
    rotate(rotSpeed);
    super.move();
  }
  public void setX(int x){myCenterX = x;}
  public int getX(){return (int)myCenterX;}
  public void setY(int y){myCenterY = y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX = x;}
  public double getDirectionX(){return myDirectionX;}
  public void setDirectionY(double y){myDirectionY = y;}
  public double getDirectionY(){return myDirectionY;}
  public void setPointDirection(double degrees){myPointDirection = degrees;}
  public double getPointDirection(){return myPointDirection;}   
}

abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(double degrees);   
  abstract public double getPointDirection(); 
  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians = myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (double nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move () //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX > width)    
      myCenterX = 0;       
    else if (myCenterX<0)
      myCenterX = width;        
    if(myCenterY > height)  
      myCenterY = 0;    
    else if (myCenterY < 0)    
      myCenterY = height;      
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 

class Star
{
  private int myX, myY;
  private double mySize;
  public Star()
  {
    myX = (int)(Math.random()*600);
    myY = (int)(Math.random()*600);
    mySize = Math.random()*6+3;
  }
  public void show()
  {
    fill(0,100,200);
    rect(myX, myY, (float)mySize, (float)mySize);
  }
}

public void keyPressed()
{
  if(key == CODED) 
  {
    if(keyCode == UP) upKey = true;
    if(keyCode == DOWN) downKey = true;
    if(keyCode == LEFT) leftKey = true;
    if(keyCode == RIGHT) rightKey = true;
  }
  if(key == 'z') 
  {
    gar.setX((int)(Math.random()*600));
    gar.setY((int)(Math.random()*600));
    gar.setPointDirection(Math.random()*360);
    gar.setDirectionX(0);
    gar.setDirectionY(0);
  }
}

public void keyReleased()
{
  if (keyCode == UP) upKey = false;
  if (keyCode == LEFT) leftKey = false;
  if (keyCode == RIGHT) rightKey = false;
  if (keyCode == DOWN) downKey = false;
}