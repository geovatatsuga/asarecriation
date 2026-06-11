package com.sunweb.game.rpg.worldZone.command.cloak
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerCloakGlyphOpenUpRequest extends obf_O_8_1034
   {
      
      public var glyphId:String;
      
      public function PlayerCloakGlyphOpenUpRequest()
      {
         super(CommandCodePlayerCloak.PLAYER_CLOAK_GLYPH_OPEN_UP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["glyphId:string"];
      }
   }
}

