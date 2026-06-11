package com.sunweb.game.rpg.worldZone.command.misc
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class UseGiftCdkeyRequest extends obf_O_8_1034
   {
      
      public var cdkey:String;
      
      public function UseGiftCdkeyRequest()
      {
         super(CommandCodeMisc.USE_GIFT_CDKEY_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["cdkey:string"];
      }
   }
}

