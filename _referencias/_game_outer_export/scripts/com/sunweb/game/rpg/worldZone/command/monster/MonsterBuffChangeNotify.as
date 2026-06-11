package com.sunweb.game.rpg.worldZone.command.monster
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MonsterBuffChangeNotify extends obf_O_8_1034
   {
      
      public var monsterId:String;
      
      public var buffsAdded:Array;
      
      public var buffsRemoved:Array;
      
      public function MonsterBuffChangeNotify()
      {
         super(CommandCodeMonster.MONSTER_BUFF_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["monsterId:string","buffsAdded:array(com.sunweb.game.rpg.buff.BuffInfo)","buffsRemoved:array(ushort)"];
      }
   }
}

