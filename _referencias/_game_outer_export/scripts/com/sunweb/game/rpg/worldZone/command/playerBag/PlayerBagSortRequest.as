package com.sunweb.game.rpg.worldZone.command.playerBag
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerBagSortRequest extends obf_O_8_1034
   {
      
      public var bagIndex:int;
      
      public function PlayerBagSortRequest()
      {
         super(CommandCodeBag.PLAYER_BAG_SORT_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["bagIndex:byte"];
      }
      
      override public function getDigestKey() : int
      {
         return 65025;
      }
   }
}

