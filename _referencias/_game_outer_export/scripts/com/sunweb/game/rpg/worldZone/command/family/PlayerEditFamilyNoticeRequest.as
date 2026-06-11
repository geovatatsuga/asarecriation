package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerEditFamilyNoticeRequest extends obf_O_8_1034
   {
      
      public var notice:String;
      
      public function PlayerEditFamilyNoticeRequest()
      {
         super(CommandCodePlayerFamily.PLAYER_EDIT_FAMILY_NOTICE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["notice:string"];
      }
   }
}

