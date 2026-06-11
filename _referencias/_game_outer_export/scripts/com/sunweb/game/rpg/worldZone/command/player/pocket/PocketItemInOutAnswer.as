package com.sunweb.game.rpg.worldZone.command.player.pocket
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PocketItemInOutAnswer extends obf_O_8_1034
   {
      
      public var pocketItems:Object;
      
      public function PocketItemInOutAnswer()
      {
         super(CommandPlayerPocket.POCKET_ITEM_IN_OUT_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["pocketItems:map(string,int)"];
      }
   }
}

