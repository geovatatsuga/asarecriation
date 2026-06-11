package obf_H_1_3903
{
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import playerUI.WheelAward.WheelAwardCursorEffect;
   import playerUI.WheelAward.WheelAwardCursorStopEffect;
   
   public class obf_G_W_823 extends EventDispatcher
   {
      
      public static var obf_n_S_1442:Array;
      
      public static var obf_0_4_k_446:DisplayObjectContainer;
      
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
      
      public function obf_G_W_823(param1:int, param2:int)
      {
         super();
         this.obf_t_b_871 = param1;
         this._endTargetIndex = param2;
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
         this.showCursorEffect();
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
         this.showCursorEffect();
         this.dispatchEvent(new Event(obf_c_a_4500));
      }
      
      protected function showCursorEffect() : void
      {
         var _loc2_:WheelAwardCursorEffect = null;
         var _loc3_:WheelAwardCursorStopEffect = null;
         if(!obf_n_S_1442 || !obf_0_4_k_446)
         {
            return;
         }
         if(this.obf_E_F_2071 == DONE_STATUS)
         {
            this._currentIndex = this._endTargetIndex;
         }
         var _loc1_:IconItemBag = JSONUtil.getObject(obf_n_S_1442,[this._currentIndex]) as IconItemBag;
         if(this.obf_E_F_2071 == BEGINNING_STATUS || this.obf_E_F_2071 == RUNNING_STATUS || this.obf_E_F_2071 == ENDING_STATUS)
         {
            _loc2_ = new WheelAwardCursorEffect();
            _loc2_.x = _loc1_.x;
            _loc2_.y = _loc1_.y;
            obf_0_4_k_446.addChild(_loc2_);
         }
         else if(this.obf_E_F_2071 == DONE_STATUS)
         {
            _loc3_ = new WheelAwardCursorStopEffect();
            _loc3_.x = _loc1_.x;
            _loc3_.y = _loc1_.y;
            obf_0_4_k_446.addChild(_loc3_);
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

