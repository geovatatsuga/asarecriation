package com.sunweb.game.rpg.worldZone.command.system
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.worldZone.command.CommandCodeWorld;
   
   public class WorldClientSaveConfigRequest extends obf_O_8_1034
   {
      
      public var config:String;
      
      public function WorldClientSaveConfigRequest()
      {
         super(CommandCodeWorld.WORLD_CLIENT_SAVE_CONFIG_REQ);
      }
      
      override public function getFieldList() : Array
      {
         return ["config:string"];
      }
   }
}

