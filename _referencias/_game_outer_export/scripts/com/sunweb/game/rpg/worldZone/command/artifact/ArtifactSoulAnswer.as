package com.sunweb.game.rpg.worldZone.command.artifact
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ArtifactSoulAnswer extends obf_O_8_1034
   {
      
      public var isSuccessed:Boolean;
      
      public var equipId:String;
      
      public function ArtifactSoulAnswer()
      {
         super(CommandCodeArtifact.ARTIFACT_SOUL_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["isSuccessed:boolean","equipId:string"];
      }
   }
}

