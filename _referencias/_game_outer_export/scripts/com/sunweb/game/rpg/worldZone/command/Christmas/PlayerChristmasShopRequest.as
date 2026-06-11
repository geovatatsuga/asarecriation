package com.sunweb.game.rpg.worldZone.command.Christmas
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerChristmasShopRequest extends obf_O_8_1034
   {
      
      public var itemCode:String;
      
      public function PlayerChristmasShopRequest()
      {
         super(CommandCodePlayerGame.PLAYER_CHRISTMAS_SHOP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["itemCode:string"];
      }
   }
}

