package com.sunweb.game.rpg.worldZone.command.player.pocket
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PocketInfoNotify extends obf_O_8_1034
   {
      
      public var stones:Object;
      
      public var pocketItems:Object;
      
      public function PocketInfoNotify()
      {
         super(CommandPlayerPocket.POCKET_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["stones:map(ubyte,string)","pocketItems:map(string,int)"];
      }
   }
}

