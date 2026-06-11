package com.sunweb.game.rpg.worldZone.command.reGrow
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerReGrowAnswer extends obf_O_8_1034
   {
      
      public var reGrowLevel:int;
      
      public function PlayerReGrowAnswer()
      {
         super(CommandCodePlayerReGrow.PLAYER_RE_GROW_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["reGrowLevel:int"];
      }
   }
}

