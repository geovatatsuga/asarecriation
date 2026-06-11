package com.sunweb.game.rpg.worldZone.command.playerBag
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerPickUpItemRequest extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var itemId:String;
      
      public function PlayerPickUpItemRequest()
      {
         super(CommandCodeBag.PLAYER_PICKUP_ITEM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","itemId:string"];
      }
      
      override public function getDigestKey() : int
      {
         return 62467;
      }
   }
}

