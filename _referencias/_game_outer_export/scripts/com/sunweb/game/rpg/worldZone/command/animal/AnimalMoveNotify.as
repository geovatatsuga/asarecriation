package com.sunweb.game.rpg.worldZone.command.animal
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.world.map.MapPoint;
   
   public class AnimalMoveNotify extends obf_O_8_1034
   {
      
      public var animalId:String;
      
      public var mapId:String;
      
      public var position:MapPoint;
      
      public var walkSpeed:int;
      
      public var pathArrayReversed:Array;
      
      public var reasonCode:int;
      
      public function AnimalMoveNotify()
      {
         super(CommandCodePlayerAnimal.ANIMAL_MOVE_NOTIFY);
      }
      
      public function get pathArray() : Array
      {
         return this.pathArrayReversed != null ? this.pathArrayReversed.concat().reverse() : null;
      }
      
      public function set pathArray(param1:Array) : void
      {
         if(param1)
         {
            this.pathArrayReversed = param1.concat().reverse();
         }
         else
         {
            this.pathArrayReversed = null;
         }
      }
      
      override public function getFieldList() : Array
      {
         return ["animalId:string","mapId:string","position:com.sunweb.game.rpg.world.map.MapPoint","walkSpeed:short","pathArrayReversed:array(com.sunweb.game.rpg.world.map.MapPoint)","reasonCode:byte"];
      }
   }
}

