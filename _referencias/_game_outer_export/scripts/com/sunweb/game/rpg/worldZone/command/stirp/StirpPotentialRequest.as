package com.sunweb.game.rpg.worldZone.command.stirp
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class StirpPotentialRequest extends obf_O_8_1034
   {
      
      public var isStirpLvUp:Boolean;
      
      public var stirpLevel:int;
      
      public function StirpPotentialRequest()
      {
         super(CommandCodeStirp.PLAYER_STIRP_POTENTIAL_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["isStirpLvUp:boolean","stirpLevel:int"];
      }
   }
}

