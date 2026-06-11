package com.sunweb.game.rpg.worldZone.command.playerBag
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerItemAddedNotify extends obf_O_8_1034
   {
      
      public var itemsAdded:Array;
      
      public function PlayerItemAddedNotify()
      {
         super(CommandCodeBag.PLAYER_ITEM_ADDED_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["itemsAdded:array(com.sunweb.game.rpg.gameItem.GameItemBriefInfo)"];
      }
   }
}

