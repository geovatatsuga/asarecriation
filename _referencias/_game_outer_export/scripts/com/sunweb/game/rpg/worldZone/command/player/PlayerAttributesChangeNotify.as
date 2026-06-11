package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.role.RoleAttributesInfo;
   
   public class PlayerAttributesChangeNotify extends obf_O_8_1034
   {
      
      public var attributes:RoleAttributesInfo;
      
      public function PlayerAttributesChangeNotify()
      {
         super(CommandCodePlayer.PLAYER_ATTRIBUTES_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["attributes:com.sunweb.game.rpg.role.RoleAttributesInfo"];
      }
   }
}

