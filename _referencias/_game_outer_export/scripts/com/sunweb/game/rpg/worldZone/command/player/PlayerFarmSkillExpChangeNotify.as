package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFarmSkillExpChangeNotify extends obf_O_8_1034
   {
      
      public var kind:int;
      
      public var expChanged:int;
      
      public var expCurrent:int;
      
      public function PlayerFarmSkillExpChangeNotify()
      {
         super(CommandCodePlayer.PLAYER_FARM_SKILL_EXP_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["kind:ubyte","expChanged:int","expCurrent:int"];
      }
   }
}

