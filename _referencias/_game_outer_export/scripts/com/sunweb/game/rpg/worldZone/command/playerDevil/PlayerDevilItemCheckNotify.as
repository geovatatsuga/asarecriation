package com.sunweb.game.rpg.worldZone.command.playerDevil
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.playerDevil.DevilFullInfo;
   
   public class PlayerDevilItemCheckNotify extends obf_O_8_1034
   {
      
      public var devil:DevilFullInfo;
      
      public function PlayerDevilItemCheckNotify()
      {
         super(CommandCodePlayerDevil.PLAYER_DEVIL_ITEM_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["devil:com.sunweb.game.rpg.playerDevil.DevilFullInfo"];
      }
   }
}

