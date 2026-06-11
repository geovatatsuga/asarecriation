package com.sunweb.game.rpg.worldZone.command.artifact
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ArtifactSoulMoveAnswer extends obf_O_8_1034
   {
      
      public var loseEquipId:String;
      
      public var getEquipId:String;
      
      public function ArtifactSoulMoveAnswer()
      {
         super(CommandCodeArtifact.ARTIFACT_SOUL_MOVE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["loseEquipId:string","loseEquipId:string"];
      }
   }
}

