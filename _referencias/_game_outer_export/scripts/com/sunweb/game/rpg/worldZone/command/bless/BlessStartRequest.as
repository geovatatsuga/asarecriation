package com.sunweb.game.rpg.worldZone.command.bless
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class BlessStartRequest extends obf_O_8_1034
   {
      
      public var blessCode:String;
      
      public var blessPrice:int;
      
      public function BlessStartRequest()
      {
         super(CommandCodeBless.BLESS_START_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["blessCode:string","blessPrice:int"];
      }
   }
}

