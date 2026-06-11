package com.sunweb.game.rpg.worldZone.command.artifact
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ArtifactUpgradeRequest extends obf_O_8_1034
   {
      
      public var equItemBase:String;
      
      public var addedItems:Array;
      
      public function ArtifactUpgradeRequest()
      {
         super(CommandCodeArtifact.ARTIFACT_UPGRADE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["equItemBase:string","addedItems:array(string)"];
      }
   }
}

