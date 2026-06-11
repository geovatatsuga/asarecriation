package com.sunweb.game.rpg.worldZone.command.playerBag
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerViewItemRequest extends obf_O_8_1034
   {
      
      public var itemId:String;
      
      public function PlayerViewItemRequest()
      {
         super(CommandCodeBag.PLAYER_VIEW_ITEM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["itemId:string"];
      }
   }
}

