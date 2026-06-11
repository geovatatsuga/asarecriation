package com.sunweb.game.rpg.worldZone.command.player.pocket
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PocketItemInOutRequest extends obf_O_8_1034
   {
      
      public var type:int;
      
      public var itemCode:String;
      
      public var itemNum:int;
      
      public function PocketItemInOutRequest()
      {
         super(CommandPlayerPocket.POCKET_ITEM_IN_OUT_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte","itemCode:string","itemNum:ubyte"];
      }
   }
}

