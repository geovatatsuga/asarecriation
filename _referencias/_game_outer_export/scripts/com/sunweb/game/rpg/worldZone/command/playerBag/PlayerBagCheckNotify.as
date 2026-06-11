package com.sunweb.game.rpg.worldZone.command.playerBag
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerBagCheckNotify extends obf_O_8_1034
   {
      
      public var bagIndex:int;
      
      public var changedItems:Array;
      
      public function PlayerBagCheckNotify()
      {
         super(CommandCodeBag.PLAYER_BAG_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["bagIndex:byte","changedItems:array(com.sunweb.game.rpg.playerBag.BagItemInfo)"];
      }
   }
}

