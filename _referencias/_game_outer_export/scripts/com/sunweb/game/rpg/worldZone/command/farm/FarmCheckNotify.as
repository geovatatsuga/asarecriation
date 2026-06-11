package com.sunweb.game.rpg.worldZone.command.farm
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.farm.FarmInfo;
   
   public class FarmCheckNotify extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var farm:FarmInfo;
      
      public function FarmCheckNotify()
      {
         super(CommandCodeFarm.FARM_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","farm:com.sunweb.game.rpg.farm.FarmInfo"];
      }
   }
}

