package com.sunweb.game.rpg.pis
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.pis.CommandCodePIS;
   import com.sunweb.game.rpg.worldZone.command.pis.PisCheckNotify;
   import com.sunweb.game.rpg.worldZone.command.pis.PisSetIDCardRequest;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.obf_L_l_4100;
   
   public class obf_j_s_1302
   {
      
      private static var _isChild:Boolean;
      
      private static var obf_A_Z_3173:int;
      
      public function obf_j_s_1302()
      {
         super();
      }
      
      public static function get isTired() : Boolean
      {
         return _isChild && obf_A_Z_3173 == 2;
      }
      
      public static function confirmInputIDCard(param1:Object) : void
      {
         if(obf_L_l_4100.isEmpty(param1.content))
         {
            return;
         }
         var _loc2_:String = param1.content;
         if(!obf_X_k_3443.obf_l_R_1492(_loc2_))
         {
            WindowManager.showMessageBox("obf_______3170！");
            return;
         }
         var _loc3_:PisSetIDCardRequest = new PisSetIDCardRequest();
         _loc3_.pisIDCardNo = _loc2_;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePIS.PIS_CHECK_NOTIFY)
         {
            obf_K_A_1299(param1 as PisCheckNotify);
         }
      }
      
      private static function obf_K_A_1299(param1:PisCheckNotify) : void
      {
         _isChild = param1.isChild;
         obf_A_Z_3173 = param1.pisStatus;
         if(param1.isChild)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.obf_z_1_3064);
            obf_K_e_3075.setUIChildIndex(obf_K_e_3075.obf_z_1_3064,0);
         }
         else
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.obf_z_1_3064);
         }
         if(obf_K_e_3075.obf_z_1_3064)
         {
            obf_K_e_3075.obf_z_1_3064.setPisPrompt(param1.pisStatus,param1.pisOnlineSec);
         }
      }
   }
}

