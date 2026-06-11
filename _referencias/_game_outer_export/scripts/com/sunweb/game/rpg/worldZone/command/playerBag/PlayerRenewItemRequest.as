package com.sunweb.game.rpg.worldZone.command.playerBag
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerRenewItemRequest extends obf_O_8_1034
   {
      
      public var itemId:String;
      
      public var renewRuleIndex:int;
      
      public function PlayerRenewItemRequest()
      {
         super(CommandCodeBag.PLAYER_RENEW_ITEM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["itemId:string","renewRuleIndex:byte"];
      }
   }
}

