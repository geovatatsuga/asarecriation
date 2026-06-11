package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerSendMsgRequest extends obf_O_8_1034
   {
      
      public var scope:int;
      
      public var content:String;
      
      public var toRoleName:String;
      
      public function PlayerSendMsgRequest()
      {
         super(CommandCodePlayer.PLAYER_SEND_MSG_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["scope:byte","content:string","toRoleName:string"];
      }
      
      override public function getDigestKey() : int
      {
         return 62113;
      }
   }
}

