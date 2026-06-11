package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerUseMotionRequest extends obf_O_8_1034
   {
      
      public var motionCode:String;
      
      public var targetId:String;
      
      public function PlayerUseMotionRequest()
      {
         super(CommandCodePlayer.PLAYER_USE_MOTION_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["motionCode:string","targetId:string"];
      }
   }
}

