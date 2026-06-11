package com.sunweb.game.rpg.worldZone.command.player.bone
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class BoneMeltRequest extends obf_O_8_1034
   {
      
      public var equipmentItemIds:Object;
      
      public function BoneMeltRequest()
      {
         super(CommandCodeBone.BONE_MELT_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentItemIds:map(string,string)"];
      }
   }
}

