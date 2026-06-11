package com.sunweb.game.rpg.worldZone.command.lottery
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class GambleStartRequest extends obf_O_8_1034
   {
      
      public var ruleId:String;
      
      public var stakeLevel:int;
      
      public var keepLast:Boolean;
      
      public function GambleStartRequest()
      {
         super(CommandCodeLottery.GAMBLE_START_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["ruleId:string","stakeLevel:byte","keepLast:boolean"];
      }
   }
}

