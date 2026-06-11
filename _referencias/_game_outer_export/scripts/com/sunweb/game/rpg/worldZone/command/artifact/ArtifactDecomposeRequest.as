package com.sunweb.game.rpg.worldZone.command.artifact
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ArtifactDecomposeRequest extends obf_O_8_1034
   {
      
      public var equipmentItemIds:Array;
      
      public function ArtifactDecomposeRequest()
      {
         super(CommandCodeArtifact.ARTIFACT_DECOMPOSE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentItemIds:array(string)"];
      }
   }
}

