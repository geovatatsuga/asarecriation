package com.sunweb.game.rpg.worldZone.command.bless
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class BlessBuyBuffRequest extends obf_O_8_1034
   {
      
      public var blessOwnerId:String;
      
      public var blessCode:String;
      
      public var blessLevel:int;
      
      public var blessPrice:int;
      
      public function BlessBuyBuffRequest()
      {
         super(CommandCodeBless.BLESS_BUY_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["blessOwnerId:string","blessCode:string","blessLevel:byte","blessPrice:int"];
      }
   }
}

