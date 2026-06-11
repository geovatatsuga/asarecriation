package com.sunweb.game.rpg.worldZone.command.genie
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.genie.GenieFullInfo;
   
   public class PlayerUsingGenieCheckNotify extends obf_O_8_1034
   {
      
      public var usingGenie:GenieFullInfo = null;
      
      public function PlayerUsingGenieCheckNotify()
      {
         super(CommandCodePlayerGenie.PLAYER_USING_GENIE_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["usingGenie:com.sunweb.game.rpg.genie.GenieFullInfo"];
      }
   }
}

