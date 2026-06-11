package com.sunweb.game.rpg.worldZone.command.player.bone
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class BoneRefineRequest extends obf_O_8_1034
   {
      
      public function BoneRefineRequest()
      {
         super(CommandCodeBone.BONE_REFINE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

