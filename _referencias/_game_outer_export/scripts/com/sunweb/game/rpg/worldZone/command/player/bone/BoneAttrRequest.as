package com.sunweb.game.rpg.worldZone.command.player.bone
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class BoneAttrRequest extends obf_O_8_1034
   {
      
      public var boneTab:int;
      
      public function BoneAttrRequest()
      {
         super(CommandCodeBone.BONE_ATTR_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["boneTab:ubyte"];
      }
   }
}

