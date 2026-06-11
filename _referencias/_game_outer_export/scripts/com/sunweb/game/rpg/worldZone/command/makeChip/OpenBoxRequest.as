package com.sunweb.game.rpg.worldZone.command.makeChip
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class OpenBoxRequest extends obf_O_8_1034
   {
      
      public var type:int;
      
      public var boxId:String;
      
      public function OpenBoxRequest()
      {
         super(CommandCodeMakeChip.OPEN_BOX_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte","boxId:string"];
      }
   }
}

