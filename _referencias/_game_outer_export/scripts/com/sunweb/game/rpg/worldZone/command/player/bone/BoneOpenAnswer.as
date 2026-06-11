package com.sunweb.game.rpg.worldZone.command.player.bone
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class BoneOpenAnswer extends obf_O_8_1034
   {
      
      public var boneLevel:int;
      
      public function BoneOpenAnswer()
      {
         super(CommandCodeBone.BONE_OPEN_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["boneLevel:ubyte"];
      }
   }
}

