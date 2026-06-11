package com.sunweb.game.rpg.worldZone.command.genie
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerGenieUpgradeAnswer extends obf_O_8_1034
   {
      
      public var genieId:String;
      
      public var genieCode:String;
      
      public var upgradeRate:int;
      
      public var upgraded:Boolean;
      
      public function PlayerGenieUpgradeAnswer()
      {
         super(CommandCodePlayerGenie.PLAYER_GENIE_UPGRADE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["genieId:string","genieCode:string","upgradeRate:short","upgraded:boolean"];
      }
   }
}

