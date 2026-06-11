package com.sunweb.game.rpg.worldZone.command.player.bone
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class BoneUpLevelRequest extends obf_O_8_1034
   {
      
      public function BoneUpLevelRequest()
      {
         super(CommandCodeBone.BONE_UP_LEVEL_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

