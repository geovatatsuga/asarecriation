package com.sunweb.game.rpg.worldZone.command.cloak
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerCloakGlyphNotify extends obf_O_8_1034
   {
      
      public var glyphInfo:Object;
      
      public function PlayerCloakGlyphNotify()
      {
         super(CommandCodePlayerCloak.PLAYER_CLOAK_GLYPH_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["glyphInfo:map(string,ubyte)"];
      }
   }
}

