package com.sunweb.game.rpg.worldZone.command.artifact
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ArtifactEmbedAnswer extends obf_O_8_1034
   {
      
      public var equipmentItemId:String;
      
      public var isSucceeded:Boolean;
      
      public function ArtifactEmbedAnswer()
      {
         super(CommandCodeArtifact.ARTIFACT_EMBED_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentItemId:string","isSucceeded:boolean"];
      }
   }
}

