package com.sunweb.game.rpg.worldZone.command.artifact
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ArtifactLetteringRequest extends obf_O_8_1034
   {
      
      public var equipmentItemId:String;
      
      public var letteringWord:String;
      
      public function ArtifactLetteringRequest()
      {
         super(CommandCodeArtifact.ARTIFACT_LETTERING_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentItemId:string","letteringWord:string"];
      }
   }
}

