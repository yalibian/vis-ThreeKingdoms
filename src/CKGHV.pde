class Table {
  String[][] data;
  int rowCount;
  
  
  Table() {
    data = new String[10][10];
  }

  
  Table(String filename) {
    String[] rows = loadStrings(filename);
    data = new String[rows.length][];
    
    for (int i = 0; i < rows.length; i++) {
      if (trim(rows[i]).length() == 0) {
        continue; // skip empty rows
      }
      if (rows[i].startsWith("#")) {
        continue;  // skip comment lines
      }
      
      // split the row on the tabs
      String[] pieces = split(rows[i], ",");
      // copy to the table array
      data[rowCount] = pieces;
      rowCount++;
      
      // this could be done in one fell swoop via:
      //data[rowCount++] = split(rows[i], TAB);
    }
    // resize the 'data' array as necessary
    data = (String[][]) subset(data, 0, rowCount);
  }


  int getRowCount() {
    return rowCount;
  }
  
  
  // find a row by its name, returns -1 if no row found
 // int getRowIndex(String name) {
 //   for (int i = 0; i < rowCount; i++) {
 //     if (data[i][0].equals(name)) {
 //       return i;
 //     }
 //   }
 //   println("No row named '" + name + "' was found");
 //   return -1;
 // }
  
  
  String getRowName(int row) {
    return getString(row, 0);
  }


  String getString(int rowIndex, int column) {
    return data[rowIndex][column];
  }

  
//  String getString(String rowName, int column) {
//    return getString(getRowIndex(rowName), column);
//  }

  
//  int getInt(String rowName, int column) {
//    return parseInt(getString(rowName, column));
//  }

  
  int getInt(int rowIndex, int column) {
    return parseInt(getString(rowIndex, column));
  }

  
//  float getFloat(String rowName, int column) {
//    return parseFloat(getString(rowName, column));
//  }

  
  float getFloat(int rowIndex, int column) {
    return parseFloat(getString(rowIndex, column));
  }
  
  
  void setRowName(int row, String what) {
    data[row][0] = what;
  }


  void setString(int rowIndex, int column, String what) {
    data[rowIndex][column] = what;
  }

  
//  void setString(String rowName, int column, String what) {
//    int rowIndex = getRowIndex(rowName);
//    data[rowIndex][column] = what;
//  }

  
  void setInt(int rowIndex, int column, int what) {
    data[rowIndex][column] = str(what);
  }

  
//  void setInt(String rowName, int column, int what) {
//    int rowIndex = getRowIndex(rowName);
//    data[rowIndex][column] = str(what);
//  }

  
  void setFloat(int rowIndex, int column, float what) {
    data[rowIndex][column] = str(what);
  }


//  void setFloat(String rowName, int column, float what) {
//    int rowIndex = getRowIndex(rowName);
//    data[rowIndex][column] = str(what);
//  }
  
  
  // Write this table as a TSV file
  void write(PrintWriter writer) {
    for (int i = 0; i < rowCount; i++) {
      for (int j = 0; j < data[i].length; j++) {
        if (j != 0) {
          writer.print(TAB);
        }
        if (data[i][j] != null) {
          writer.print(data[i][j]);
        }
      }
      writer.println();
    }
    writer.flush();
  }
}




//绘制代码
PImage bg;
PImage zhouimage;
PImage map;
PImage[][] map2;
PImage mark;
PImage mark2;
PImage bar;
PImage mode1,mode2,mode3;
//二级菜单
PImage mode1B[],mode2B[],mode3B[];
//三级菜单
PImage mode1C[],mode3C[];
PImage currentbattleimage[];

PImage cimage[],fimage[];
PImage relationimage[];

//人物关系图头像
PImage portrait,portrait2;
PImage lineleft,lineright;

PImage battletag1,battletag2,battletag3;
PImage placetag1,placetag2,placetag3;

PImage cbuttonA,cbuttonA2,cbuttonB,cbuttonB2;

PImage zhanzheng,renwu,dili;
PImage shu,wei,wu,ta,jin;
PImage qunxiong,chengba,sanzu,zhongjie;

PImage home,scolor;

PImage left,left2,right,right2;
String lefttag,righttag,lefttagyear,lefttagplace,righttagyear,righttagplace;

Table battletable;
Table charactertable;
Table placetable;

Table[] battlestage;
Table[] relationtable;
int[] relcount;

//1 战争  2  地理  3 人物
int currentMode = 0;
int currentMode2=0;
//三国时期共4个阶段
int currentSection=0;
//三国时期共5个国家
int currentCountry=0;
//共14场战争
int currentBattle=0;
int currentBattle2=0;

int currentRel=0;

//共14个地点
int currentPlace=0;
int currentPlace2=0;
//共16个人物
int currentCharacter=0;
int currentCharacter2=0;

int currentcharactermode=1;

int relsum=0;

int battlestageid=1;

Table introduction;

//角色行踪
int characterstage=1;
Table[] characterstagetable;
int[] stagecount;

int[] chaptersum;


//每个州的表格里记录了所含郡的信息
Table juntable;
int juncount;
//当前郡（需要重置）
int currentjun=0;

void setup(){
  size(1360,800);
  //加载图片
  map=loadImage("map.png");
  mark=loadImage("mark.png");
  mark2=loadImage("mark2.png");
  home=loadImage("home.png");
  bar=loadImage("bar.png");
  mode1=loadImage("mode1.png");
  mode2=loadImage("mode2.png");
  mode3=loadImage("mode3.png");
  bg=loadImage("bg.png");
  
  zhanzheng=loadImage("zhanzheng.png");
  dili=loadImage("dili.png");
  renwu=loadImage("renwu.png");
  scolor=loadImage("color.png");
  
  shu=loadImage("shu.png");
  wei=loadImage("wei.png");
  wu=loadImage("wu.png");
  ta=loadImage("ta.png");
  jin=loadImage("jin.png");
  
  qunxiong=loadImage("qunxiong.png");
  chengba=loadImage("chengba.png");
  sanzu=loadImage("sanzu.png");
  zhongjie=loadImage("zhongjie.png");
  
  battletag1=loadImage("battletag1.png");
  battletag2=loadImage("battletag2.png");
  battletag3=loadImage("battletag3.png");
  
  placetag1=loadImage("placetag1.png");
  placetag2=loadImage("placetag2.png");
  placetag3=loadImage("placetag3.png");
  
  cbuttonA=loadImage("characterbuttonA.png");
  cbuttonA2=loadImage("characterbuttonA2.png");
  cbuttonB=loadImage("characterbuttonB.png");
  cbuttonB2=loadImage("characterbuttonB2.png");
  
  lineleft=loadImage("lineleft.png");
  lineright=loadImage("lineright.png");
  
  //mode1B 战争
  mode1B=new PImage[4];
  for(int i=1;i<=4;i++){
    mode1B[i-1]=loadImage("mode1"+i+".png");
  }
  //mode2B 地理
  mode2B=new PImage[14];
  for(int i=1;i<=14;i++){
  mode2B[i-1]=loadImage("mode2p"+i+".png");
  }
  //mode3B  人物
  mode3B=new PImage[5];
  for(int i=1;i<=5;i++){
    mode3B[i-1]=loadImage("mode3"+i+".png");
  }
  //mode1C  战争
  mode1C=new PImage[14];
  for(int i=1;i<=14;i++){
   mode1C[i-1]=loadImage("mode1b"+i+".png");
  }
  //mode3C  人物
  mode3C=new PImage[16];
  for(int i=1;i<=16;i++){
    mode3C[i-1]=loadImage("mode3c"+i+".png");
  }
  currentbattleimage=new PImage[14];  
  for(int i=1;i<=14;i++){
  currentbattleimage[i-1]=loadImage("b"+i+".png");
  }
  
  cimage=new PImage[16];
  for(int i=1;i<=16;i++){
  cimage[i-1]=loadImage("c"+i+".png");
  }
  
  fimage=new PImage[5];
  for(int i=1;i<=5;i++){
  fimage[i-1]=loadImage("f"+i+".png");
  }
  
  relationimage=new PImage[16];
  for(int i=1;i<=16;i++){
  relationimage[i-1]=loadImage("relation"+i+".png");
  }
  
  map2=new PImage[14][5];
  for(int i=1;i<=14;i++){
    for(int j=1;j<=5;j++){
    String si=i+"";
    String sj=j+"";
    map2[i-1][j-1]=loadImage(si+sj+".png");    
    }
  }
  
  introduction=new Table("introduction.csv");
  left=loadImage("left.png");
  left2=loadImage("left2.png");
  right=loadImage("right.png");
  right2=loadImage("right2.png");
  
  //加载表格
  battletable=new Table("battle.csv");
  charactertable=new Table("character.csv");
  placetable=new Table("place.csv");
  
  battlestage=new Table[14];
  for(int i=1;i<=14;i++){
  battlestage[i-1]=new Table(i+".csv");
 }
  
  relationtable=new Table[16];
  relcount=new int[16];
 //人物行踪  
 characterstagetable=new Table[16];
 stagecount=new int[16]; 
 for(int i=1;i<=16;i++){
  characterstagetable[i-1]=new Table("action"+i+".csv");
  stagecount[i-1]=characterstagetable[i-1].getRowCount();
 }

 chaptersum=new int[15];
 relationtable=new Table[16];
 
  char[] charset = {'\u8AF8','\u345B'};
  PFont font = createFont("MicrosoftYaHei", 32, true, charset); 
  //绘制文字
  textAlign(LEFT,TOP);
  textFont(font);
  
  chaptersum[0]=0;
  chaptersum[1]=2;
  for(int i=2;i<=14;i++){
    int chaptercount=battletable.getInt(i,2);
    chaptersum[i]=chaptersum[i-1]+chaptercount; 
}
}

void draw(){
  background(255);
  imageMode(CORNER);
  image(bg,0,0);
  //绘制一个第四级扇形 宽25px
  
  imageMode(CENTER);
  image(scolor,960,40);
  image(home,1200,30);
  
  fill(#F0E796);
  noStroke();
  arc(390,450,710,710,-PI/2,PI/6);
  
  //绘制小细线
  stroke(255);
  strokeWeight(1);
  for(int i=-89;i<30;i++){
  float angle2=radians(i);
  float x2=390+355*cos(angle2);
  float y2=450+355*sin(angle2);  
  line(390,450,x2,y2);
  }
   
  //绘制noverview
  if(currentMode2 == 3 && currentCharacter>0){
  for(int i=1;i<=120;i++)
  {
  Float tf=charactertable.getFloat(currentCharacter,i+3);
  
  if(tf>=1)
  //红色
  stroke(#f24343);
  else
  {
  if(tf<0)
  //蓝色
  {
  stroke(#4283e5);
  tf=-tf;
  }
  else
  {
  if(tf>0 && tf<1)
  //白色
  {
  fill(#ffffff);
  tf=tf*100;  
}
  }
  }
    
  if(tf != 0){
  Float rectlength=5*tf/24;
  Float rr=330+rectlength;
  Float rangle=radians(i-0.5);
  Float rx=390+rr*sin(rangle);
  Float ry=450-rr*cos(rangle);
  strokeWeight(3);
  line(390,450,rx,ry);
  }
  
  }
  }
  
    
  //绘制两个第三级扇形
  //淡紫色人物
  fill(#DBAACC);
  noStroke();
  arc(390,450,660,660,radians(142),3*PI/2);
  
  //绘制小细线
  stroke(255);
  strokeWeight(1);
  for(int i=60;i<180;i=i+8){
  float angle1=radians(i)+PI/2;
  float x1=390+330*cos(angle1);
  float y1=450+330*sin(angle1);  
  line(390,450,x1,y1);
  }
 
  //写人物名
  pushMatrix();
  translate(390,450);
  
  rotate(-PI*0.7);
  float rotateangle=radians(8);
  for(int i=1;i<=16;i++){
  textSize(13);
  String charactername=charactertable.getString(i,1);
  fill(30);
  text(charactername,0,-323);
  rotate(rotateangle);
  }
  popMatrix(); 
   
  //淡黄色战争
  fill(#EDDB81);
  noStroke();
  arc(390,450,660,660,-PI/2,PI/6);
  
  //绘制小细线
  stroke(255);
  strokeWeight(1);
  float anglesum=-PI/2;
  for(int i=1;i<15;i++){
  int count=battletable.getInt(i,2);
  float angle=radians(count);
  anglesum=anglesum+angle;
  float x2=390+330*cos(anglesum);
  float y2=450+330*sin(anglesum);  
  line(390,450,x2,y2);
  }
  
  //分割线
  stroke(255);
  strokeWeight(2);
  line(390,450,390,15);
  
  //再绘制三个第二级扇形
  //紫色人物
  fill(#C862D8);
  noStroke();
  arc(390,450,600,600,radians(142),3*PI/2);
  
  //绘制4条细线
  stroke(255);
  strokeWeight(2);
  line(390,450,390+300*cos(PI/2+radians(108)),450+300*sin(PI/2+radians(108)));
  line(390,450,390+300*cos(PI/2+radians(124)),450+300*sin(PI/2+radians(124)));
  line(390,450,390+300*cos(PI/2+radians(148)),450+300*sin(PI/2+radians(148)));
  line(390,450,390+300*cos(PI/2+radians(164)),450+300*sin(PI/2+radians(164)));
  
  
  imageMode(CENTER);
  pushMatrix();
  translate(390,450);
  
  rotate(-PI*0.56);  
  textSize(15);
  fill(30);
  image(shu,0,-285);
  
  rotate(0.65);
  image(wei,0,-285);
  
    rotate(0.35);
  image(wu,0,-285);
  
    rotate(0.35);
  image(ta,0,-285);
  
  rotate(0.25);  
  image(jin,0,-285);
  popMatrix();
  
  //黄色战争
  fill(#D3C060);
  noStroke();
  arc(390,450,600,600,-PI/2,PI/6);
  //绘制3条细线
  stroke(255);
  strokeWeight(2);
  line(390,450,390+300*cos(-PI/2+radians(33)),450+300*sin(-PI/2+radians(33)));
  line(390,450,390+300*cos(-PI/2+radians(50)),450+300*sin(-PI/2+radians(50)));
  line(390,450,390+300*cos(-PI/2+radians(105)),450+300*sin(-PI/2+radians(105)));
  
  //阶段文字
  pushMatrix();
  translate(390,450);
  
  rotate(-1.9*PI);  
  textSize(15);
  fill(30);
  image(qunxiong,0,-285);
  
  rotate(0.42);
  image(chengba,0,-285);
  
    rotate(0.6);
  image(sanzu,0,-285);
  
    rotate(0.63);
  image(zhongjie,0,-285);

  popMatrix();
  
  //绿色地理
  fill(#4DCE8A);
  noStroke();
  arc(390,450,600,600,PI/6,PI/6+radians(112));
  //绘制13条细线
  stroke(255);
  strokeWeight(2);
  for(int i=1;i<14;i++){
    float angle=PI/6+radians(i*8);
    line(390,450,390+300*cos(angle),450+300*sin(angle));
  }
  
    //写地区名
  pushMatrix();
  translate(390,450);
  
  rotate(-PI*0.3+radians(1));
  for(int i=1;i<=14;i++){
  fill(30);
  textSize(14);
  String placename=placetable.getString(i,1);
  text(placename,0,272);
  rotate(rotateangle);
  }
  popMatrix();
    
  //绘制3个第一级扇形
  //黄色战争
  fill(#A59121);
  noStroke();
  arc(390,450,540,540,-PI/2,PI/6);
  //绿色地理
  fill(#319856);
  noStroke();
  arc(390,450,540,540,PI/6,PI/6+radians(112));
  //紫色人物
  fill(#7D297E);
  noStroke();
  arc(390,450,540,540,PI/6+radians(112),3*PI/2);
  
  //绘制3条分割线
  stroke(255);
  strokeWeight(2);
  line(390,450,390,70);
  line(390,450,390+300*cos(PI/6),450+300*sin(PI/6));
  line(390,450,390+300*cos(PI/6+radians(112)),450+300*sin(PI/6+radians(112)));
  
  //战争  地理   人物
  textSize(17);
  fill(255);
  
  pushMatrix();
  translate(390,450);
  
  rotate(-1.7*PI);  
  image(zhanzheng,0,-255);
  
  rotate(PI/1.45);
  image(dili,0,-255);
  
  rotate(PI/1.5);
  image(renwu,0,-255);

  popMatrix();

  
  //绘制左方框框
  stroke(180);
  strokeWeight(2);
  fill(255);
  rect(780,80,490,720);
  
  if(currentMode2 == 0){
  textSize(28);
  fill(0);
  text("CKGHV",820,100);
  textSize(14);
  text("A Comprehensive Knowledge Graph For History Visualization",820,130);
  
  for(int i=1;i<4;i++){
  String introtitle=introduction.getString(i,1);
  String introinfo=introduction.getString(i,2);
  textSize(20);
  fill(80);
  text(introtitle,830,i*200-30);
  fill(140);
  textSize(14);
  text(introinfo,830,i*200,350,330);
  }
  }
    
  //交互
  Float r=dist(mouseX,mouseY,390,450);
  Float r2=dist(mouseX,mouseY,390,180);
  Float r3=dist(mouseX,mouseY,390+135*sqrt(3),585);
  
  Float battleangle=acos((270*270+r*r-r2*r2)/(540*r));
  
  Float characterangle=battleangle;
  Float placeangle=acos((270*270+r*r-r3*r3)/(540*r)); 
      
   //鼠标位于战争环内
   if(battleangle>=0 && battleangle <=PI*2/3 && mouseX>=390){
     if(r>240 && r<355){
      setcurrentMode(1);
   
        fill(#FF8E24,100);
        noStroke();
        arc(390,450,540,540,-PI/2,PI/6);  

        if(r>270 && r<330){
          
        if(battleangle>=0 && battleangle <=radians(33) && mouseX>=390)
        {
        currentSection=1;
        fill(#FF8E24,100);
        noStroke();
        arc(390,450,600,600,-PI/2,-PI/2+radians(33));
        }
         else{
         if(battleangle>=radians(33) && battleangle <=radians(50) && mouseX>=390)
         {
        currentSection=2;
        fill(#FF8E24,100);
        noStroke();
        arc(390,450,600,600,-PI/2+radians(33),-PI/2+radians(50)); 
         }
         else
         {
        if(battleangle>=radians(50) && battleangle <=radians(105) && mouseX>=390){
        currentSection=3;
        fill(#FF8E24,100);
        noStroke();
        arc(390,450,600,600,-PI/2+radians(50),-PI/2+radians(105)); 
         }
           else{
         if(battleangle>=radians(105) && battleangle <= 2*PI/3 && mouseX>=390){
         currentSection=4;   
         fill(#FF8E24,100);
         noStroke();
         arc(390,450,600,600,-PI/2+radians(105),PI/6); 
         }
         }
         }
         }
         
        }
        //具体战争环内
        if(r>300 && r<330){
       for(int i=0;i<=13;i++){           
        if(battleangle>=radians(chaptersum[i]) && battleangle <= radians(chaptersum[i+1]) && mouseX>=390){
          
          setcurrentBattle2(i+1);
          
          fill(#FF8E24,100);
          noStroke();
          arc(390,450,710,710,-PI/2+radians(chaptersum[i]),-PI/2+radians(chaptersum[i+1]));   
                       
          fill(0);
          textSize(15);
          String battlename=battletable.getString(i+1,1);
          
          String chapterstart=battletable.getString(i+1,3);
          String chapterstop=battletable.getString(i+1,4);
          
          String battlestart=battletable.getString(i+1,5);
          String battlestop=battletable.getString(i+1,6);
          text(battlename,mouseX,mouseY);
          text("Year:"+battlestart+"~"+battlestop,mouseX,mouseY+20);
          text("Chapter:"+chapterstart+"~"+chapterstop,mouseX,mouseY+40);
          
          //点击某个战争后  设置当前战争编号
          
          if(mousePressed){
          setcurrentBattle(i+1);
          //mode2为0时显示说明简介文字（包括三国和系统介绍） 点击后切换到相应模式内的具体信息
          
          //战争信息模式 包括标签云 地标  文字等
          setcurrentMode2(1);
          //重置
          setcurrentRel(0);
          setcurrentjun(0);
          currentcharactermode=1;
          characterstage=1;
          battlestageid=1;
          }
          
          }          
        }
        }
      
     }
   }
   
    //鼠标位于地理环内
    if(placeangle>=0 && placeangle <= radians(112) && mouseY > 390 && battleangle >= PI*2/3)
    {
      
      if(r>240 && r<300){
        //mode为暂时性的
       setcurrentMode(2);
       
       fill(#FF8E24,100);
       noStroke();
       arc(390,450,540,540,PI/6,PI/6+radians(112)); 
       
      if(r>270 && r<300){
         for(int i=1;i<=14;i++){
           if(placeangle >radians((i-1)*8) && placeangle < radians(i*8)){
             currentPlace2=i;
             arc(390,450,600,600,PI/6+radians((i-1)*8),PI/6+radians(i*8));
             if(mousePressed){
             setcurrentPlace(i);
             setcurrentMode2(2);
             loadPlace(currentPlace);
            //重置关系
             setcurrentRel(0);
            //重置人物模式 
             currentcharactermode=1;
             characterstage=1;
             battlestageid=1;
            //重置郡
            setcurrentjun(0);
             }
           }
         }
       }
      }      
    }
    
    
   //鼠标位于人物环内
   if(characterangle>=0 && characterangle <= radians(128) && mouseX<=390)
   {
     if(r>240 && r<330){
      setcurrentMode(3);
      
      fill(#FF8E24,100);
      noStroke();
      arc(390,450,540,540,PI/6+radians(112),PI*3/2); 
      
      //currentcountry
        if(r>270 && r<330){   
          
        if(characterangle>=radians(72) && characterangle <=radians(128) && mouseX<=390)
        {
        currentCountry=1;
        arc(390,450,600,600,PI/6+radians(112),PI/6+radians(168));
        }
         else{
         if(characterangle>=radians(56) && characterangle <=radians(72) && mouseX<=390)
         {
        currentCountry=2;
        arc(390,450,600,600,PI/6+radians(168),PI/6+radians(184)); 
         }
         else
         {
        if(characterangle>=radians(32) && characterangle <=radians(56) && mouseX<=390){
        currentCountry=3;
        arc(390,450,600,600,PI/6+radians(184),PI/6+radians(208)); 
         }
         else{
         if(characterangle>=radians(16) && characterangle <= radians(32) && mouseX<=390){
         currentCountry=4;   
         arc(390,450,600,600,PI/6+radians(208),PI/6+radians(224)); 
         }
         else{
         if(characterangle>=radians(0) && characterangle <= radians(16) && mouseX<=390){
         currentCountry=5;   
         arc(390,450,600,600,PI/6+radians(224),3*PI/2); 
         }
         }
         }
         }
         }         
        }
        
        //具体人物环内
        if(r>300 && r<330){
       for(int i=1;i<=16;i++){           
        if(characterangle<=radians(128-(i-1)*8) && characterangle >= radians(128-i*8) && mouseX<=390){
          
          currentCharacter2=i;
          
          fill(#FF8E24,100);
          noStroke();
          arc(390,450,660,660,PI/6+radians(112+(i-1)*8),PI/6+radians(112+i*8));   
          
          if(mousePressed){
          setcurrentCharacter(i);
          //mode2为0时显示说明简介文字（包括三国和系统介绍） 点击后切换到相应模式内的具体信息          
          //人物信息模式 包括关系图 行踪图等
          setcurrentMode2(3);
          setcurrentRel(0);
          setcurrentjun(0);
          currentcharactermode=1;
         characterstage=1;
        battlestageid=1; 
          }
          
          }          
        }
        }
      
     }
    }
     

  //绘制右方尖形标签
  if(currentMode != 0 ){
    switch(currentMode){
    case 1:
    image(mode1,50,90);
    break;
      case 2:
    image(mode2,50,90);
    break;
      case 3:
    image(mode3,50,90);
    break;
    }
  }
    if(currentMode == 1 && currentSection != 0 )
    image(mode1B[currentSection-1],120,90);

  
  //battle2为暂时行 battle为永恒性
    if(currentMode == 1 && currentBattle2 != 0)
    image(mode1C[currentBattle2-1],190,90);
    
    //绘制地理标签
    if(currentMode == 2 && currentPlace2 != 0)
    image(mode2B[currentPlace2-1],120,90);
    
    //绘制人物标签
    if(currentMode == 3 && currentCountry != 0 )
    image(mode3B[currentCountry-1],120,90);
    
    if(currentMode == 3 && currentCharacter2 != 0)
    image(mode3C[currentCharacter2-1],190,90);
    
      
  //绘制中央地图
  imageMode(CENTER);
  image(map,390,450);
  
  currentMode=0;
  currentSection=0;
  currentCountry=0;
  currentBattle2=0;
  currentPlace2=0;
  currentCharacter2=0;
  
  
  //绘制在currentBattle（静态）下的内容  currentMode2(静态)  即点击标签后显示的内容
  //战争内容的绘制标签云
  if(currentMode2 == 1 && currentBattle > 0)
  { 
   
   image(currentbattleimage[currentBattle-1],1020,220);
   image(battletag1,875,100);   
   String battleinfo=battletable.getString(currentBattle,7);
   String battlename=battletable.getString(currentBattle,1);
   
   image(battletag2,875,340);   
   fill(0);
   textSize(20);
   text(battlename,980,360);
   textSize(14);
   text(battleinfo,850,400,350,300);
   
   image(battletag3,875,580);
 
  //左边按钮
  image(left,830,700,30,30);
  image(right,1220,700,30,30);
  
  if(mouseX <850 && mouseX>820 && mouseY>690 && mouseY<720){
  image(left2,830,700,30,30);
  }
  else{
    //右边按钮
  if(mouseX < 1230 && mouseX > 1200 && mouseY>690 && mouseY<720){
  image(right2,1220,700,30,30);
  }
  }
  //绘制地图阴影和文字信息 加载的是battlestage[currentBattle-1]   battlestageid为第几行
    for(int i=1;i<=14;i++){
      int battlezhou=battlestage[currentBattle-1].getInt(battlestageid,i);
      if(battlezhou != 0){
        image(map2[i-1][battlezhou-1],390,450);
        //当前阶段的标题
        
      }
    }
  String battletitle=battlestage[currentBattle-1].getString(battlestageid,15);
  String battleinfo2=battlestage[currentBattle-1].getString(battlestageid,16);
  String battleplace=battlestage[currentBattle-1].getString(battlestageid,17);
  float battlex=battlestage[currentBattle-1].getFloat(battlestageid,18);
  float battley=battlestage[currentBattle-1].getFloat(battlestageid,19);
  image(mark,battlex+150,battley+210,40,40);
  text(battleplace,battlex+150,battley+210);
  
  text(battleinfo2,860,680,320,300);
  textSize(20);
  text(battletitle,970,650);
  }

    //用户交互
    
    if(currentCharacter > 0 ){
    relationtable[currentCharacter-1]=new Table("relation"+currentCharacter+".csv");
    relcount[currentCharacter-1]=relationtable[currentCharacter-1].getRowCount();
    }
    

        
 //绘制人物信息
 if(currentMode2 == 3 && currentCharacter>0)
 {
  //绘制按钮（仅限人物3模式）
  if(currentcharactermode == 1){
    int force2=charactertable.getInt(currentCharacter,2);
    switch(force2){
    case 1:
    fill(#C4F0C6);
    break;
    case 2:
    fill(#C4C6F0);
    break;
    case 3:
    fill(#F0D0C4);
    break;
    case 4:
    fill(#F0EBC4);
    break;
    case 5:
    fill(#C4F0EC);
    break;
    }
    noStroke();
    rect(810,180,430,300);
    
    image(cbuttonA2,960,130);
    image(cbuttonB,1100,130);
    
  //人物头像
  int force=charactertable.getInt(currentCharacter,2);
  image(cimage[currentCharacter-1],890,250,120,120);
  image(fimage[force-1],840,220,60,60);
     
  String charactername=charactertable.getString(currentCharacter,1);
  String characterinfo=charactertable.getString(currentCharacter,3);
  fill(0);
  textSize(25);
  text(charactername,960,200);
  textSize(14);
 //人物文字介绍
  text(characterinfo,960,240,250,400);
  //timeline
  
  //左边按钮
  image(left,830,550,30,30);
  image(right,1220,550,30,30);
  
  if(mouseX <850 && mouseX>820 && mouseY>540 && mouseY<570){
  image(left2,830,550,30,30);
  }
  else{
    //右边按钮
  if(mouseX < 1230 && mouseX > 1200 && mouseY>540 && mouseY<570){
  image(right2,1220,550,30,30);
  }
  }
  //左右预览标签
  
  
  if(characterstage != 1 && characterstage != stagecount[currentCharacter-1]-1){
  lefttag=characterstagetable[currentCharacter-1].getString(characterstage-1,4);
  righttag=characterstagetable[currentCharacter-1].getString(characterstage+1,4);
  
  lefttagyear=characterstagetable[currentCharacter-1].getString(characterstage-1,6);
  righttagyear=characterstagetable[currentCharacter-1].getString(characterstage+1,6);
  
  lefttagplace=characterstagetable[currentCharacter-1].getString(characterstage-1,1);
  righttagplace=characterstagetable[currentCharacter-1].getString(characterstage+1,1);
  
  }
  else
  {
    if(characterstage == 1){
  lefttag=characterstagetable[currentCharacter-1].getString(stagecount[currentCharacter-1]-1,4);
  righttag=characterstagetable[currentCharacter-1].getString(2,4);
  
    lefttagyear=characterstagetable[currentCharacter-1].getString(stagecount[currentCharacter-1]-1,6);
  righttagyear=characterstagetable[currentCharacter-1].getString(2,6);
  
    lefttagplace=characterstagetable[currentCharacter-1].getString(stagecount[currentCharacter-1]-1,1);
  righttagplace=characterstagetable[currentCharacter-1].getString(2,1);
    }
    else{
    if(characterstage == stagecount[currentCharacter-1]-1){
  lefttag=characterstagetable[currentCharacter-1].getString(stagecount[currentCharacter-1]-2,4);
  righttag=characterstagetable[currentCharacter-1].getString(1,4);
  
    lefttagyear=characterstagetable[currentCharacter-1].getString(stagecount[currentCharacter-1]-2,6);
  righttagyear=characterstagetable[currentCharacter-1].getString(1,6);
  
    lefttagplace=characterstagetable[currentCharacter-1].getString(stagecount[currentCharacter-1]-2,1);
  righttagplace=characterstagetable[currentCharacter-1].getString(1,1);
    }
    }
  }
  
  textSize(14);
  fill(150);
  text(lefttag,820,570);
  text(righttag,1160,570);
  
  text(lefttagyear,830,590);
  text(righttagyear,1170,590);
  
  text(lefttagplace,830,610);
  text(righttagplace,1170,610);
  
  //绘制当前characterstage内容
  String cstagetitle=characterstagetable[currentCharacter-1].getString(characterstage,4);
  String cstageplace=characterstagetable[currentCharacter-1].getString(characterstage,1);
  int cstagex=characterstagetable[currentCharacter-1].getInt(characterstage,2);
  int cstagey=characterstagetable[currentCharacter-1].getInt(characterstage,3);
  
  String cstageinfo=characterstagetable[currentCharacter-1].getString(characterstage,5);
  int cstagetime=characterstagetable[currentCharacter-1].getInt(characterstage,6);
  int cstagezhouid=characterstagetable[currentCharacter-1].getInt(characterstage,7);
  cstagezhouid=cstagezhouid-1;
  
  fill(0);
  textSize(20);
  text(cstagetitle,920,550);
  textSize(15);
  text(cstagetime,1050,540);
  text(cstageplace,1050,560);
  textSize(13);
  fill(100);
  text(cstageinfo,880,600,270,200);
    
  //绘制时间轴
  fill(200);
  noStroke();
  rect(800,680,450,80);
   
  fill(#008EF7);
  textSize(10);
  text(cstagetime,1015,760);
  
  for(int i=1;i<=7;i++){
    line(1025+i*30,760,1025+i*30,755);
    fill(150);
    text(cstagetime+i,1015+i*30,760);
    line(1025-i*30,760,1025-i*30,755);
    text(cstagetime-i,1015-i*30,760);
    
    for(int j=1;j<stagecount[currentCharacter-1];j++){
      int csyear=characterstagetable[currentCharacter-1].getInt(j,6);
      //右方有事件
      if(csyear == cstagetime+i){      
      String rcstagetitle=characterstagetable[currentCharacter-1].getString(j,4);  
      stroke(100);
      strokeWeight(1);
      line(1025+i*30,680,1025+i*30,760);
      
      fill(230);
      rect(955+i*30,720,70,25);
      textSize(11);
      fill(100);
      text(rcstagetitle,965+i*30,725);
  
      }      
      else{
      //左方有事件
      if(csyear == cstagetime-i){
      String lcstagetitle=characterstagetable[currentCharacter-1].getString(j,4);  
      stroke(100);
      strokeWeight(1);
      line(1025-i*30,680,1025-i*30,760);
      
      fill(230);
      rect(1025-i*30,720,70,25);
      textSize(11);
      fill(100);
      text(lcstagetitle,1035-i*30,725);      
      }
      }
      
    }
  }
  
  //绘制线条和年份
  stroke(#008EF7);
  strokeWeight(2);
  line(800,760,1250,760);
  line(1025,680,1025,760);
  
  fill(255);
  rect(1025,690,70,25);
  textSize(12);
  fill(0);
  text(cstagetitle,1035,695);
  
  //绘制地图
  int belongs=charactertable.getInt(currentCharacter,2)-1;
  imageMode(CORNER);
  image(map2[cstagezhouid][belongs],150,210);
  imageMode(CENTER);
  
  image(mark2,cstagex+150,cstagey+210);
  fill(255,255,255,150);
  noStroke();
  rect(cstagex+140,cstagey+220,70,40);
  fill(0);
  text(cstageplace,cstagex+150,cstagey+220);
  text(cstagetitle,cstagex+150,cstagey+240);
  
  }
    
  //人物关系图  charactermode为2时
  else{
    image(cbuttonA,960,130);
    image(cbuttonB2,1100,130);
    
    //呈现关系图  共16张
    imageMode(CORNER);
    image(relationimage[currentCharacter-1],810,200,400,400);
    
    for(int i=2;i<relcount[currentCharacter-1];i++){        
    float relx= relationtable[currentCharacter-1].getFloat(i,4);
    float rely= relationtable[currentCharacter-1].getFloat(i,5);
    
    relx=relx*8/11+810;
    rely=rely*8/11+200;
    
    int relweight=relationtable[currentCharacter-1].getInt(i,3);
    relweight=abs(relweight);
    
    int min=relationtable[currentCharacter-1].getInt(1,4);
    int max=relationtable[currentCharacter-1].getInt(1,5);
    
    float relr=(relweight-2)*14/15+30;   
    relr=relr*8/11;
    float reldist=dist(mouseX,mouseY,relx,rely);
      
      if(reldist < relr){
      fill(#FFB92C,180);
      stroke(#FFB92C);
      strokeWeight(2);
      ellipseMode(CENTER);
      ellipse(relx,rely,relr*1.1,relr*1.1);
      
    if(mousePressed){
      setcurrentRel(i);
      loadimage(currentCharacter,currentRel);
      }
      
      }
    }
    
    //绘制两个头像+具体关系
    if(currentRel != 0){   
   image(portrait,820,600,100,100);
   image(portrait2,1130,600,100,100);
   
    String name1B=relationtable[currentCharacter-1].getString(1,6);
    String name2B=relationtable[currentCharacter-1].getString(currentRel,6);
    
    fill(0);
    textSize(14);
    text(name1B,860,700);
    text(name2B,1170,700);
   
 //绘制直线文字
    for(int i=7;i<7+relsum;i++){
      String reltext=relationtable[currentCharacter-1].getString(currentRel,i);
      fill(0);
      textSize(14);
      text(reltext,1000,600+(i-7)*25);
      int reldirect=relationtable[currentCharacter-1].getInt(currentRel,i+relsum);
      int relsize=relationtable[currentCharacter-1].getInt(currentRel,i+2*relsum);
      
      float rellineweight,relalpha;
      
      int arelsize=abs(relsize);
      
      if(arelsize != 0){      
      rellineweight=2+(arelsize-1)*2/3;
      relalpha=100+(arelsize-1)*140/9;
      }
      else
      {
      rellineweight=3;
      relalpha=150;
      }
      
      strokeWeight(rellineweight);
      if(relsize<0)
      //负面情感为红色
      stroke(#EA3626,relalpha);
      else{
        if(relsize == 0)
        stroke(#939393,relalpha);
        //正面情感为蓝色
        else
        stroke(#3559E3,relalpha);
      }
      
      line(940,620+(i-7)*25,1120,620+(i-7)*25);
      if(reldirect == 1){
        image(lineright,1120,612+(i-7)*25);
      }
      else{
      if(reldirect == 2)
       image(lineleft,925,612+(i-7)*25);
      else
      {
        image(lineright,1120,612+(i-7)*25);
        image(lineleft,925,612+(i-7)*25);
      }
      }
      
    }

 //绘制关系 
  }
  
  }//人物关系图
  
 }//绘制人物信息


  //绘制地理信息
  if(currentMode2 == 2 && currentPlace > 0){
    //说明条
    //圆圈 列出所含郡 州文字介绍 图片
    image(bar,390,250);
    String zhouname=placetable.getString(currentPlace,1);
    int zhoux=placetable.getInt(currentPlace,2);
    int zhouy=placetable.getInt(currentPlace,3);
    zhoux=zhoux+150;
    zhouy=zhouy+210;
    float zhouweight=placetable.getFloat(currentPlace,4);
    String zhouinfo=placetable.getString(currentPlace,5);
    String zhoubattle=placetable.getString(currentPlace,6);
    Float zhour=30+(zhouweight-1);
    Float zhoualpha=70+5*(zhouweight-1)/2;
    
    image(placetag1,875,100);
    image(zhouimage,1030,280);
    
    image(placetag2,875,420);
    fill(0);
    textSize(20);
    text(zhouname,990,450);
    
    textSize(14);
    text(zhouinfo,820,480,400,400);
    
    //地图上画圆
   float percent=norm(zhouweight,1,60);
   color between=lerpColor(#0071d1,#d10000,percent);
   fill(between,zhoualpha);
   noStroke();
   ellipse(zhoux,zhouy,zhour,zhour);
   
   textSize(16);
   fill(#762C00);
   text(zhoubattle,zhoux-80,zhouy-25);
   
   image(placetag3,875,590);
   //列出郡的信息 juntable  juncount
   for(int i=1;i<juncount;i++){
     

     
     String junname=juntable.getString(i,0);
     float junx=juntable.getFloat(i,1);
     float juny=juntable.getFloat(i,2);
     
     junx=junx+150;
     juny=juny+210;
     
     String juninfo=juntable.getString(i,3);
     String junpeople=juntable.getString(i,4);
     
     if(currentjun == i)  //选中为红色
     fill(#FFBFA7);
     else
     fill(#A7BFFF);
     
     //绘制矩形和郡县名
     if(i>0 && i<7){
       rect(820+(i-1)*70,620,68,25);
       fill(0);
       text(junname,840+(i-1)*70,620);
     if(mouseX > 820+(i-1)*70 && mouseX<888+(i-1)*70 && mouseY>620 && mouseY<645){
     if(mousePressed)
       currentjun=i;
     }
     }
     else{
     if(i>6 && i<13){
       rect(820+(i-7)*70,650,68,25);
       fill(0);
       text(junname,840+(i-7)*70,650);
    if(mouseX > 820+(i-7)*70 && mouseX<888+(i-7)*70 && mouseY>650 && mouseY<675){
     if(mousePressed)
       currentjun=i;
     }
     }
     else{
       rect(820+(i-13)*70,680,68,25);
       fill(0);
       text(junname,840+(i-13)*70,680);
       
      if(mouseX > 820+(i-13)*70 && mouseX<888+(i-13)*70 && mouseY>680 && mouseY<705){
     if(mousePressed)
       currentjun=i;
     }
     }
     }
  }
  
   //绘制郡信息
   if(currentjun > 0){
     String junname=juntable.getString(currentjun,0);
     float junx=juntable.getFloat(currentjun,1);
     float juny=juntable.getFloat(currentjun,2);
     String juninfo=juntable.getString(currentjun,3);

     image(mark2,junx+150,juny+210,15,20);
     
     fill(255,255,255,150);
     rect(junx+15,juny+230,340,150);
     fill(0);
     textSize(20);
     text(junname,junx+30,juny+220);
     textSize(14);
     text(juninfo,junx+30,juny+255,300,400);
   }
  }//绘制地理信息

}

void setcurrentMode(int ID){
  currentMode=ID;
}

void setcurrentMode2(int ID){
  currentMode2=ID;
}

void setcurrentBattle(int ID){
  currentBattle=ID;
}

void setcurrentCharacter(int ID){
  currentCharacter=ID;
}

void setcurrentPlace(int ID){
  currentPlace=ID;
}

void setcurrentjun(int ID){
  currentjun=ID;
}

void setcurrentBattle2(int ID){
  currentBattle2=ID;
}

void setcurrentRel(int ID){
  currentRel=ID;
}

void mousePressed(){
  if(mouseX>1170 && mouseX<1240 && mouseY>20 && mouseY<70){
    currentMode2 = 0;
    
    setcurrentRel(0);
    setcurrentjun(0);
    currentcharactermode=1;
    characterstage=1;
    battlestageid=1;
  }
  
  if(currentMode2 == 3){
    
  if(mouseX >920 && mouseX<1000 && mouseY>120 && mouseY<136)
  currentcharactermode=1;
  else{
  if(mouseX >1060 && mouseX<1140 && mouseY>120 && mouseY<136)
  currentcharactermode=2;
 
  }
  
  if(currentcharactermode == 1){
    
    //人物点击左按钮
    if(mouseX <850 && mouseX>820 && mouseY>540 && mouseY<570){
     if(characterstage > 1)
     characterstage--;
     else
     characterstage=stagecount[currentCharacter-1]-1;
    }
    
    else{
      //点击右按钮
    if(mouseX <1230 && mouseX>1200 && mouseY>540 && mouseY<570){
      if(characterstage < stagecount[currentCharacter-1]-1)
      characterstage++;
      else
      characterstage=1;
    }
    }
  }
  }
  if(currentMode2 == 1){
  if(mouseX <850 && mouseX>820 && mouseY>690 && mouseY<720)
     {
     if(battlestageid>1)
     battlestageid--;
     else
     battlestageid=10;
     }
  if(mouseX < 1230 && mouseX > 1200 && mouseY>690 && mouseY<720)
     {
     if(battlestageid < 10)
     battlestageid++;
     else
     battlestageid=1;
     }
  }
}


void loadimage(int currentCharacter,int currentRel){
    if(currentCharacter>0 && currentRel >0){
    String name1=relationtable[currentCharacter-1].getString(1,0);
    String name2=relationtable[currentCharacter-1].getString(currentRel,0);
    
    relsum=relationtable[currentCharacter-1].getInt(currentRel,2);
       
    portrait=loadImage(name1+".png");
    portrait2=loadImage(name2+".png");    
    }
}

void loadPlace(int currentPlace){
  if(currentPlace > 0){
   juntable=new Table("p"+currentPlace+".csv");
   juncount=juntable.getRowCount();
   zhouimage=loadImage("z"+currentPlace+".png");
  }
}


