package com.sunweb.game.rpg.worldZone.command.baby
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerBabyEatRequest extends obf_O_8_1034
   {
      
      public var itemCode:String;
      
      public function PlayerBabyEatRequest()
      {
         super(CommandCodeBaby.PLAYER_BABY_EAT_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["itemCode:string"];
      }
   }
}

