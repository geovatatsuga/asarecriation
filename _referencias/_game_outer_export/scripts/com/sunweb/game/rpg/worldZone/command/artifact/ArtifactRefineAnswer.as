package com.sunweb.game.rpg.worldZone.command.artifact
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ArtifactRefineAnswer extends obf_O_8_1034
   {
      
      public var equipmentItemId:String;
      
      public var refineLevel:int;
      
      public var isSucceeded:Boolean;
      
      public function ArtifactRefineAnswer()
      {
         super(CommandCodeArtifact.ARTIFACT_REFINE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentItemId:string","refineLevel:byte","isSucceeded:boolean"];
      }
   }
}

