package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerEquipSkillNotify extends obf_O_8_1034
   {
      
      public var skillMap:Object;
      
      public function PlayerEquipSkillNotify()
      {
         super(CommandCodePlayer.obf_h_i_3566);
      }
      
      override public function getFieldList() : Array
      {
         return ["skillMap:map(string,ubyte)"];
      }
   }
}

