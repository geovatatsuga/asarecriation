package com.sunweb.game.rpg.worldZone.command.player.pocket
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PocketAddStoneRequest extends obf_O_8_1034
   {
      
      public var type:int;
      
      public var pocketIndex:int;
      
      public var itemCode:String;
      
      public function PocketAddStoneRequest()
      {
         super(CommandPlayerPocket.POCKET_ADD_STONE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte","pocketIndex:ubyte","itemCode:string"];
      }
   }
}

