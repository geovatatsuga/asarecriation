package com.sunweb.game.rpg.worldZone.command.bless
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class BlessVisitRequest extends obf_O_8_1034
   {
      
      public var blessOwnerId:String;
      
      public function BlessVisitRequest()
      {
         super(CommandCodeBless.BLESS_VISIT_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["blessOwnerId:string"];
      }
   }
}

