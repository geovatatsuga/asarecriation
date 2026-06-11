package com.sunweb.game.rpg.worldZone.command.booth
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class BoothVisitRequest extends obf_O_8_1034
   {
      
      public var boothOwnerId:String;
      
      public function BoothVisitRequest()
      {
         super(CommandCodePlayerBooth.BOOTH_VISIT_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["boothOwnerId:string"];
      }
   }
}

