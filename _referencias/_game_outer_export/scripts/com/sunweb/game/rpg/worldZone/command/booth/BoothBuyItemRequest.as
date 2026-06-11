package com.sunweb.game.rpg.worldZone.command.booth
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.booth.BoothItemBuyInfo;
   
   public class BoothBuyItemRequest extends obf_O_8_1034
   {
      
      public var boothOwnerId:String;
      
      public var buyItemInfo:BoothItemBuyInfo;
      
      public function BoothBuyItemRequest()
      {
         super(CommandCodePlayerBooth.BOOTH_BUY_ITEM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["boothOwnerId:string","buyItemInfo:com.sunweb.game.rpg.booth.BoothItemBuyInfo"];
      }
      
      override public function getDigestKey() : int
      {
         return 64391;
      }
   }
}

