package com.sunweb.game.rpg.world.map
{
   import com.sunweb.game.res.ResourceBag;
   import com.sunweb.game.rpg.map.Map;
   import flash.events.Event;
   
   public class MapManagerEvent extends Event
   {
      
      public static const MAP_CREATE_COMPLETE:String = "MapCreateComplete";
      
      public static const MAP_CREATE_ERROR:String = "MapCreateError";
      
      public static const MAP_START_LOAD:String = "MapStartLoad";
      
      public var map:Map;
      
      public var mapBag:ResourceBag;
      
      public function MapManagerEvent(param1:String)
      {
         super(param1);
      }
   }
}

