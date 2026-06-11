package com.sunweb.game.rpg.worldZone.command.playerDevil
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerDevilUpgradeAnswer extends obf_O_8_1034
   {
      
      public var devilId:String;
      
      public var devilCode:String;
      
      public var upgradeRate:int;
      
      public var upgraded:Boolean;
      
      public function PlayerDevilUpgradeAnswer()
      {
         super(CommandCodePlayerDevil.PLAYER_DEVIL_UPGRADE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["devilId:string","devilCode:string","upgradeRate:short","upgraded:boolean"];
      }
   }
}

