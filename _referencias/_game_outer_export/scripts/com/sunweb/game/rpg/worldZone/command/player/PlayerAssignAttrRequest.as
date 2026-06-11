package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerAssignAttrRequest extends obf_O_8_1034
   {
      
      public var strAdded:int;
      
      public var wisAdded:int;
      
      public var agiAdded:int;
      
      public var vitAdded:int;
      
      public function PlayerAssignAttrRequest()
      {
         super(CommandCodePlayer.PLAYER_ASSIGN_ATTR_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["strAdded:int","wisAdded:int","agiAdded:int","vitAdded:int"];
      }
   }
}

