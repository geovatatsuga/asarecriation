package com.sunweb.game.rpg.worldZone.command.stirp
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class StirpLvUpRequest extends obf_O_8_1034
   {
      
      public var isStirpLvUp:Boolean;
      
      public function StirpLvUpRequest()
      {
         super(CommandCodeStirp.PLAYER_STIRP_LVUP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["isStirpLvUp:boolean"];
      }
   }
}

