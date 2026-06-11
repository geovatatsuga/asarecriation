package com.sunweb.game.rpg.farm
{
   import flash.geom.Point;
   
   public class obf_n_v_1693
   {
      
      public var code:String;
      
      public var name:String;
      
      public var res:String;
      
      public var farmType:int;
      
      public var maxLevel:int;
      
      public var levelInfo:Array;
      
      public var rootX:int;
      
      public var rootY:int;
      
      private var _levelAreaArray:Array;
      
      public function obf_n_v_1693(param1:Object)
      {
         super();
         this.code = param1.code;
         this.name = param1.name;
         this.res = param1.res;
         this.farmType = param1.type;
         this.maxLevel = param1.maxLevel;
         this.levelInfo = param1.levelInfo;
         this.rootX = param1.rootX;
         this.rootY = param1.rootY;
         this.obf_0___L_540();
      }
      
      private function obf_0___L_540() : void
      {
         this._levelAreaArray = new Array();
         var _loc1_:int = 1;
         while(_loc1_ <= this.maxLevel)
         {
            this.obf_B_3375(_loc1_);
            _loc1_++;
         }
      }
      
      private function obf_B_3375(param1:int) : void
      {
         var _loc4_:Object = null;
         var _loc5_:Point = null;
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            for each(_loc4_ in this.levelInfo[_loc3_].areaAdded)
            {
               _loc5_ = new Point(_loc4_.x - this.rootX,_loc4_.y - this.rootY);
               _loc2_.push(_loc5_);
            }
            _loc3_++;
         }
         this._levelAreaArray[param1 - 1] = _loc2_;
      }
      
      public function getLevelArea(param1:int) : Array
      {
         if(param1 < 1 || param1 > this.maxLevel)
         {
            return null;
         }
         return this._levelAreaArray[param1 - 1];
      }
      
      public function getTotalArea() : Array
      {
         return this.getLevelArea(this.maxLevel);
      }
   }
}

