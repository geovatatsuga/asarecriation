package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.playerDevil.DevilBriefInfo;
   
   public class RemoteDevilCheckNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var usingDevil:DevilBriefInfo = null;
      
      public function RemoteDevilCheckNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_DEVIL_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","usingDevil:com.sunweb.game.rpg.playerDevil.DevilBriefInfo"];
      }
   }
}

