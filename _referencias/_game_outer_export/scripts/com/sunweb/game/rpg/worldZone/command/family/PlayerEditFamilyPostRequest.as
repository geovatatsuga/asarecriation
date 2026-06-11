package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerEditFamilyPostRequest extends obf_O_8_1034
   {
      
      public var postNameList:Array;
      
      public function PlayerEditFamilyPostRequest()
      {
         super(CommandCodePlayerFamily.PLAYER_EDIT_FAMILY_POST_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["postNameList:array(string)"];
      }
   }
}

