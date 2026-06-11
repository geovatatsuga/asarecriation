package com.sunweb.game.rpg.worldZone.command.artifact
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ArtifactLetteringAnswer extends obf_O_8_1034
   {
      
      public var equipmentItemId:String;
      
      public function ArtifactLetteringAnswer()
      {
         super(CommandCodeArtifact.ARTIFACT_LETTERING_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentItemId:string"];
      }
   }
}

