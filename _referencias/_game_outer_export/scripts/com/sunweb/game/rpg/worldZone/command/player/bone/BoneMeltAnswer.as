package com.sunweb.game.rpg.worldZone.command.player.bone
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class BoneMeltAnswer extends obf_O_8_1034
   {
      
      public var isMeltSucceed:Boolean;
      
      public function BoneMeltAnswer()
      {
         super(CommandCodeBone.BONE_MELT_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["isMeltSucceed:boolean"];
      }
   }
}

