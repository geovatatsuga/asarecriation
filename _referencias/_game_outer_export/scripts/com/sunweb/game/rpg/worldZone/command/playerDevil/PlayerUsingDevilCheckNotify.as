package com.sunweb.game.rpg.worldZone.command.playerDevil
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.playerDevil.DevilFullInfo;
   
   public class PlayerUsingDevilCheckNotify extends obf_O_8_1034
   {
      
      public var usingDevil:DevilFullInfo = null;
      
      public function PlayerUsingDevilCheckNotify()
      {
         super(CommandCodePlayerDevil.PLAYER_USING_DEVIL_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["usingDevil:com.sunweb.game.rpg.playerDevil.DevilFullInfo"];
      }
   }
}

