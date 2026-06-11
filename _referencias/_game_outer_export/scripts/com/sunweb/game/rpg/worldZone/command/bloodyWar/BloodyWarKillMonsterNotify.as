package com.sunweb.game.rpg.worldZone.command.bloodyWar
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class BloodyWarKillMonsterNotify extends obf_O_8_1034
   {
      
      public var attackTemp:int;
      
      public var defenseTemp:int;
      
      public function BloodyWarKillMonsterNotify()
      {
         super(CommandCodeBloodyWar.BLOODY_WAR_KILL_MONSTER_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["attackTemp:int","defenseTemp:int"];
      }
   }
}

