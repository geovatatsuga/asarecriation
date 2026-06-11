package com.sunweb.game.rpg.worldZone.command.player.reward
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RewardShopBuyRequest extends obf_O_8_1034
   {
      
      public var itemCode:String;
      
      public function RewardShopBuyRequest()
      {
         super(CommandCodeReward.REWARD_SHOP_BUY_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["itemCode:string"];
      }
   }
}

