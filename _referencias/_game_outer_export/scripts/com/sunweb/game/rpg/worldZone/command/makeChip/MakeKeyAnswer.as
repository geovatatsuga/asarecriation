package com.sunweb.game.rpg.worldZone.command.makeChip
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MakeKeyAnswer extends obf_O_8_1034
   {
      
      public var chipBadKeys:Object;
      
      public var chipKeys:Object;
      
      public function MakeKeyAnswer()
      {
         super(CommandCodeMakeChip.MAKE_KEY_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["chipBadKeys:map(string,int)","chipKeys:map(string,int)"];
      }
   }
}

