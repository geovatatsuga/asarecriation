package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerGiveFamilyLeaderRequest extends obf_O_8_1034
   {
      
      public var targetPlayerId:String;
      
      public function PlayerGiveFamilyLeaderRequest()
      {
         super(CommandCodePlayerFamily.PLAYER_GIVE_FAMILY_LEADER_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["targetPlayerId:string"];
      }
   }
}

