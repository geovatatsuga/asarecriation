package com.sunweb.game.rpg.worldZone.command.glyph
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class GlyphMasterRequest extends obf_O_8_1034
   {
      
      public var kind:int;
      
      public function GlyphMasterRequest()
      {
         super(CommandCodePlayerGlyph.GLYPH_MASTER_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["kind:ubyte"];
      }
   }
}

