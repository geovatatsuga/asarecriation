package com.sunweb.game.rpg.worldZone.command.country
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerCreaturesNotify extends obf_O_8_1034
   {
      
      public var creatures:Number;
      
      public function PlayerCreaturesNotify()
      {
         super(CommandCodePlayerCountry.PLAYER_CREATURES_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["creatures:uint"];
      }
   }
}

