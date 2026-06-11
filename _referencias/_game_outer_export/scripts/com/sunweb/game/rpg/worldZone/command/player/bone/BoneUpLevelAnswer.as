package com.sunweb.game.rpg.worldZone.command.player.bone
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class BoneUpLevelAnswer extends obf_O_8_1034
   {
      
      public var lightLevel:int;
      
      public var boneLevel:int;
      
      public function BoneUpLevelAnswer()
      {
         super(CommandCodeBone.BONE_UP_LEVEL_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["lightLevel:byte","boneLevel:byte"];
      }
   }
}

