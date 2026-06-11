package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerViewFamilyRequest extends obf_O_8_1034
   {
      
      public var familyName:String;
      
      public function PlayerViewFamilyRequest()
      {
         super(CommandCodePlayerFamily.PLAYER_VIEW_FAMILY_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["familyName:string"];
      }
   }
}

