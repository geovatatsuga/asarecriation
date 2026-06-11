package com.sunweb.game.rpg.map.pathfind.astar
{
   public class Arrange
   {
      
      private var obf_Y_h_2772:Array;
      
      private var obf_Q_h_1090:Function;
      
      private var _key:String;
      
      private var _desending:Boolean = true;
      
      public function Arrange()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.obf_Y_h_2772 = [];
         this.obf_Q_h_1090 = this.compares;
      }
      
      public function set desending(param1:Boolean) : void
      {
         this._desending = param1;
      }
      
      public function obf_0_1_K_177(param1:Object) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = int(this.obf_Y_h_2772.length);
         if(_loc2_ < 1)
         {
            this.obf_Y_h_2772.push(param1);
            return;
         }
         var _loc3_:int = 0;
         var _loc4_:int = _loc2_ - 1;
         while(_loc2_ > 1)
         {
            _loc5_ = _loc3_ + _loc2_ / 2;
            _loc6_ = this.obf_Q_h_1090(param1,this.obf_Y_h_2772[_loc5_]);
            switch(_loc6_)
            {
               case -1:
                  _loc3_ = _loc5_;
                  break;
               case 0:
                  this.obf_Y_h_2772.splice(_loc5_,0,param1);
                  return;
               case 1:
                  _loc4_ = _loc5_;
            }
            _loc2_ = _loc4_ - _loc3_;
         }
         _loc6_ = this.obf_Q_h_1090(param1,this.obf_Y_h_2772[_loc3_]);
         if(_loc6_ == 1 || _loc6_ == 0)
         {
            this.obf_Y_h_2772.splice(_loc3_,0,param1);
            return;
         }
         _loc6_ = this.obf_Q_h_1090(param1,this.obf_Y_h_2772[_loc4_]);
         if(_loc6_ == 1 || _loc6_ == 0)
         {
            this.obf_Y_h_2772.splice(_loc4_,0,param1);
            return;
         }
         this.obf_Y_h_2772.splice(_loc4_ + 1,0,param1);
      }
      
      public function set key(param1:String) : void
      {
         if(param1 != null && param1 != "")
         {
            this._key = param1;
         }
      }
      
      public function set obf_c_A_890(param1:Boolean) : void
      {
         if(param1)
         {
            this.obf_Q_h_1090 = this.obf_H_h_3342;
         }
      }
      
      private function obf_H_h_3342(param1:Number, param2:Number) : int
      {
         var _loc3_:Number = param1 - param2;
         if(!this._desending)
         {
            _loc3_ *= -1;
         }
         if(_loc3_ < 0)
         {
            return -1;
         }
         if(_loc3_ > 0)
         {
            return 1;
         }
         return 0;
      }
      
      private function compares(param1:Object, param2:Object) : int
      {
         var _loc3_:Number = param1[this._key] - param2[this._key];
         if(!this._desending)
         {
            _loc3_ *= -1;
         }
         if(_loc3_ < 0)
         {
            return -1;
         }
         if(_loc3_ > 0)
         {
            return 1;
         }
         return 0;
      }
      
      public function pop() : Object
      {
         return this.obf_Y_h_2772.pop();
      }
      
      public function shift() : Object
      {
         return this.obf_Y_h_2772.shift();
      }
      
      public function get array() : Array
      {
         return this.obf_Y_h_2772;
      }
      
      public function clear() : void
      {
         this.obf_Y_h_2772 = [];
      }
      
      public function obf_G_B_3133(param1:Array, param2:Boolean = true, param3:String = "") : Array
      {
         var _loc4_:Object = null;
         if(param1 == null || param1.length < 2)
         {
            return param1;
         }
         if(param3 == null || param3 == "")
         {
            this.obf_Q_h_1090 = this.obf_H_h_3342;
         }
         this.desending = param2;
         this.clear();
         for each(_loc4_ in param1)
         {
            this.obf_0_1_K_177(_loc4_);
         }
         return this.array;
      }
   }
}

