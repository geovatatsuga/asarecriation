package com.sunweb.game.rpg.glyph
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class GlyphMasterInfo extends obf_2_M_853
   {
      
      public var kind:int;
      
      public var level:int;
      
      public var untappedNum:int;
      
      public var alreadyNum:int;
      
      public function GlyphMasterInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["kind:ubyte","level:ubyte","untappedNum:ushort","alreadyNum:int"];
      }
   }
}

