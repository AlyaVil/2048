var S = 4;//Size of the board [2 - 15]

var nums = [0,2,4,8,16,32,64,128,256,512,1025,2048,4096,8192],board = [],input=[];

void setup(){
  size(400,400,P2D);
  textFont(createFont("Arial Bold"));
  colorMode(HSB);
  strokeWeight(10);
  rectMode(CENTER);
  textAlign(CENTER,CENTER);
}
//makes the nested array for board[]
for(var x=0;x<S;x++){
    var ta = [];
    for(var y=0;y<S;y++){
        ta.push(0);
    }
    board.push(ta);
}


//Finds all open tiles and picks a random one to add a tile to.
var addPoint = function(){
    var openPoints = [];
    for(var x=0;x<S;x++){
        for(var y=0;y<S;y++){
            if(board[x][y]===0){
                openPoints.push([x,y]);   
            }    
        }
    }    
    if(openPoints.length<=0){println("you lose");}
    else{
       var t = openPoints[~~random(0,openPoints.length)];
       board[t[0]][t[1]]=1;
    }
};

//Adds the started tiles
addPoint();
addPoint();

//Array method for adding Zeros to fill an array
Array.prototype.addZeros = function(){
    for(var i=this.length;i<S;i++){
        this[i]=0;
    }    
};

//Array method for removing all Zeros
Array.prototype.removeZeros = function(){
    var ar = [];
    for(var i=0;i<this.length;i++){
        if(this[i]!==0){
            ar.push(this[i]);
        }
    }    
    return ar;
};

//Add together all the values in the array
//[0,2,0,2] -> [0,0,0,4]
var addrow=function(a){
    a=a.removeZeros();
    if(a.length>=1){
        for(var i=1;i<a.length;i++){
            if(a[i-1]===a[i]){
                a[i]=a[i]+1;
                a[i-1]=0;
            }    
        }
        a=a.removeZeros();
    }    
    a.addZeros();
    return a;
};


//Runs when the user releases a key
void keyReleased(){
    input[keyCode] = true;
    
    if(input[UP]){
        for(var x=0;x<S;x++){
            var row = [];
            row=board[x];
            row = addrow(row);
            board[x]=row;
        }        
    }
    if(input[LEFT]){
        for(var y=0;y<S;y++){
            var row = [];
            for(var x=0;x<S;x++){
                row[x]=board[x][y];
            }
            row = addrow(row);
            for(var x=0;x<S;x++){
                board[x][y]=row[x];
            }
        }        
    }
    
    if(input[DOWN]){
        for(var x=S-1;x>=0;x--){
            var row = [];
            row=board[x].reverse();
            row = addrow(row);
            board[x]=row.reverse();
            
        }        
    }
    if(input[RIGHT]){
        for(var y=S-1;y>=0;y--){
            var row = [];
            for(var x=0;x<S;x++){
                row[x]=board[x][y];
            }
            row.reverse();
            row = addrow(row);
            row.reverse();
            for(var x=0;x<S;x++){
                board[x][y]=row[x];
            }
        }        
    }
    addPoint();
    input[keyCode] = false;
};

draw = function() {
    textSize(map(S,3,15,35,8));
    
    //Draws the board+tiles
    for(var x=0;x<S;x++){
        for(var y=0;y<S;y++){
            
            var X = map(x,0,S,0,400)+(200/S);
            var Y = map(y,0,S,0,400)+(200/S);
            
            fill(map(board[x][y],1,nums.length,0,255), board[x][y]===0?0:155, 225);
            stroke(map(board[x][y],1,nums.length,0,255), board[x][y]===0?0:155, 215);
            rect(X,Y,(400/S)-10,(400/S)-10);
            
            fill(225);
            text(board[x][y]!==0?nums[board[x][y]]:"",X,Y);
        }    
    }
}
