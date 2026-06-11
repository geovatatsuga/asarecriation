package com.sunweb.game.rpg.worldZone.command.playerBag
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerItemUsedNotify extends obf_O_8_1034
   {
      
      public var itemCode:String;
      
      public function PlayerItemUsedNotify()
      {
         super(CommandCodeBag.PLAYER_ITEM_USED_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["itemCode:string"];
      }
   }
}

