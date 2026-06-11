package com.sunweb.game.rpg.worldZone.command.glyph
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class GlyphMasterAnswer extends obf_O_8_1034
   {
      
      public var kind:int;
      
      public var untappedNum:int;
      
      public function GlyphMasterAnswer()
      {
         super(CommandCodePlayerGlyph.GLYPH_MASTER_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["kind:ubyte","untappedNum:ushort"];
      }
   }
}

