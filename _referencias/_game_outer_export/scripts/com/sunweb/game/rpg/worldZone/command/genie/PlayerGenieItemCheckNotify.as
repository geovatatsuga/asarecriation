package com.sunweb.game.rpg.worldZone.command.genie
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.genie.GenieFullInfo;
   
   public class PlayerGenieItemCheckNotify extends obf_O_8_1034
   {
      
      public var genie:GenieFullInfo;
      
      public function PlayerGenieItemCheckNotify()
      {
         super(CommandCodePlayerGenie.PLAYER_GENIE_ITEM_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["genie:com.sunweb.game.rpg.genie.GenieFullInfo"];
      }
   }
}

