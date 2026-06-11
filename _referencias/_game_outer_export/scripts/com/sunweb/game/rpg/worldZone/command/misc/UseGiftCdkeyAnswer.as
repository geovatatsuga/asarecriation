package com.sunweb.game.rpg.worldZone.command.misc
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class UseGiftCdkeyAnswer extends obf_O_8_1034
   {
      
      public var resultCode:int;
      
      public function UseGiftCdkeyAnswer()
      {
         super(CommandCodeMisc.USE_GIFT_CDKEY_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["resultCode:byte"];
      }
   }
}

