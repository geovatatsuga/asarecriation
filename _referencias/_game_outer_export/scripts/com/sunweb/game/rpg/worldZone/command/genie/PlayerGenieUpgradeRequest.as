package com.sunweb.game.rpg.worldZone.command.genie
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerGenieUpgradeRequest extends obf_O_8_1034
   {
      
      public var genieId:String;
      
      public function PlayerGenieUpgradeRequest()
      {
         super(CommandCodePlayerGenie.PLAYER_GENIE_UPGRADE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["genieId:string"];
      }
   }
}

