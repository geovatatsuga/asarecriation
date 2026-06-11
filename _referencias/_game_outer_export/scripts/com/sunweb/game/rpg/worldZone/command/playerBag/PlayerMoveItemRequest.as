package com.sunweb.game.rpg.worldZone.command.playerBag
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerMoveItemRequest extends obf_O_8_1034
   {
      
      public var bagIndex:int;
      
      public var fromItemIndex:int;
      
      public var toItemIndex:int;
      
      public function PlayerMoveItemRequest()
      {
         super(CommandCodeBag.PLAYER_MOVE_ITEM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["bagIndex:byte","fromItemIndex:ubyte","toItemIndex:ubyte"];
      }
      
      override public function getDigestKey() : int
      {
         return 62469;
      }
   }
}

