package com.sunweb.game.rpg.worldZone.command.playerDevil
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerDevilUpgradeRequest extends obf_O_8_1034
   {
      
      public var devilId:String;
      
      public function PlayerDevilUpgradeRequest()
      {
         super(CommandCodePlayerDevil.PLAYER_DEVIL_UPGRADE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["devilId:string"];
      }
   }
}

