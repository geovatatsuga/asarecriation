package com.sunweb.game.rpg.glyph
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class GlyphInfo extends obf_2_M_853
   {
      
      public var kind:int;
      
      public var level:int;
      
      public var value:int;
      
      public function GlyphInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["kind:ubyte","level:ubyte","value:ushort"];
      }
   }
}

