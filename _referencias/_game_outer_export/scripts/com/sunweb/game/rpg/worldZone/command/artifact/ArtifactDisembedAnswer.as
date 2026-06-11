package com.sunweb.game.rpg.worldZone.command.artifact
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ArtifactDisembedAnswer extends obf_O_8_1034
   {
      
      public var equipmentItemId:String;
      
      public var isSucceeded:Boolean;
      
      public function ArtifactDisembedAnswer()
      {
         super(CommandCodeArtifact.ARTIFACT_DISEMBED_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentItemId:string","isSucceeded:boolean"];
      }
   }
}

