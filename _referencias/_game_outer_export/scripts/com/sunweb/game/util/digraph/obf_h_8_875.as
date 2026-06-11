package com.sunweb.game.util.digraph
{
   public class obf_h_8_875
   {
      
      private const obf_h_Z_3702:int = 2147483647;
      
      private var P:Array;
      
      private var G:Array;
      
      private var len:int;
      
      public function obf_h_8_875(param1:Array)
      {
         super();
         this.P = param1.concat();
         this.len = this.P.length;
         this.initG();
      }
      
      private function initG() : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         this.G = new Array(this.len);
         var _loc1_:int = 0;
         while(_loc1_ < this.len)
         {
            _loc2_ = new Array(this.len);
            this.G[_loc1_] = _loc2_;
            _loc3_ = 0;
            while(_loc3_ < this.len)
            {
               _loc2_[_loc3_] = this.obf_h_Z_3702;
               _loc3_++;
            }
            _loc1_++;
         }
      }
      
      public function get obf_W_H_3466() : Array
      {
         return this.P;
      }
      
      public function obf_N_z_2177(param1:int, param2:int, param3:int = 1) : void
      {
         var fromVertex:int = param1;
         var toVertex:int = param2;
         var weight:int = param3;
         try
         {
            this.G[fromVertex][toVertex] = weight;
         }
         catch(e:Error)
         {
         }
      }
      
      public function getShortestPath(param1:int, param2:int) : Array
      {
         var _loc3_:Object = obf_x_K_2863.getShortedPath(this.G,param1,param2,this.len);
         var _loc4_:int = int(_loc3_.dist);
         var _loc5_:Array = _loc3_.path;
         return _loc4_ == this.obf_h_Z_3702 ? null : _loc5_;
      }
   }
}

