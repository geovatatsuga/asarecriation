package com.sunweb.game.rpg.worldZone.command.baby
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerBabyBuyAttrMaxRequest extends obf_O_8_1034
   {
      
      public var type:int;
      
      public function PlayerBabyBuyAttrMaxRequest()
      {
         super(CommandCodeBaby.PLAYER_BABY_BUY_ATTR_MAX_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte"];
      }
   }
}

