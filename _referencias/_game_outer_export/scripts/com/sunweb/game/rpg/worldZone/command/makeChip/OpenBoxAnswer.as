package com.sunweb.game.rpg.worldZone.command.makeChip
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class OpenBoxAnswer extends obf_O_8_1034
   {
      
      public var chipBoxs:Object;
      
      public var chipKeys:Object;
      
      public var chips:Object;
      
      public var chipSupers:Object;
      
      public function OpenBoxAnswer()
      {
         super(CommandCodeMakeChip.OPEN_BOX_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["chipBoxs:map(string,int)","chipKeys:map(string,int)","chips:map(string,int)","chipSupers:map(string,int)"];
      }
   }
}

