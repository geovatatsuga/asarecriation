package com.sunweb.game.rpg.worldZone.command.player.bone
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class BoneOpenRequest extends obf_O_8_1034
   {
      
      public function BoneOpenRequest()
      {
         super(CommandCodeBone.BONE_OPEN_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

