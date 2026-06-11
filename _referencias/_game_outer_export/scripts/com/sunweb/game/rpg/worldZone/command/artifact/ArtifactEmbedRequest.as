package com.sunweb.game.rpg.worldZone.command.artifact
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ArtifactEmbedRequest extends obf_O_8_1034
   {
      
      public var equipmentItemId:String;
      
      public var gemItemIndex:int;
      
      public var holeIndex:int;
      
      public function ArtifactEmbedRequest()
      {
         super(CommandCodeArtifact.ARTIFACT_EMBED_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentItemId:string","gemItemIndex:ubyte","holeIndex:byte"];
      }
   }
}

