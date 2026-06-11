package com.sunweb.game.rpg.worldZone.command.glyph
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class GlyphUpRequest extends obf_O_8_1034
   {
      
      public var kind:int;
      
      public var useKindList:Array;
      
      public function GlyphUpRequest()
      {
         super(CommandCodePlayerGlyph.GLYPH_UP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["kind:ubyte","useKindList:array(ubyte)"];
      }
   }
}

