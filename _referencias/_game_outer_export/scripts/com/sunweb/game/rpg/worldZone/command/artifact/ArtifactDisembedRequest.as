package com.sunweb.game.rpg.worldZone.command.artifact
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ArtifactDisembedRequest extends obf_O_8_1034
   {
      
      public var equipmentItemId:String;
      
      public var holeIndex:int;
      
      public function ArtifactDisembedRequest()
      {
         super(CommandCodeArtifact.ARTIFACT_DISEMBED_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentItemId:string","holeIndex:byte"];
      }
   }
}

