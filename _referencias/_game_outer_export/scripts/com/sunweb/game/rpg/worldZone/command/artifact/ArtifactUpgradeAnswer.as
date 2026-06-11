package com.sunweb.game.rpg.worldZone.command.artifact
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ArtifactUpgradeAnswer extends obf_O_8_1034
   {
      
      public var equipmentItemId:String;
      
      public var equipmentItemCode:String;
      
      public var isSucceeded:Boolean;
      
      public function ArtifactUpgradeAnswer()
      {
         super(CommandCodeArtifact.ARTIFACT_UPGRADE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentItemId:string","equipmentItemCode:string","isSucceeded:boolean"];
      }
   }
}

