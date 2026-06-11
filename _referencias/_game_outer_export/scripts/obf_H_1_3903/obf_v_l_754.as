package obf_H_1_3903
{
   import com.sunweb.game.rpg.sound.obf_q_6_3634;
   import com.sunweb.game.util.TimeLimiter;
   
   public class obf_v_l_754 extends obf_G_W_823
   {
      
      private var beginInvLimit:int = 10;
      
      private var obf_t_4701:int = 0;
      
      public var runLoopToTarget:int;
      
      public var loopLimit:int;
      
      private var obf_7_b_986:int = 1;
      
      public var cursorDoTimeInv:int = 20;
      
      public function obf_v_l_754(param1:int, param2:int, param3:int = 0, param4:int = 3)
      {
         super(param1,param2);
         _currentIndex = param3;
         this.runLoopToTarget = param4;
         this.loopLimit = this.runLoopToTarget;
      }
      
      public function get speed() : int
      {
         return this.obf_7_b_986;
      }
      
      public function set speed(param1:int) : void
      {
         if(param1 > 0)
         {
            this.obf_7_b_986 = 1;
         }
         else
         {
            this.obf_7_b_986 = -1;
         }
      }
      
      override public function action(param1:String) : void
      {
         super.action(param1);
         if(obf_B_S_1600 == obf_G_W_823.BEGINNING_STATUS)
         {
            this.obf_t_4701 = 0;
            _doTimeInv = new TimeLimiter(200);
         }
         else
         {
            _doTimeInv = new TimeLimiter(20);
         }
      }
      
      private function obf_r_3_1609() : void
      {
         obf_q_6_3634.obf_e_J_1876("gem@fs9",1);
         if(obf_B_S_1600 == obf_G_W_823.BEGINNING_STATUS)
         {
            return;
         }
         _currentIndex += this.obf_7_b_986;
         while(_currentIndex < 0 || _currentIndex >= obf_t_b_871)
         {
            if(_currentIndex >= obf_t_b_871)
            {
               _currentIndex -= obf_t_b_871;
            }
            else if(_currentIndex < 0)
            {
               _currentIndex += obf_t_b_871;
            }
         }
      }
      
      override protected function obf_F_8_1754() : void
      {
         obf_q_6_3634.obf_e_J_1876("gem@fs9",1);
         ++this.obf_t_4701;
         if(this.obf_t_4701 >= this.beginInvLimit)
         {
            obf_B_S_1600 = obf_G_W_823.RUNNING_STATUS;
            _doTimeInv = new TimeLimiter(20);
         }
      }
      
      override protected function obf_E_6_2765() : void
      {
         obf_q_6_3634.obf_e_J_1876("gem@fs9",1);
         this.obf_r_3_1609();
         if(_currentIndex == _endTargetIndex)
         {
            if(this.loopLimit <= 0)
            {
               obf_B_S_1600 = obf_G_W_823.ENDING_STATUS;
               obf_q_6_3634.obf_e_J_1876("enhanceComplete@fs9",1);
            }
            else
            {
               --this.loopLimit;
            }
         }
         _doTimeInv = new TimeLimiter(this.cursorDoTimeInv);
      }
      
      override protected function obf_z_x_915() : void
      {
         obf_B_S_1600 = obf_G_W_823.DONE_STATUS;
      }
   }
}

