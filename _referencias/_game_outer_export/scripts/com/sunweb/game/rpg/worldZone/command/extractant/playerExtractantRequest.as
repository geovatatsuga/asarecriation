package com.sunweb.game.rpg.worldZone.command.extractant
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class playerExtractantRequest extends obf_O_8_1034
   {
      
      public var itemId:String;
      
      public var patternType:int;
      
      public function playerExtractantRequest()
      {
         super(CommandPlayerExtractant.REMARK_SUCCEED_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["itemId:string","patternType:ubyte"];
      }
   }
}

