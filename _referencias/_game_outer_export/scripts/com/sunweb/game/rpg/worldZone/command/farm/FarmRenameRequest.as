package com.sunweb.game.rpg.worldZone.command.farm
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class FarmRenameRequest extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var farmId:String;
      
      public var newName:String;
      
      public function FarmRenameRequest()
      {
         super(CommandCodeFarm.FARM_RENAME_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","farmId:string","newName:string"];
      }
   }
}

