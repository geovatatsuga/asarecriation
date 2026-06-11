package com.sunweb.game.rpg.worldZone.command.artifact
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ArtifactFusionRequest extends obf_O_8_1034
   {
      
      public var equItemBase:String;
      
      public var equItemStuff:String;
      
      public function ArtifactFusionRequest()
      {
         super(CommandCodeArtifact.ARTIFACT_FUSION_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["equItemBase:string","equItemStuff:string"];
      }
   }
}

