package com.sunweb.game.rpg.worldZone.command.stirp
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class StirpPotentialValueNotify extends obf_O_8_1034
   {
      
      public var potentialValue:int;
      
      public function StirpPotentialValueNotify()
      {
         super(CommandCodeStirp.PLAYER_STIRP_POTENTIAL_VALUE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["potentialValue:int"];
      }
   }
}

