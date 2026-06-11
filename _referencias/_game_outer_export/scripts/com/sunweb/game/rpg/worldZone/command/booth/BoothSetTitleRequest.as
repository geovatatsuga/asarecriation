package com.sunweb.game.rpg.worldZone.command.booth
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class BoothSetTitleRequest extends obf_O_8_1034
   {
      
      public var boothTitle:String;
      
      public function BoothSetTitleRequest()
      {
         super(CommandCodePlayerBooth.BOOTH_SET_TITLE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["boothTitle:string"];
      }
   }
}

