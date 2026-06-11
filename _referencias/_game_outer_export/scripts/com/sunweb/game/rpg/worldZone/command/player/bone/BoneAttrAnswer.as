package com.sunweb.game.rpg.worldZone.command.player.bone
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.role.RoleAttributesInfo;
   
   public class BoneAttrAnswer extends obf_O_8_1034
   {
      
      public var attr:RoleAttributesInfo;
      
      public function BoneAttrAnswer()
      {
         super(CommandCodeBone.BONE_ATTR_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["attr:com.sunweb.game.rpg.role.RoleAttributesInfo"];
      }
   }
}

