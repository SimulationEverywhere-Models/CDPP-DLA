[top]
components : dla

[dla]
type : cell
dim : (71,71)
delay : transport
defaultDelayTime  : 100
border : wrapped 

neighbors : dla(-3,0)
neighbors : dla(-2,-1) dla(-2,0) dla(-2,1)
neighbors : dla(-1,-2) dla(-1,-1) dla(-1,0) dla(-1,1) dla(-1,2)
neighbors : dla(0,-3) dla(0,-2) dla(0,-1) dla(0,0)   dla(0,1) dla(0,2) dla(0,3) 
neighbors : dla(1,-2) dla(1,-1) dla(1,0) dla(1,1) dla(1,2) 
neighbors : dla(2,-1) dla(2,0) dla(2,1)  
neighbors : dla(3,0)

initialvalue : -1
initialCellsValue : dla_big2.val
localtransition : dla-rule

[dla-rule]

% intilaize to be empty cell or dies if a particle moves out of range
rule : 0 100 {  (  (cellpos(0) - 35) * (cellpos(0) - 35) + (cellpos(1) - 35 ) * (cellpos(1) - 35) ) > 1150 }

% initialize the cells with mobile particles in the range with 30% of concentration
rule : {round(uniform(1,4))} 100 { (0,0) = -1 and random < 0.30 }  

% initialize to be empty cell
rule : 0 100 { (0,0) = -1 }

% the particle becomes fixed if an adjacent cell contains fixed paticle
rule : 5 100 { (0,0) > 0 and (0,0)<5 and 
               ( (-1, 0) = 5 or (0, -1) = 5 or (0, 1) = 5 or  (1, 0) = 5 ) } 

% if the cell is empty and there is a mobile particle moving in
rule :  {round(uniform(1,4))} 100 { (0,0) = 0 and 
              (  (    (0,-1)=2 and  (-1, -1) !=5 and (1,-1) !=5 and (0,-2) !=5 ) or
                 (    (-1,0)=3 and (-1,-1) !=5 and (-2,0) !=5 and (-1,1) !=5 )     or
                 (    (0,1)=4 and (1,1) !=5 and (0,2) !=5 and (1,1) !=5 )  or
                 (    (1,0)=1 and (1,1) !=5 and (2,0) !=5 and (1,-1) !=5 ) 
              ) }

 
% if no mobile particles around, empty cell remains empty
rule : 0 100 {(0,0)=0 and t}

% %%%%%%%%
% for the cell containning the mobile particles
% %%%%%%%%

% direction = 1 (up)
% stay and change direction when nowhere to move
rule : {round(uniform(1,4))} 100 { (0,0)=1 and (-1,0)!=0 }   
rule : {round(uniform(1,4))} 100 { (0,0)=1 and (-1,0)=0 and 
                (
                   (   (-2,0)=3 and (-2,-1) != 5 and (-3,0) !=5 and (-2,1) !=5  ) or
                   (   (-1,-1)=2 and (-1,-2) !=5 and (-2,-1)!=5 and (0,-1)!=5 ) or
                   (    (-1,1)=4 and (-2,1) !=5 and (-1,2) !=5 and (0,1) !=5 )
                )   		}




% move otherwise
rule : 0 100 {(0,0)=1 and (-1,0)=0 and t}


% direction = 2 (right)
% stay and change direction when nowhere to move
rule : {round(uniform(1,4))} 100 { (0,0)=2 and (0,1)!=0 }
rule : {round(uniform(1,4))} 100 { (0,0)=2 and (0,1)=0 and
(
				(  (0,2)=4 and (-1,2) !=5 and (0,3) !=5 and (1,2) !=5  ) or
				(  (-1,1)=3 and (-1,0) !=5 and (-2,1)!=5 and (-1,2) !=5 ) 
)
					        	}
%
% move otherwise
rule : 0 100 {(0,0)=2 and (0,1)=0 and t}

% direction = 3 (down)
% stay and change direction when nowhere to move
rule : {round(uniform(1,4))} 100 { (0,0)=3 and (1,0)!=0 }
rule : {round(uniform(1,4))} 100 { (0,0)=3 and (1,0)=0 and
( (1,1)=4 and (0,1) !=5 and (1,2) !=5 and (2,1) !=5 ) }				


% move otherwise
rule : 0 100 { (0,0)=3 and (1,0)=0 and t}

% direction = 4 (left)
% stay and change direction when nowhere to move
rule : {round(uniform(1,4))} 100 { (0,0)=4 and (0,-1)!=0 }

% move otherwise
rule : 0 100 { (0,0)=4 and (0,-1)=0 and t}

% fixed particles remains to be fixed
rule : 5 100 { (0,0)=5 }

% any others
rule : { (0, 0) } 100 { t}


