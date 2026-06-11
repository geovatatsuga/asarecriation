package com.sunweb.game.rpg.worldZone.command.extractant
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class playerExtractantUplvRequest extends obf_O_8_1034
   {
      
      public var type:int;
      
      public function playerExtractantUplvRequest()
      {
         super(CommandPlayerExtractant.REMARK_REWARD_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte"];
      }
   }
}

