package com.sunweb.game.rpg.worldZone.command.artifact
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ArtifactUpEquExpRequest extends obf_O_8_1034
   {
      
      public var equipmentItemId:String;
      
      public function ArtifactUpEquExpRequest()
      {
         super(CommandCodeArtifact.ARTIFACT_UP_EQU_EXP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentItemId:string"];
      }
   }
}

