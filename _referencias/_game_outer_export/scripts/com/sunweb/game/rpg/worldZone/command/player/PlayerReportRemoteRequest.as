package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerReportRemoteRequest extends obf_O_8_1034
   {
      
      public var remotePlayerId:String;
      
      public var reportType:int;
      
      public function PlayerReportRemoteRequest()
      {
         super(CommandCodePlayer.PLAYER_REPORT_REMOTE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["remotePlayerId:string","reportType:byte"];
      }
   }
}

