package com.sunweb.game.rpg.worldZone.command.equ
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerSwitchFashionNotify extends obf_O_8_1034
   {
      
      public var isUseFashion:Boolean;
      
      public function PlayerSwitchFashionNotify()
      {
         super(CommandCodePlayerEquip.PLAYER_SWITCH_FASHION_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["isUseFashion:boolean"];
      }
   }
}

