package com.sunweb.game.rpg.worldZone.command.bless
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.bless.BlessSellInfo;
   
   public class BlessVisitAnswer extends obf_O_8_1034
   {
      
      public var blessOwnerId:String;
      
      public var isBless:Boolean;
      
      public var blessIngInfo:BlessSellInfo;
      
      public function BlessVisitAnswer()
      {
         super(CommandCodeBless.BLESS_VISIT_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["blessOwnerId:string","isBless:boolean","blessIngInfo:com.sunweb.game.rpg.bless.BlessSellInfo"];
      }
   }
}

