

import de.bezier.guido.*;

public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;

private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make(this);
    
    bombs = new ArrayList <MSButton> ();
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int row = 0; row < 20;row++)
    {
        for(int col = 0; col < 20;col++)
        {
            buttons[row][col] = new MSButton(row,col);
        }
    }

  
        setBombs();

}
public void setBombs()
{
    int placeR = (int)(Math.random()*NUM_ROWS);
    int placeC = (int)(Math.random()*NUM_COLS);
    if(!bombs.contains(buttons[placeR][placeC]))
    {
        bombs.add(buttons[placeR][placeC]);
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    for (int r = 0; r < NUM_ROWS; r++){
        for(int c = 0; c < NUM_COLS; c++){
            if(buttons[r][c].isClicked() == false){
                return false;
            }
        }
    }
    return true;

}
public void displayLosingMessage()
{
    for(int r = 0; r < NUM_ROWS; r++)
        for(int c = 0; c < NUM_COLS; c++)
            if(!buttons[r][c].isClicked() == true && bombs.contains(buttons[r][c]))
                buttons[r][c].clicked = true;
    String lose = new String("GAME OVER");
    for(int i = 0; i < lose.length();i++)
        buttons[6][i+6].setLabel(lose.substring(i,i+1));
}
public void displayWinningMessage()
{
     String win = new String("You Win!!!");
    for(int i = 0; i < win.length();i++)
    {
        buttons[9][i+9].setLabel(win.substring(i,i+1));
    }
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        // width = 400/NUM_COLS;
        // height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed == true || mousePressed && (mouseButton == RIGHT))
       {
            
            if(marked == false)
            {
                marked = true;
                clicked = true;

            }
            else if(marked == true)
            {
                clicked = false;
                marked = false;
            }
       }
       else if(bombs.contains(this))
       {
            displayLosingMessage();
       }
        else if(countBombs(r,c) > 0)
        {
            setLabel("" + countBombs(r,c));
        }  
        else
        {
            if(isValid(r,c-1) && !buttons[r][c-1].isClicked())
                buttons[r][c-1].mousePressed();
            if(isValid(r,c+1) && !buttons[r][c+1].isClicked())
                buttons[r][c+1].mousePressed();
            if(isValid(r-1,c) && !buttons[r-1][c].isClicked())
                buttons[r-1][c].mousePressed();
            if(isValid(r+1,c) && !buttons[r+1][c].isClicked())
                buttons[r+1][c].mousePressed();
            if(isValid(r+1,c+1) && !buttons[r+1][c+1].isClicked())
                buttons[r+1][c+1].mousePressed();
            if(isValid(r-1,c-1) && !buttons[r-1][c-1].isClicked())
                buttons[r-1][c-1].mousePressed();
            if(isValid(r+1,c-1) && !buttons[r+1][c-1].isClicked())
                buttons[r+1][c-1].mousePressed();
            if(isValid(r-1,c+1) && !buttons[r-1][c+1].isClicked())
                buttons[r-1][c+1].mousePressed();
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        // else if( clicked && bombs.contains(this) ) 
        //     fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        
        if((r >= 0 && r < NUM_ROWS) && (c >= 0 && c < NUM_COLS))
        {
            return true;
        }
        return false;
    }

    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(r,c+1) == true && bombs.contains(buttons[r][c+1]))
            numBombs++;
        if(isValid(r+1,c+1) == true && bombs.contains(buttons[r+1][c+1]))
            numBombs++;
        if(isValid(r-1,c+1) == true && bombs.contains(buttons[r-1][c+1]))
            numBombs++;
        if(isValid(r+1,c) == true && bombs.contains(buttons[r+1][c]))
            numBombs++;
        if(isValid(r-1,c) == true && bombs.contains(buttons[r-1][c]))
            numBombs++;
        if(isValid(r+1,c-1) == true && bombs.contains(buttons[r+1][c-1]))
            numBombs++;
        if(isValid(r,c-1) == true && bombs.contains(buttons[r][c-1]))
            numBombs++;
        if(isValid(r-1,c-1) == true && bombs.contains(buttons[r-1][c-1]))
            numBombs++;
        
        return numBombs;
    }
}



