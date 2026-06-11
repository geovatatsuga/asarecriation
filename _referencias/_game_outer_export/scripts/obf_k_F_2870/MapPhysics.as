package obf_k_F_2870
{
   import com.sunweb.game.rpg.map.Map;
   import flash.display.Sprite;
   
   public dynamic class MapPhysics extends Sprite
   {
      
      private var _map:Map;
      
      public function MapPhysics(param1:Map)
      {
         super();
         this._map = param1;
      }
      
      public function checkPass(param1:Number, param2:Number) : Boolean
      {
         return this._map.obf_0_3_m_391(param1 >> Map.obf_Z_7_3230,param2 >> Map.obf_d_1_1185);
      }
   }
}

