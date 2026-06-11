package obf_Z_P_2758
{
   import com.sunweb.game.rpg.fateTurntable.obf_0_7_a_267;
   import com.sunweb.game.rpg.fateTurntable.obf_S_4_4436;
   import com.sunweb.game.rpg.fateTurntable.obf_y_I_905;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import playerUI.Test.InnerBlackStopEffect;
   import playerUI.Test.InnerCursorEffect;
   import playerUI.Test.InnerStopEffect;
   import playerUI.Test.MiddleBlackStopEffect;
   import playerUI.Test.MiddleCursorEffect;
   import playerUI.Test.MiddleStopEffect;
   import playerUI.Test.OuterBlackStopEffect;
   import playerUI.Test.OuterCursorEffect;
   import playerUI.Test.OuterStopEffect;
   
   public class FateAwardCursorBase extends EventDispatcher
   {
      
      public static var obf_n_S_1442:Array;
      
      public static var obf_0_4_k_446:DisplayObjectContainer;
      
      public static var wheelBags2:Array;
      
      public static var obf_0_0_4_725:DisplayObjectContainer;
      
      public static var wheelBags3:Array;
      
      public static var obf_5_D_1690:DisplayObjectContainer;
      
      public static const obf_c_a_4500:String = "cursor_Run";
      
      public static const RUNNING_STATUS:String = "running";
      
      public static const BEGINNING_STATUS:String = "beginning";
      
      public static const ENDING_STATUS:String = "ending";
      
      public static const DONE_STATUS:String = "done";
      
      protected var _doTimeInv:TimeLimiter;
      
      protected var _currentIndex:int;
      
      private var obf_E_F_2071:String;
      
      protected var _endTargetIndex:int;
      
      protected var obf_t_b_871:int;
      
      private var obf_0_6_i_379:String;
      
      private var obf_0_4_T_559:int;
      
      private var obf_F_x_2507:Boolean;
      
      private var _type:int;
      
      public function FateAwardCursorBase(param1:int, param2:int, param3:int)
      {
         super();
         this.obf_t_b_871 = param1;
         this._endTargetIndex = param2;
         this._type = param3;
      }
      
      public function get isDone() : Boolean
      {
         return this.obf_E_F_2071 == DONE_STATUS;
      }
      
      public function set cursorIndex(param1:int) : void
      {
         this._currentIndex = param1;
      }
      
      public function get cursorIndex() : int
      {
         return this._currentIndex;
      }
      
      protected function get obf_B_S_1600() : String
      {
         return this.obf_E_F_2071;
      }
      
      protected function set obf_B_S_1600(param1:String) : void
      {
         this.obf_E_F_2071 = param1;
      }
      
      public function setEventTime(param1:String, param2:int, param3:Boolean = false) : void
      {
         this.obf_0_6_i_379 = param1;
         this.obf_0_4_T_559 = param2;
         this.obf_F_x_2507 = param3;
      }
      
      public function action(param1:String) : void
      {
         this.obf_B_S_1600 = param1;
         if(this._type == 1)
         {
            this.showCursorEffect();
         }
         else if(this._type == 2)
         {
            this.show2CursorEffect();
         }
         else if(this._type == 3)
         {
            this.show3CursorEffect();
         }
      }
      
      public function obf_m_3205() : void
      {
         if(obf_L_l_4100.isEmpty(this.obf_E_F_2071) || this.obf_E_F_2071 == DONE_STATUS)
         {
            return;
         }
         if(!this._doTimeInv || !this._doTimeInv.checkTimeout())
         {
            return;
         }
         if(this.obf_E_F_2071 == BEGINNING_STATUS)
         {
            this.obf_F_8_1754();
         }
         else if(this.obf_E_F_2071 == RUNNING_STATUS)
         {
            this.obf_E_6_2765();
         }
         else if(this.obf_E_F_2071 == ENDING_STATUS)
         {
            this.obf_z_x_915();
         }
         if(this._type == 1)
         {
            this.showCursorEffect();
         }
         else if(this._type == 2)
         {
            this.show2CursorEffect();
         }
         else if(this._type == 3)
         {
            this.show3CursorEffect();
         }
         this.dispatchEvent(new Event(obf_c_a_4500));
      }
      
      protected function showCursorEffect() : void
      {
         var _loc2_:OuterCursorEffect = null;
         var _loc3_:* = undefined;
         if(!obf_n_S_1442 || !obf_0_4_k_446)
         {
            return;
         }
         if(this.obf_E_F_2071 == DONE_STATUS)
         {
            this._currentIndex = this._endTargetIndex;
         }
         var _loc1_:MovieClip = JSONUtil.getObject(obf_n_S_1442,[this._currentIndex]) as MovieClip;
         if(this.obf_E_F_2071 == BEGINNING_STATUS || this.obf_E_F_2071 == RUNNING_STATUS || this.obf_E_F_2071 == ENDING_STATUS)
         {
            _loc2_ = new OuterCursorEffect();
            _loc2_.x = _loc1_.x;
            _loc2_.y = _loc1_.y;
            _loc2_.rotation = obf_0_7_a_267.getDegree(this._currentIndex);
            obf_0_4_k_446.addChild(_loc2_);
         }
         else if(this.obf_E_F_2071 == DONE_STATUS)
         {
            if(obf_K_e_3075.obf_P_2_4217.obf_6_k_3002 == 1)
            {
               _loc3_ = new OuterStopEffect();
            }
            else if(obf_K_e_3075.obf_P_2_4217.obf_6_k_3002 == 2)
            {
               _loc3_ = new OuterBlackStopEffect();
            }
            _loc3_.x = _loc1_.x;
            _loc3_.y = _loc1_.y;
            _loc3_.rotation = obf_0_7_a_267.getDegree(this._currentIndex);
            obf_0_4_k_446.addChild(_loc3_);
            obf_K_e_3075.obf_P_2_4217.obf_k_T_4034();
         }
      }
      
      protected function show2CursorEffect() : void
      {
         var _loc2_:MiddleCursorEffect = null;
         var _loc3_:* = undefined;
         if(!wheelBags2 || !obf_0_0_4_725)
         {
            return;
         }
         if(this.obf_E_F_2071 == DONE_STATUS)
         {
            this._currentIndex = this._endTargetIndex;
         }
         var _loc1_:MovieClip = JSONUtil.getObject(wheelBags2,[this._currentIndex]) as MovieClip;
         if(this.obf_E_F_2071 == BEGINNING_STATUS || this.obf_E_F_2071 == RUNNING_STATUS || this.obf_E_F_2071 == ENDING_STATUS)
         {
            _loc2_ = new MiddleCursorEffect();
            _loc2_.x = _loc1_.x;
            _loc2_.y = _loc1_.y;
            _loc2_.rotation = obf_S_4_4436.getDegree(this._currentIndex);
            obf_0_0_4_725.addChild(_loc2_);
         }
         else if(this.obf_E_F_2071 == DONE_STATUS)
         {
            if(obf_K_e_3075.obf_P_2_4217.obf_o_u_3835 == 1)
            {
               _loc3_ = new MiddleStopEffect();
            }
            else if(obf_K_e_3075.obf_P_2_4217.obf_o_u_3835 == 2)
            {
               _loc3_ = new MiddleBlackStopEffect();
            }
            _loc3_.x = _loc1_.x;
            _loc3_.y = _loc1_.y;
            _loc3_.rotation = obf_S_4_4436.getDegree(this._currentIndex);
            obf_0_0_4_725.addChild(_loc3_);
            obf_K_e_3075.obf_P_2_4217.obf_k_T_4034();
         }
      }
      
      protected function show3CursorEffect() : void
      {
         var _loc2_:InnerCursorEffect = null;
         var _loc3_:* = undefined;
         if(!wheelBags3 || !obf_5_D_1690)
         {
            return;
         }
         if(this.obf_E_F_2071 == DONE_STATUS)
         {
            this._currentIndex = this._endTargetIndex;
         }
         var _loc1_:MovieClip = JSONUtil.getObject(wheelBags3,[this._currentIndex]) as MovieClip;
         if(this.obf_E_F_2071 == BEGINNING_STATUS || this.obf_E_F_2071 == RUNNING_STATUS || this.obf_E_F_2071 == ENDING_STATUS)
         {
            _loc2_ = new InnerCursorEffect();
            _loc2_.x = _loc1_.x;
            _loc2_.y = _loc1_.y;
            _loc2_.rotation = obf_y_I_905.getDegree(this._currentIndex);
            obf_5_D_1690.addChild(_loc2_);
         }
         else if(this.obf_E_F_2071 == DONE_STATUS)
         {
            if(obf_K_e_3075.obf_P_2_4217.obf_u_v_4445 == 1)
            {
               _loc3_ = new InnerStopEffect();
            }
            else if(obf_K_e_3075.obf_P_2_4217.obf_u_v_4445 == 2)
            {
               _loc3_ = new InnerBlackStopEffect();
            }
            _loc3_.x = _loc1_.x;
            _loc3_.y = _loc1_.y;
            _loc3_.rotation = obf_y_I_905.getDegree(this._currentIndex);
            obf_5_D_1690.addChild(_loc3_);
            obf_K_e_3075.obf_P_2_4217.obf_k_T_4034();
         }
      }
      
      protected function obf_F_8_1754() : void
      {
      }
      
      protected function obf_E_6_2765() : void
      {
      }
      
      protected function obf_z_x_915() : void
      {
      }
   }
}

