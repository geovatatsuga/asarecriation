package com.sunweb.game.rpg.worldZone.command.artifact
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ArtifactWashRequest extends obf_O_8_1034
   {
      
      public var equipmentItemId:String;
      
      public function ArtifactWashRequest()
      {
         super(CommandCodeArtifact.ARTIFACT_WASH_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentItemId:string"];
      }
   }
}

