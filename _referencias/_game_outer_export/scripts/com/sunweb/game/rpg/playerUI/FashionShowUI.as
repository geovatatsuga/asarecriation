package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.obf_0_M_3913;
   import com.sunweb.game.rpg.role.obf_E_k_1445;
   import com.sunweb.game.rpg.role.action.obf_S_c_3330;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.FashionShowUIMC;
   
   public class FashionShowUI extends FashionShowUIMC implements IPlayerUI
   {
      
      private var viewPlayer:obf_0_M_3913;
      
      private var equipModel:Object;
      
      private var playerDirection:int = 6;
      
      private var playerAction:String = "stand";
      
      private var obf_6_T_4084:TimeLimiter = new TimeLimiter(3000);
      
      public function FashionShowUI()
      {
         super();
         this.initDiversity();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth - this.width / 2;
         this.y = GameContext.gameStage.stageHeight - this.height / 2;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"FashionViewUI","txtTitle");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         cmdLeft.addEventListener(MouseEvent.CLICK,this.onClickLeft);
         cmdRight.addEventListener(MouseEvent.CLICK,this.onClickRight);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         cmdLeft.removeEventListener(MouseEvent.CLICK,this.onClickLeft);
         cmdRight.removeEventListener(MouseEvent.CLICK,this.onClickRight);
      }
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function onClickLeft(param1:Event) : void
      {
         --this.playerDirection;
         if(this.playerDirection < 0)
         {
            this.playerDirection = 7;
         }
         this.obf_1_w_1340();
      }
      
      private function onClickRight(param1:Event) : void
      {
         ++this.playerDirection;
         if(this.playerDirection > 7)
         {
            this.playerDirection = 0;
         }
         this.obf_1_w_1340();
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.obf_6_T_4084.checkTimeout())
         {
            if(this.playerAction == obf_S_c_3330.obf_r_q_3113)
            {
               this.playerAction = obf_S_c_3330.obf_h_4_3537;
            }
            else
            {
               this.playerAction = obf_S_c_3330.obf_r_q_3113;
            }
            this.obf_1_w_1340();
         }
      }
      
      private function obf_1_w_1340() : void
      {
         if(this.visible && Boolean(this.viewPlayer))
         {
            this.viewPlayer.doAction(this.playerAction,this.playerDirection,true);
         }
      }
      
      private function initPlayer() : void
      {
         var _loc2_:String = null;
         this.viewPlayer = new obf_0_M_3913(GameContext.localPlayer.playerModelCode);
         this.viewPlayer.id = "_&FashionView&_";
         this.viewPlayer.setDefaultEquipmentModel(obf_E_k_1445.HAT,GameContext.localPlayer.getDefaultEquipmentModel(obf_E_k_1445.HAT));
         var _loc1_:Array = [obf_E_k_1445.HAT,obf_E_k_1445.WEAPON,obf_E_k_1445.SHIELD,obf_E_k_1445.WING,obf_E_k_1445.CLOTHES];
         for each(_loc2_ in _loc1_)
         {
            this.viewPlayer.setUsingEquipmentModel(_loc2_,GameContext.localPlayer.getUsingEquipmentModel(_loc2_));
         }
         pointPlayer.addChild(this.viewPlayer);
         this.equipModel = new Object();
         this.obf_1_w_1340();
      }
      
      private function removePlayer() : void
      {
         if(this.viewPlayer.parent)
         {
            this.viewPlayer.parent.removeChild(this.viewPlayer);
         }
         this.viewPlayer.destroy();
         this.viewPlayer = null;
      }
      
      public function obf_T_E_3576(param1:String, param2:String) : void
      {
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         if(!this.viewPlayer || !this.equipModel)
         {
            return;
         }
         this.setRide("");
         var _loc3_:Array = this.equipModel[param2] != null ? this.equipModel[param2].split(",") : [];
         for each(_loc4_ in _loc3_)
         {
            this.viewPlayer.setUsingEquipmentModel(obf_E_k_1445.getEquipmentModelKind(_loc4_),"");
         }
         _loc5_ = param1.split(",");
         for each(_loc6_ in _loc5_)
         {
            _loc7_ = obf_E_k_1445.getEquipmentModelKind(_loc6_);
            this.viewPlayer.setUsingEquipmentModel(_loc7_,_loc6_);
         }
         this.equipModel[param2] = param1;
         this.viewPlayer.obf_A_j_2560();
      }
      
      public function setRide(param1:String) : void
      {
         if(!this.visible || !this.viewPlayer)
         {
            return;
         }
         if(!obf_L_l_4100.isEmpty(param1))
         {
            this.viewPlayer.ride(false);
            this.viewPlayer.setRideModel(param1);
            this.viewPlayer.ride(true);
         }
         else
         {
            this.viewPlayer.ride(false);
         }
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function showUI() : void
      {
         this.initPlayer();
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.removePlayer();
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

