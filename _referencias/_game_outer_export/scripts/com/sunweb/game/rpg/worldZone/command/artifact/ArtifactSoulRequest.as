package com.sunweb.game.rpg.worldZone.command.artifact
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ArtifactSoulRequest extends obf_O_8_1034
   {
      
      public var equipmentId:String;
      
      public function ArtifactSoulRequest()
      {
         super(CommandCodeArtifact.ARTIFACT_SOUL_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentId:string"];
      }
   }
}

