package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerReceiveMsgNotify extends obf_O_8_1034
   {
      
      public var fromName:String;
      
      public var fromUserType:int;
      
      public var fromTime:String;
      
      public var scope:int;
      
      public var content:String;
      
      public function PlayerReceiveMsgNotify()
      {
         super(CommandCodePlayer.PLAYER_RECEIVE_MSG_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["fromName:string","fromUserType:ubyte","fromTime:string","scope:byte","content:string"];
      }
   }
}

