package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.pet.PetBriefInfo;
   
   public class RemotePetCheckNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var pet:PetBriefInfo;
      
      public function RemotePetCheckNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_PET_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","pet:com.sunweb.game.rpg.pet.PetBriefInfo"];
      }
   }
}

