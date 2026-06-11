package com.sunweb.game.rpg.worldZone.command.player.pocket
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PocketAddStoneAnswer extends obf_O_8_1034
   {
      
      public var stones:Object;
      
      public function PocketAddStoneAnswer()
      {
         super(CommandPlayerPocket.POCKET_ADD_STONE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["stones:map(ubyte,string)"];
      }
   }
}

