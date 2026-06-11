package com.sunweb.game.rpg.worldZone.command.playerBag
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerViewBagRequest extends obf_O_8_1034
   {
      
      public var bagIndex:int;
      
      public function PlayerViewBagRequest()
      {
         super(CommandCodeBag.PLAYER_VIEW_BAG_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["bagIndex:byte"];
      }
      
      override public function getDigestKey() : int
      {
         return 62473;
      }
   }
}

