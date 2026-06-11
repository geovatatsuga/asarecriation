package com.sunweb.game.rpg.worldZone.command.artifact
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ArtifactHoleAnswer extends obf_O_8_1034
   {
      
      public var equipmentItemId:String;
      
      public var isSucceeded:Boolean;
      
      public function ArtifactHoleAnswer()
      {
         super(CommandCodeArtifact.ARTIFACT_HOLE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentItemId:string","isSucceeded:boolean"];
      }
   }
}

