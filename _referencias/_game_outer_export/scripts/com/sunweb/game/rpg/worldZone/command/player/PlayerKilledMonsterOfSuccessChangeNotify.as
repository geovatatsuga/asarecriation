package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerKilledMonsterOfSuccessChangeNotify extends obf_O_8_1034
   {
      
      public var monsterNumber:Object;
      
      public function PlayerKilledMonsterOfSuccessChangeNotify()
      {
         super(CommandCodePlayer.PLAYER_KILLED_MONSTER_OF_SUCCESS_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["monsterNumber:map(string,int)"];
      }
   }
}

