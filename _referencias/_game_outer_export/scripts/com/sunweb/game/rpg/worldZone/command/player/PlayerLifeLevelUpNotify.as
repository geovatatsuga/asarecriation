package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerLifeLevelUpNotify extends obf_O_8_1034
   {
      
      public var lifeLevel:int;
      
      public var lifeExp:int;
      
      public function PlayerLifeLevelUpNotify()
      {
         super(CommandCodePlayer.PLAYER_LIFE_LEVEL_UP_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["lifeLevel:byte","lifeExp:int"];
      }
   }
}

