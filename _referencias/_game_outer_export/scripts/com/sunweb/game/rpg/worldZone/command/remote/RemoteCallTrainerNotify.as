package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.animal.AnimalInfo;
   
   public class RemoteCallTrainerNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var animal:AnimalInfo;
      
      public function RemoteCallTrainerNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_CALL_TRAINER_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","animal:com.sunweb.game.rpg.animal.AnimalInfo"];
      }
   }
}

