package com.sunweb.game.rpg.worldZone.command.glyph
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class GlyphUpMasterNotify extends obf_O_8_1034
   {
      
      public var masterInfoList:Array;
      
      public var masterKinds:Array;
      
      public function GlyphUpMasterNotify()
      {
         super(CommandCodePlayerGlyph.GLYPH_UP_MASTER_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["masterInfoList:array(com.sunweb.game.rpg.glyph.GlyphMasterInfo)","masterKinds:array(ubyte)"];
      }
   }
}

