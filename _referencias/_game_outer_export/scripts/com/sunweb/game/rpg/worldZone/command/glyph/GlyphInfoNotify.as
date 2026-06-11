package com.sunweb.game.rpg.worldZone.command.glyph
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class GlyphInfoNotify extends obf_O_8_1034
   {
      
      public var glyphInfoList:Array;
      
      public var glyphMasterInfoList:Array;
      
      public function GlyphInfoNotify()
      {
         super(CommandCodePlayerGlyph.GLYPH_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["glyphInfoList:array(com.sunweb.game.rpg.glyph.GlyphInfo)","glyphMasterInfoList:array(com.sunweb.game.rpg.glyph.GlyphMasterInfo)"];
      }
   }
}

