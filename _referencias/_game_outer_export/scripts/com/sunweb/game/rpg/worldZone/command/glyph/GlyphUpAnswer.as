package com.sunweb.game.rpg.worldZone.command.glyph
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.glyph.GlyphInfo;
   
   public class GlyphUpAnswer extends obf_O_8_1034
   {
      
      public var glyphInfo:GlyphInfo;
      
      public var addValue:int;
      
      public function GlyphUpAnswer()
      {
         super(CommandCodePlayerGlyph.GLYPH_UP_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["glyphInfo:com.sunweb.game.rpg.glyph.GlyphInfo","addValue:ushort"];
      }
   }
}

