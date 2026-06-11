package com.sunweb.game.net.framework.command
{
   public class obf_N_F_4206
   {
      
      private var obf_g_E_1086:Object = null;
      
      private var obf_k_V_773:Array = [];
      
      public function obf_N_F_4206()
      {
         super();
      }
      
      private function makeClassMap() : void
      {
         var _loc2_:obf_C_m_1350 = null;
         this.obf_g_E_1086 = new Object();
         var _loc1_:int = 0;
         while(_loc1_ < this.obf_k_V_773.length)
         {
            _loc2_ = new (this.obf_k_V_773[_loc1_] as Class)();
            this.obf_g_E_1086[_loc2_.code] = this.obf_k_V_773[_loc1_];
            _loc1_++;
         }
      }
      
      public function obf_I_Y_1047(param1:Class) : void
      {
         var cmd:obf_C_m_1350 = null;
         var c:Class = param1;
         if(this.obf_g_E_1086 == null)
         {
            this.makeClassMap();
         }
         try
         {
            cmd = new c();
            if(this.obf_g_E_1086[cmd.code] == null)
            {
               this.obf_g_E_1086[cmd.code] = c;
            }
            else
            {
               trace("=========== addCommandClass() obf_e_r_r_o_r__C_o_m_m_a_n_d_14 code of " + c + " already exists: 0x" + cmd.code.toString(16));
            }
         }
         catch(e:Error)
         {
            trace("Unable to create instance for class: " + c);
         }
      }
      
      public function addCommandClasses(param1:Array) : void
      {
         if(this.obf_g_E_1086 == null)
         {
            this.makeClassMap();
         }
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            this.obf_I_Y_1047(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      public function obf_F_t_3602(param1:int) : obf_C_m_1350
      {
         var cmd:obf_C_m_1350;
         var cmdCode:int = param1;
         if(this.obf_g_E_1086 == null)
         {
            this.makeClassMap();
         }
         cmd = null;
         try
         {
            cmd = new (this.obf_g_E_1086[cmdCode] as Class)();
         }
         catch(e:Error)
         {
         }
         return cmd;
      }
   }
}

