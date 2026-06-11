package com.sunweb.game.rpg.worldZone.command.remote
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RemoteEquipmentModelCheckNotify extends obf_O_8_1034
   {
      
      public var roleName:String;
      
      public var equipmentModels:Object;
      
      public function RemoteEquipmentModelCheckNotify()
      {
         super(CommandCodeRemotePlayer.REMOTE_EQUIPMENT_MODEL_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["roleName:string","equipmentModels:map(byte,string)"];
      }
   }
}

