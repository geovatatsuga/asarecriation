package com.sunweb.game.rpg.worldZone.command.player.bone
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class BoneRefineAnswer extends obf_O_8_1034
   {
      
      public var isSucceeded:Boolean;
      
      public var refineLevel:int;
      
      public var assembleRuleIndex:int;
      
      public function BoneRefineAnswer()
      {
         super(CommandCodeBone.BONE_REFINE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["assembleRuleIndex:short","isSucceeded:boolean","refineLevel:byte"];
      }
   }
}

