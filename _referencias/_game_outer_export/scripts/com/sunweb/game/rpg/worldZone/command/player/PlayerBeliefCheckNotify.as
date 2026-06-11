package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerBeliefCheckNotify extends obf_O_8_1034
   {
      
      public var beliefGod:int;
      
      public var beliefLevel:int;
      
      public function PlayerBeliefCheckNotify()
      {
         super(CommandCodePlayer.PLAYER_BELIEF_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["beliefGod:byte","beliefLevel:byte"];
      }
   }
}

