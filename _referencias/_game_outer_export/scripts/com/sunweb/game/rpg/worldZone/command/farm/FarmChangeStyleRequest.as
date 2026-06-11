package com.sunweb.game.rpg.worldZone.command.farm
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class FarmChangeStyleRequest extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var farmId:String;
      
      public var newStyleCode:String;
      
      public var useMoney:Boolean = false;
      
      public function FarmChangeStyleRequest()
      {
         super(CommandCodeFarm.FARM_CHANGE_STYLE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","farmId:string","newStyleCode:string","useMoney:boolean"];
      }
   }
}

