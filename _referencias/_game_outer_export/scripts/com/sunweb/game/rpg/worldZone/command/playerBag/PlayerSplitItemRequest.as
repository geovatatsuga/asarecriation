package com.sunweb.game.rpg.worldZone.command.playerBag
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerSplitItemRequest extends obf_O_8_1034
   {
      
      public var bagIndex:int;
      
      public var fromItemIndex:int;
      
      public var toItemIndex:int;
      
      public var splitNumber:int;
      
      public function PlayerSplitItemRequest()
      {
         super(CommandCodeBag.PLAYER_SPLIT_ITEM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["bagIndex:byte","fromItemIndex:ubyte","toItemIndex:ubyte","splitNumber:ubyte"];
      }
      
      override public function getDigestKey() : int
      {
         return 62470;
      }
   }
}

