package com.sunweb.game.rpg.worldZone.command.artifact
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ArtifactUpEquExpAnswer extends obf_O_8_1034
   {
      
      public var equipmentItemId:String;
      
      public var addEquExp:int;
      
      public var equLevel:int;
      
      public function ArtifactUpEquExpAnswer()
      {
         super(CommandCodeArtifact.ARTIFACT_UP_EQU_EXP_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentItemId:string","addEquExp:vint","equLevel:byte"];
      }
   }
}

