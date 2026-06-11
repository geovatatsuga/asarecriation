package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFamilyNoticeCheckNotify extends obf_O_8_1034
   {
      
      public var notice:String;
      
      public function PlayerFamilyNoticeCheckNotify()
      {
         super(CommandCodePlayerFamily.PLAYER_FAMILY_NOTICE_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["notice:string"];
      }
   }
}

