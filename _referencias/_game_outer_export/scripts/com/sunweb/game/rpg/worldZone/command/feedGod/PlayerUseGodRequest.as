package com.sunweb.game.rpg.worldZone.command.feedGod
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerUseGodRequest extends obf_O_8_1034
   {
      
      public var useGodName:String;
      
      public function PlayerUseGodRequest()
      {
         super(CommandCodePlayerFeedGod.PLAYER_USE_GOD_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["useGodName:string"];
      }
   }
}

