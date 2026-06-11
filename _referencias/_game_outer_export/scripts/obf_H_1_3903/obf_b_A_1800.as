package obf_H_1_3903
{
   import com.sunweb.game.rpg.sound.obf_q_6_3634;
   import com.sunweb.game.util.TimeLimiter;
   
   public class obf_b_A_1800 extends obf_G_W_823
   {
      
      private var beginTimes:Array = [800,600,450,300,200,100,50];
      
      private var endTimes:Array = [100,200,300,450,600,800];
      
      private var currentBEActIndex:int;
      
      public var runLoopToTarget:int;
      
      public var loopLimit:int;
      
      private var obf_7_b_986:int = 1;
      
      public function obf_b_A_1800(param1:int, param2:int, param3:int = 3)
      {
         super(param1,param2);
         this.runLoopToTarget = param3;
         this.loopLimit = this.runLoopToTarget;
         this.endTimes = new Array();
         var _loc4_:int = 4 + Math.random() * 3;
         var _loc5_:int = 200;
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_)
         {
            this.endTimes.push(_loc5_);
            _loc5_ += _loc5_ * 0.4;
            _loc6_++;
         }
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
         if(param1 == obf_G_W_823.BEGINNING_STATUS)
         {
            this.currentBEActIndex = 0;
            _doTimeInv = new TimeLimiter(this.beginTimes[0]);
         }
         else if(param1 == obf_G_W_823.ENDING_STATUS)
         {
            this.currentBEActIndex = 0;
            _doTimeInv = new TimeLimiter(this.endTimes[0]);
         }
      }
      
      private function obf_r_3_1609() : void
      {
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
         this.obf_r_3_1609();
         ++this.currentBEActIndex;
         if(this.currentBEActIndex >= this.beginTimes.length)
         {
            obf_B_S_1600 = obf_G_W_823.RUNNING_STATUS;
         }
         else
         {
            _doTimeInv = new TimeLimiter(this.beginTimes[this.currentBEActIndex]);
         }
      }
      
      override protected function obf_E_6_2765() : void
      {
         var _loc1_:int = 0;
         obf_q_6_3634.obf_e_J_1876("gem@fs9",1);
         this.obf_r_3_1609();
         if(this.loopLimit <= 0)
         {
            _loc1_ = this.obf_7_b_986 > 0 ? int(_endTargetIndex - _currentIndex) : int(_currentIndex - _endTargetIndex);
            if(_loc1_ < 0)
            {
               _loc1_ += obf_t_b_871;
            }
            if(_loc1_ == this.endTimes.length)
            {
               obf_B_S_1600 = obf_G_W_823.ENDING_STATUS;
               this.currentBEActIndex = 0;
            }
         }
         else if(_currentIndex == _endTargetIndex)
         {
            --this.loopLimit;
         }
      }
      
      override protected function obf_z_x_915() : void
      {
         obf_q_6_3634.obf_e_J_1876("gem@fs9",1);
         this.obf_r_3_1609();
         ++this.currentBEActIndex;
         if(this.currentBEActIndex >= this.endTimes.length)
         {
            obf_B_S_1600 = obf_G_W_823.DONE_STATUS;
            obf_q_6_3634.obf_e_J_1876("enhanceComplete@fs9",1);
         }
         else
         {
            _doTimeInv = new TimeLimiter(this.endTimes[this.currentBEActIndex]);
         }
      }
   }
}

