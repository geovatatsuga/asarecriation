package obf_a_F_1055
{
   import obf_E_d_1594.NpcTalkBoxUI;
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.family.obf_F_9_1495;
   import com.sunweb.game.rpg.misc.obf_0_5_9_486;
   import com.sunweb.game.rpg.module.InputBoxModule;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.npc.CommandCodeNpc;
   import com.sunweb.game.rpg.worldZone.command.npc.NpcExecScriptsToTargetRequest;
   import com.sunweb.game.rpg.worldZone.command.npc.NpcFunctionAnswer;
   import com.sunweb.game.rpg.worldZone.command.npc.NpcFunctionRequest;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.obf_L_l_4100;
   
   public class obf_K_i_1311
   {
      
      public static const obf_1_J_2800:String = "back";
      
      public static const obf_5_4_2527:String = "root";
      
      public static const obf_w_E_3247:String = "close";
      
      public static const obf_3_c_1679:String = "createFamily";
      
      public static const obf_8_u_1758:String = "listFamily";
      
      public static const MENU_FAMILY_TASK:String = "familyTask";
      
      public static const obf_x_V_4461:String = "familyVarList";
      
      public static const obf_w_Z_1842:String = "gift";
      
      public static const obf_e_l_900:String = "artifact_hole";
      
      public static const obf_O_K_1317:String = "artifact_embed";
      
      public static const obf_R_D_3812:String = "artifact_disembed";
      
      public function obf_K_i_1311()
      {
         super();
      }
      
      public static function sendMenuAction(param1:String, param2:Array) : void
      {
         var _loc3_:NpcFunctionRequest = new NpcFunctionRequest();
         _loc3_.npcId = param1;
         _loc3_.funcMenuFullIndex = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeNpc.NPC_Function_ANSWER)
         {
            if((param1 as NpcFunctionAnswer).npcFullId == obf_K_e_3075.fruitBoxUI.npcId)
            {
               obf_K_e_3075.fruitBoxUI.resetMenu();
            }
         }
      }
      
      public static function sendDisableSpeak(param1:String, param2:Array, param3:String) : void
      {
         var _loc4_:NpcExecScriptsToTargetRequest = new NpcExecScriptsToTargetRequest();
         _loc4_.npcId = param1;
         _loc4_.funcMenuFullIndex = param2;
         _loc4_.targetPlayerId = param3;
         GameContext.worldClient.sendCommand(_loc4_);
      }
      
      public static function confirmDisableSpeak(param1:Object) : void
      {
         if(!obf_L_l_4100.isEmpty(param1.content))
         {
            sendDisableSpeak(param1.par.npcId,param1.par.menuIndex,param1.content);
         }
      }
      
      public static function obf_c_e_781(param1:String, param2:NpcTalkBoxUI, param3:String = "", param4:Array = null) : void
      {
         if(param1 == obf_3_c_1679)
         {
            if(obf_F_9_1495.obf_j_t_4601())
            {
               obf_K_e_3075.closeUI(obf_K_e_3075.npcTalkBox);
               WindowManager.showModalWindow(new InputBoxModule(DiversityManager.getString("FamilyBoxUI","prompt_InputCreateFamilyName")),obf_F_9_1495.obf_0_8_x_487);
            }
            else
            {
               param2.refreshMenu();
            }
         }
         else if(param1 == obf_8_u_1758)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.familyListUI);
            obf_K_e_3075.closeUI(obf_K_e_3075.npcTalkBox);
         }
         else if(param1 == MENU_FAMILY_TASK)
         {
            if(!GameContext.localPlayer.hasFamily())
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("FamilyBoxUI","prompt_youNoFamily"));
               param2.refreshMenu();
               return;
            }
            obf_F_9_1495.sendFamilyTaskList();
            obf_K_e_3075.closeUI(obf_K_e_3075.npcTalkBox);
         }
         else if(param1 == obf_x_V_4461)
         {
            obf_F_9_1495.sendFamilyVarList("#ldztp","");
            obf_K_e_3075.closeUI(obf_K_e_3075.npcTalkBox);
         }
         else if(param1 == obf_w_Z_1842)
         {
            WindowManager.showModalWindow(new InputBoxModule(DiversityManager.getString("MiscPrompt","inputCDKey")),obf_0_5_9_486.confirmUseGiftCDKEY);
            obf_K_e_3075.closeUI(obf_K_e_3075.npcTalkBox);
         }
         else if(param1 == obf_e_l_900)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.obf_5_i_2480);
            obf_K_e_3075.closeUI(obf_K_e_3075.npcTalkBox);
            obf_K_e_3075.showUI(obf_K_e_3075.playerBagUI);
         }
         else if(param1 == obf_O_K_1317)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.obf_5_i_2480);
            obf_K_e_3075.closeUI(obf_K_e_3075.npcTalkBox);
            obf_K_e_3075.showUI(obf_K_e_3075.playerBagUI);
         }
         else if(param1 == obf_R_D_3812)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.obf_5_i_2480);
            obf_K_e_3075.closeUI(obf_K_e_3075.npcTalkBox);
            obf_K_e_3075.showUI(obf_K_e_3075.playerBagUI);
         }
      }
   }
}

