package com.sunweb.game.rpg.worldZone.command.feedGod
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerRefineGodRequest extends obf_O_8_1034
   {
      
      public var equipmentId:String;
      
      public var godName1:String;
      
      public var godName2:String;
      
      public function PlayerRefineGodRequest()
      {
         super(CommandCodePlayerFeedGod.PLAYER_REFINE_GOD_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentId:string","godName1:string","godName2:string"];
      }
   }
}

