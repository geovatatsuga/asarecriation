package com.sunweb.game.rpg.worldZone.command.artifact
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ArtifactWashAnswer extends obf_O_8_1034
   {
      
      public var equipmentItemId:String;
      
      public var addWashPoint:Number;
      
      public function ArtifactWashAnswer()
      {
         super(CommandCodeArtifact.ARTIFACT_WASH_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentItemId:string","addWashPoint:float"];
      }
   }
}

