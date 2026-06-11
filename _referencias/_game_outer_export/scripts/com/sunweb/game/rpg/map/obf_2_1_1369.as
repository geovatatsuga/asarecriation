package com.sunweb.game.rpg.map
{
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.res.obf_b_8_4256;
   import com.sunweb.game.util.obf_3_9_3148;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class obf_2_1_1369 extends Sprite
   {
      
      public static const obf_W_f_2388:int = 0;
      
      public static const obf_u_m_3011:int = 1;
      
      public static const set:int = 2;
      
      public static const obf_x_y_1661:int = 3;
      
      public static const obf_T_c_1628:int = 4;
      
      public static const obf_Z_t_1955:int = 5;
      
      public static const obf_5_Q_881:String = "background";
      
      public static const obf_o_5_4428:String = "bgObjects";
      
      public static const obf_o_e_997:String = "roles";
      
      public static const obf_u_I_4216:String = "magic";
      
      public static const obf_0_0_r_344:String = "fgObjects";
      
      public static const obf_K_R_3147:String = "sky";
      
      private var _map:Map;
      
      private var _id:String;
      
      private var obf_B_7_1701:Boolean;
      
      private var _content:Array;
      
      public var isLazyLoading:Boolean = false;
      
      private var obf_c_k_1234:int = 100;
      
      private var _loadingObjects:Dictionary = new Dictionary();
      
      private var obf_0_7_q_97:Dictionary = new Dictionary();
      
      private var obf_0_L_1542:Dictionary = new Dictionary();
      
      private var obf_0_5_h_632:Dictionary = new Dictionary();
      
      private var obf_y_r_3270:Number = 0.45;
      
      private var _updateAlphaStep:Number = 0.03;
      
      public function obf_2_1_1369(param1:Map, param2:Object = null, param3:String = null)
      {
         super();
         this.mouseEnabled = false;
         this.mouseChildren = false;
         this._map = param1;
         if(param2 != null)
         {
            this.loadConfig(param2);
         }
         else
         {
            this.obf_o_c_1102(param3);
         }
      }
      
      private function obf_o_c_1102(param1:String) : void
      {
         this._id = param1;
         this.obf_B_7_1701 = this._id == obf_o_e_997;
         if(this.obf_B_7_1701)
         {
            this.isLazyLoading = true;
         }
         else if(this._map.isLazyLoadBackground && (this._id == obf_5_Q_881 || this._id == obf_o_5_4428))
         {
            this.isLazyLoading = true;
         }
         else if(this._map.isLazyLoadForeground && (this._id == obf_0_0_r_344 || this._id == obf_u_I_4216 || this._id == obf_K_R_3147))
         {
            this.isLazyLoading = true;
         }
         else
         {
            this.isLazyLoading = false;
         }
         this._content = new Array();
      }
      
      private function loadConfig(param1:Object) : void
      {
         this.obf_o_c_1102(param1.id);
         var _loc2_:Array = param1.content;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            this._content.push(this.obf_B_7_1701 ? new obf_p_X_4170(_loc2_[_loc3_]) : new obf_P_4660(_loc2_[_loc3_]));
            _loc3_++;
         }
         obf_x_0_1295.obf_r_w_3556("==== layer (" + this._id + ") object number: " + _loc2_.length);
      }
      
      public function get map() : Map
      {
         return this._map;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get isRoleLayer() : Boolean
      {
         return this.obf_B_7_1701;
      }
      
      public function get content() : Array
      {
         return this._content;
      }
      
      public function obf_0_9_K_397() : void
      {
         var _loc2_:obf_A_1_2543 = null;
         var _loc1_:Rectangle = this._map.obf_0_6_g_261;
         _loc1_.inflate(this.obf_c_k_1234,this.obf_c_k_1234);
         for each(_loc2_ in this._content)
         {
            if(this.isLazyLoading)
            {
               if(_loc1_.intersects(_loc2_.area))
               {
                  _loc2_.obf_T_Y_4478(this);
               }
            }
            else
            {
               _loc2_.obf_T_Y_4478(this);
            }
         }
      }
      
      public function updateView() : void
      {
         var _loc2_:obf_A_1_2543 = null;
         if(!this.isLazyLoading)
         {
            return;
         }
         var _loc1_:Rectangle = this._map.obf_0_6_g_261;
         _loc1_.inflate(this.obf_c_k_1234,this.obf_c_k_1234);
         for each(_loc2_ in this._content)
         {
            if(_loc1_.intersects(_loc2_.area))
            {
               if(!_loc2_.isInStage && this._loadingObjects[_loc2_] == null)
               {
                  _loc2_.obf_T_Y_4478(this);
               }
            }
            else if(_loc2_.isInStage)
            {
               _loc2_.removeMe();
            }
            else if(this._loadingObjects[_loc2_] != null)
            {
               delete this._loadingObjects[_loc2_];
            }
         }
         this.obf_8_8_4470();
      }
      
      public function loadAndShowObject(param1:obf_A_1_2543) : void
      {
         if(this._loadingObjects[param1] != null)
         {
            return;
         }
         var _loc2_:String = null;
         if(param1 is obf_p_X_4170)
         {
            _loc2_ = (param1 as obf_p_X_4170).res;
         }
         else if(param1 is obf_P_4660)
         {
            _loc2_ = (param1 as obf_P_4660).res;
         }
         this._map.resourceBag.manager.obf_h_p_1259(_loc2_);
         var _loc3_:String = obf_b_8_4256.getResIdToImport(_loc2_);
         if(_loc3_ == null || !this._map.resourceBag.manager.existsResource(_loc3_))
         {
            trace(">>>> MapLayer.loadAndShowObject() invalid res: " + _loc2_);
            return;
         }
         this._loadingObjects[param1] = _loc3_;
         this._map.resourceBag.obf_z_U_2156(_loc3_);
      }
      
      private function obf_8_8_4470() : void
      {
         var _loc4_:* = undefined;
         var _loc5_:obf_A_1_2543 = null;
         var _loc1_:ResourceManager = this._map.resourceBag.manager;
         var _loc2_:String = null;
         var _loc3_:Boolean = false;
         for each(_loc2_ in this._loadingObjects)
         {
            if(_loc1_.isResourceLoaded(_loc2_))
            {
               _loc3_ = true;
               break;
            }
         }
         if(!_loc3_)
         {
            return;
         }
         for(_loc4_ in this._loadingObjects)
         {
            _loc5_ = _loc4_ as obf_A_1_2543;
            _loc2_ = this._loadingObjects[_loc5_];
            if(_loc1_.isResourceLoaded(_loc2_))
            {
               delete this._loadingObjects[_loc5_];
               _loc5_.obf_T_Y_4478(this);
            }
         }
      }
      
      public function _tryToShowLoadingObject() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:obf_A_1_2543 = null;
         for(_loc1_ in this._loadingObjects)
         {
            _loc2_ = _loc1_ as obf_A_1_2543;
            _loc2_.obf_T_Y_4478(this);
         }
      }
      
      public function obf_B_o_2972() : void
      {
         var _loc3_:obf_A_1_2543 = null;
         var _loc4_:* = undefined;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:obf_p_X_4170 = null;
         var _loc8_:obf_P_4660 = null;
         var _loc1_:int = parent.getChildIndex(this);
         if(_loc1_ < set || _loc1_ == obf_x_y_1661)
         {
            return;
         }
         var _loc2_:Point = this._map.localToGlobal(this._map.player.centerPoint);
         if(this.isRoleLayer)
         {
            _loc6_ = _loc5_ = this.getChildIndex(this._map.player);
            while(_loc6_ < this.numChildren)
            {
               _loc7_ = this.getChildAt(_loc6_) as obf_p_X_4170;
               if(!(_loc7_ == null || _loc7_.displayObject == null))
               {
                  if(obf_1_q_4613.hitTestPoint(_loc7_,_loc2_))
                  {
                     this.obf_0_5_h_632[_loc7_] = _loc7_;
                     if(this.obf_0_7_q_97[_loc7_] == null)
                     {
                        this.obf_0_7_q_97[_loc7_] = _loc7_;
                     }
                     if(this.obf_0_L_1542[_loc7_] != null)
                     {
                        delete this.obf_0_L_1542[_loc7_];
                     }
                  }
               }
               _loc6_++;
            }
         }
         else
         {
            for each(_loc8_ in this._content)
            {
               if(_loc8_.displayObject != null)
               {
                  if(obf_1_q_4613.hitTestPoint(_loc8_.displayObject,_loc2_))
                  {
                     this.obf_0_5_h_632[_loc8_] = _loc8_;
                     if(this.obf_0_7_q_97[_loc8_] == null)
                     {
                        this.obf_0_7_q_97[_loc8_] = _loc8_;
                     }
                     if(this.obf_0_L_1542[_loc8_] != null)
                     {
                        delete this.obf_0_L_1542[_loc8_];
                     }
                  }
               }
            }
         }
         for each(_loc3_ in this.obf_0_7_q_97)
         {
            if(this.obf_0_5_h_632[_loc3_] == null)
            {
               this.obf_0_L_1542[_loc3_] = _loc3_;
               delete this.obf_0_7_q_97[_loc3_];
            }
         }
         for each(_loc4_ in this.obf_0_5_h_632)
         {
            delete this.obf_0_5_h_632[_loc4_];
         }
      }
      
      public function updateAlphaByStep() : void
      {
         var tile:obf_A_1_2543 = null;
         var da:Number = NaN;
         for each(tile in this.obf_0_7_q_97)
         {
            da = tile.obf_0_5_S_544.alpha - this.obf_y_r_3270;
            try
            {
               if(((tile as Object).res as String).indexOf("tm") == 0)
               {
                  da = tile.obf_0_5_S_544.alpha;
               }
            }
            catch(e:Error)
            {
            }
            if(da > 0)
            {
               tile.obf_0_5_S_544.alpha -= da > this._updateAlphaStep ? this._updateAlphaStep : da;
            }
         }
         for each(tile in this.obf_0_L_1542)
         {
            da = 1 - tile.obf_0_5_S_544.alpha;
            if(da > 0)
            {
               tile.obf_0_5_S_544.alpha += da > this._updateAlphaStep ? this._updateAlphaStep : da;
            }
            else
            {
               delete this.obf_0_L_1542[tile];
            }
         }
      }
      
      public function removeChildren() : void
      {
         var _loc1_:obf_A_1_2543 = null;
         for each(_loc1_ in this.obf_0_7_q_97)
         {
            _loc1_.obf_0_5_S_544.alpha = 1;
            delete this.obf_0_7_q_97[_loc1_];
         }
         for each(_loc1_ in this.obf_0_L_1542)
         {
            _loc1_.obf_0_5_S_544.alpha = 1;
            delete this.obf_0_L_1542[_loc1_];
         }
         obf_3_9_3148.removeChildren(this);
      }
      
      public function release() : void
      {
         var _loc1_:obf_A_1_2543 = null;
         for each(_loc1_ in this._content)
         {
            _loc1_.release();
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:obf_A_1_2543 = null;
         for each(_loc1_ in this._content)
         {
            _loc1_.destroy();
         }
         this._content.length = 0;
         this._map = null;
         this._loadingObjects = null;
      }
   }
}

