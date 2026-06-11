package com.sunweb.game.rpg.worldZone.command.reGrow
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerReGrowRequest extends obf_O_8_1034
   {
      
      public function PlayerReGrowRequest()
      {
         super(CommandCodePlayerReGrow.PLAYER_RE_GROW_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

