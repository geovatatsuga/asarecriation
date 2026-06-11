package com.sunweb.game.rpg.worldZone.command.bless
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.bless.BlessSellInfo;
   
   public class BlessCheckNotify extends obf_O_8_1034
   {
      
      public var isBless:Boolean;
      
      public var blessIngInfo:BlessSellInfo;
      
      public function BlessCheckNotify()
      {
         super(CommandCodeBless.BLESS_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["isBless:boolean","blessIngInfo:com.sunweb.game.rpg.bless.BlessSellInfo"];
      }
   }
}

