package com.sunweb.game.rpg.worldZone.command.playerBag
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   
   public class PlayerViewItemAnswer extends obf_O_8_1034
   {
      
      public var itemId:String;
      
      public var item:GameItemFullInfo;
      
      public function PlayerViewItemAnswer()
      {
         super(CommandCodeBag.PLAYER_VIEW_ITEM_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["itemId:string","item:com.sunweb.game.rpg.gameItem.GameItemFullInfo"];
      }
   }
}

