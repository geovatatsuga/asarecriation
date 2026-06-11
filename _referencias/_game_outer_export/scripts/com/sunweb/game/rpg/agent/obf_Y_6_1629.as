package com.sunweb.game.rpg.agent
{
   import obf_a_F_1055.obf_b_p_3604;
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.agent.AgentBuyItemRequest;
   import com.sunweb.game.rpg.worldZone.command.agent.AgentCancelItemRequest;
   import com.sunweb.game.rpg.worldZone.command.agent.AgentListItemAnswer;
   import com.sunweb.game.rpg.worldZone.command.agent.AgentListItemRequest;
   import com.sunweb.game.rpg.worldZone.command.agent.AgentSellItemRequest;
   import com.sunweb.game.rpg.worldZone.command.agent.AgentTakeBackRequest;
   import com.sunweb.game.rpg.worldZone.command.agent.AgentViewMyItemsAnswer;
   import com.sunweb.game.rpg.worldZone.command.agent.AgentViewMyItemsRequest;
   import com.sunweb.game.rpg.worldZone.command.agent.CommandCodeAgent;
   
   public class obf_Y_6_1629
   {
      
      public function obf_Y_6_1629()
      {
         super();
      }
      
      public static function sendSellItem(param1:int, param2:int, param3:int, param4:String, param5:Array) : void
      {
         if(!obf_b_p_3604.checkNpcDistance(param4,true))
         {
            return;
         }
         var _loc6_:AgentSellItemRequest = new AgentSellItemRequest();
         _loc6_.itemIndex = param2;
         _loc6_.bagIndex = param3;
         _loc6_.npcId = param4;
         _loc6_.funcMenuFullIndex = param5;
         _loc6_.price = param1;
         GameContext.worldClient.sendCommand(_loc6_);
      }
      
      public static function sendBuyItem(param1:String, param2:Array, param3:int) : void
      {
         if(!obf_b_p_3604.checkNpcDistance(param1,true))
         {
            return;
         }
         if(!obf_K_e_3075.playerBagUI || !obf_K_e_3075.playerBagUI.haveEmptyBag(1))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","playerBagFull"));
            return;
         }
         var _loc4_:AgentBuyItemRequest = new AgentBuyItemRequest();
         _loc4_.npcId = param1;
         _loc4_.funcMenuFullIndex = param2;
         _loc4_.agentRecId = param3;
         GameContext.worldClient.sendCommand(_loc4_);
      }
      
      public static function obf_P_L_4425(param1:String, param2:Array) : void
      {
         if(!obf_b_p_3604.checkNpcDistance(param1,true))
         {
            return;
         }
         var _loc3_:AgentViewMyItemsRequest = new AgentViewMyItemsRequest();
         _loc3_.npcId = param1;
         _loc3_.funcMenuFullIndex = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function obf_G_V_2425(param1:int, param2:String, param3:Array) : void
      {
         if(!obf_b_p_3604.checkNpcDistance(param2,true))
         {
            return;
         }
         if(!obf_K_e_3075.playerBagUI || !obf_K_e_3075.playerBagUI.haveEmptyBag(1))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","playerBagFull"));
            return;
         }
         var _loc4_:AgentCancelItemRequest = new AgentCancelItemRequest();
         _loc4_.agentRecId = param1;
         _loc4_.npcId = param2;
         _loc4_.funcMenuFullIndex = param3;
         GameContext.worldClient.sendCommand(_loc4_);
      }
      
      public static function obf_U_p_4284(param1:String, param2:Array, param3:int) : void
      {
         if(!obf_b_p_3604.checkNpcDistance(param1,true))
         {
            return;
         }
         var _loc4_:AgentTakeBackRequest = new AgentTakeBackRequest();
         _loc4_.npcId = param1;
         _loc4_.funcMenuFullIndex = param2;
         _loc4_.agentRecId = param3;
         GameContext.worldClient.sendCommand(_loc4_);
      }
      
      public static function obf_Z_4684(param1:String, param2:Array, param3:int, param4:int, param5:String) : void
      {
         if(!obf_b_p_3604.checkNpcDistance(param1,true))
         {
            return;
         }
         var _loc6_:AgentListItemRequest = new AgentListItemRequest();
         _loc6_.npcId = param1;
         _loc6_.funcMenuFullIndex = param2;
         _loc6_.pageNo = param3;
         _loc6_.queryItemSubtype = param4;
         _loc6_.queryItemName = param5;
         GameContext.worldClient.sendCommand(_loc6_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeAgent.AGENT_VIEW_MY_ITEMS_ANSWER)
         {
            obf_0_7_u_505(param1 as AgentViewMyItemsAnswer);
         }
         else if(param1.code == CommandCodeAgent.AGENT_LIST_ITEM_ANSWER)
         {
            obf_0_0_E_76(param1 as AgentListItemAnswer);
         }
      }
      
      private static function obf_0_7_u_505(param1:AgentViewMyItemsAnswer) : void
      {
         if(Boolean(obf_K_e_3075.obf_l_H_2916) && obf_K_e_3075.obf_l_H_2916.visible)
         {
            obf_K_e_3075.obf_l_H_2916.showMySell(param1.myItemList);
         }
      }
      
      private static function obf_0_0_E_76(param1:AgentListItemAnswer) : void
      {
         if(Boolean(obf_K_e_3075.obf_l_H_2916) && obf_K_e_3075.obf_l_H_2916.visible)
         {
            obf_K_e_3075.obf_l_H_2916.setItemList(param1.itemList,param1.pageNo);
         }
      }
   }
}

