package com.sunweb.game.rpg.lockTower
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class LockTowerInfo extends obf_2_M_853
   {
      
      public var isOpen:Boolean = false;
      
      public var floor:int = 0;
      
      public var monsterCode:String = null;
      
      public var level:int = 0;
      
      public var exp:int = 0;
      
      public var canBuff:Boolean = true;
      
      public function LockTowerInfo()
      {
         super();
      }
      
      public function getLevelConfig() : Object
      {
         if(this.level <= 0)
         {
            return null;
         }
         var _loc1_:Array = obf_N_9_4230.levelList();
         if(!_loc1_ || this.level > _loc1_.length)
         {
            return null;
         }
         return _loc1_[this.level - 1];
      }
      
      public function isMaxLevel() : Boolean
      {
         if(this.level <= 0)
         {
            return false;
         }
         var _loc1_:Array = obf_N_9_4230.levelList();
         if(!_loc1_)
         {
            return false;
         }
         if(this.level >= _loc1_.length)
         {
            return true;
         }
         return false;
      }
      
      override public function getFieldList() : Array
      {
         return ["isOpen:boolean","floor:ubyte","monsterCode:string","level:ubyte","exp:int","canBuff:boolean"];
      }
   }
}

