package com.sunweb.game.rpg.worldZone.command.artifact
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ArtifactRefineRequest extends obf_O_8_1034
   {
      
      public var equipmentItemId:String;
      
      public var currentRefineLevel:int;
      
      public var materialItems:Array;
      
      public function ArtifactRefineRequest()
      {
         super(CommandCodeArtifact.ARTIFACT_REFINE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentItemId:string","currentRefineLevel:byte","materialItems:array(string)"];
      }
   }
}

