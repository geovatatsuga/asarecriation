package com.sunweb.game.rpg.worldZone.command.makeChip
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MakeKeyRequest extends obf_O_8_1034
   {
      
      public var type:int;
      
      public var keyId:String;
      
      public function MakeKeyRequest()
      {
         super(CommandCodeMakeChip.MAKE_KEY_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte","keyId:string"];
      }
   }
}

