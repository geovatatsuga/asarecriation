package com.sunweb.game.rpg.map.pathfind.astar
{
   import com.sunweb.game.rpg.map.pathfind.astar.astarInterface.obf_G_L_1125;
   
   public class obf_E_U_3120 implements obf_G_L_1125
   {
      
      public var x:int;
      
      public var y:int;
      
      public var f:Number;
      
      public var g:Number;
      
      public var h:Number;
      
      public var expense:Number;
      
      public var nodeMutipler:Number;
      
      public var walkAble:Boolean;
      
      public var parent:obf_E_U_3120;
      
      public var obf_y_R_2352:Boolean = false;
      
      public var version:int;
      
      public function obf_E_U_3120()
      {
         super();
         this.walkAble = true;
      }
      
      public function reset() : void
      {
         this.f = 0;
         this.g = 0;
         this.h = 0;
         this.expense = 0;
         this.nodeMutipler = 0;
         this.x = 0;
         this.y = 0;
         this.walkAble = true;
         this.obf_y_R_2352 = false;
      }
   }
}

