package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFamilyBossFeedRequest extends obf_O_8_1034
   {
      
      public var itemCode:String;
      
      public function PlayerFamilyBossFeedRequest()
      {
         super(CommandCodePlayerFamily.PLAYER_FAMILY_BOSS_FEED_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["itemCode:string"];
      }
   }
}

