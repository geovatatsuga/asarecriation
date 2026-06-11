package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerLifeJobChangeNotify extends obf_O_8_1034
   {
      
      public var lifeJob:int;
      
      public var lifeLevel:int;
      
      public var lifeExp:int;
      
      public function PlayerLifeJobChangeNotify()
      {
         super(CommandCodePlayer.PLAYER_LIFE_JOB_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["lifeJob:byte","lifeLevel:byte","lifeExp:int"];
      }
   }
}

