package com.sunweb.game.rpg.worldZone.command.godStyle
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class GodStyleUpRequest extends obf_O_8_1034
   {
      
      public var godStyleId:String;
      
      public function GodStyleUpRequest()
      {
         super(CommandCodeGodStyle.GOD_STYLE_UP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["godStyleId:string"];
      }
   }
}

