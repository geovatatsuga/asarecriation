package com.sunweb.game.rpg.worldZone.command.artifact
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ArtifactSoulMoveRequest extends obf_O_8_1034
   {
      
      public var loseId:String;
      
      public var getId:String;
      
      public function ArtifactSoulMoveRequest()
      {
         super(CommandCodeArtifact.ARTIFACT_SOUL_MOVE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["loseId:string","getId:string"];
      }
   }
}

