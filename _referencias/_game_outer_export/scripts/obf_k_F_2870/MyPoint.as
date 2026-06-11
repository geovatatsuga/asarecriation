package obf_k_F_2870
{
   import flash.geom.Point;
   
   public class MyPoint extends Point
   {
      
      public var prent_id:int;
      
      public var id_num:int;
      
      public var F_num:int;
      
      public var G_num:int;
      
      public var H_num:int;
      
      public var in_open:Boolean;
      
      public var in_close:Boolean;
      
      public function MyPoint(param1:Point, param2:int, param3:int)
      {
         super(param1.x,param1.y);
         this.prent_id = param2;
         this.id_num = param3;
         this.in_open = false;
         this.in_close = false;
      }
   }
}

