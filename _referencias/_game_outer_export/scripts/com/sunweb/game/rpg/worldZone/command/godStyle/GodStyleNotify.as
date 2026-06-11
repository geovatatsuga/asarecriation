package com.sunweb.game.rpg.worldZone.command.godStyle
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class GodStyleNotify extends obf_O_8_1034
   {
      
      public var godStyleId:String;
      
      public var godStyleLevel:int;
      
      public function GodStyleNotify()
      {
         super(CommandCodeGodStyle.GOD_STYLE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["godStyleId:string","godStyleLevel:ubyte"];
      }
   }
}

