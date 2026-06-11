package com.sunweb.game.rpg.worldZone.command.playerBag
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerMoveItemCrossBagRequest extends obf_O_8_1034
   {
      
      public var npcId:String;
      
      public var funcMenuFullIndex:Array;
      
      public var fromBagIndex:int;
      
      public var fromItemIndex:int;
      
      public var toBagIndex:int;
      
      public var toItemIndex:int;
      
      public function PlayerMoveItemCrossBagRequest()
      {
         super(CommandCodeBag.PLAYER_MOVE_ITEM_CROSS_BAG_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["npcId:string","funcMenuFullIndex:array(byte)","fromBagIndex:byte","fromItemIndex:ubyte","toBagIndex:byte","toItemIndex:ubyte"];
      }
      
      override public function getDigestKey() : int
      {
         return 62472;
      }
   }
}

