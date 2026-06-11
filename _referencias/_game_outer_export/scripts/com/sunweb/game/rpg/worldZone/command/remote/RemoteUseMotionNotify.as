package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RemoteUseMotionNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var motionCode:String;
      
      public var targetId:String;
      
      public function RemoteUseMotionNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_USE_MOTION_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","motionCode:string","targetId:string"];
      }
   }
}

