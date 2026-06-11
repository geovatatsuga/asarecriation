package com.sunweb.game.rpg.worldZone.command.monster
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MonsterHpChangeNotify extends obf_O_8_1034
   {
      
      public var monsterId:String;
      
      public var hpChanged:Number;
      
      public var hpPercentCurrent:int;
      
      public var skillCode:String;
      
      public var isCriticalStrike:Boolean;
      
      public function MonsterHpChangeNotify()
      {
         super(CommandCodeMonster.MONSTER_HP_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["monsterId:string","hpChanged:double","hpPercentCurrent:byte","skillCode:string","isCriticalStrike:boolean"];
      }
   }
}

