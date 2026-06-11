package com.sunweb.game.rpg.worldZone.command.playerBag
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerBagCapacityChangeNotify extends obf_O_8_1034
   {
      
      public var bagIndex:int;
      
      public var capacity:int;
      
      public function PlayerBagCapacityChangeNotify()
      {
         super(CommandCodeBag.PLAYER_BAG_CAPACITY_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["bagIndex:byte","capacity:ubyte"];
      }
   }
}

