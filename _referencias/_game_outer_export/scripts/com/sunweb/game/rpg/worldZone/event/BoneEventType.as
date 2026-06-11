package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.player.bone.CommandCodeBone;
   
   public class BoneEventType
   {
      
      public static const BONE_MELT_ANSWER:String = CommandCodeBone.BONE_MELT_ANSWER.toString(16);
      
      public static const BONE_REFINE_ANSWER:String = CommandCodeBone.BONE_REFINE_ANSWER.toString(16);
      
      public static const BONE_UP_LEVEL_ANSWER:String = CommandCodeBone.BONE_UP_LEVEL_ANSWER.toString(16);
      
      public static const BONE_ATTR_ANSWER:String = CommandCodeBone.BONE_ATTR_ANSWER.toString(16);
      
      public static const BONE_OPEN_ANSWER:String = CommandCodeBone.BONE_OPEN_ANSWER.toString(16);
      
      public function BoneEventType()
      {
         super();
      }
   }
}

