package com.sunweb.game.rpg.playerUI.family
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.family.obf_F_9_1495;
   import com.sunweb.game.rpg.family.obf_Q_D_1342;
   import com.sunweb.game.rpg.module.InputBoxModule;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import fl.data.DataProvider;
   import fl.events.ListEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.FamilyPostListUIMC;
   
   public class FamilyPostListUI extends FamilyPostListUIMC implements IPlayerUI
   {
      
      public function FamilyPostListUI()
      {
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         listPost.labelFunction = this.obf_5_0_2627;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"FamilyPostListUI","txtTitle");
         cmdEdit.label = DiversityManager.getString("FamilyPostListUI","cmdEdit");
         cmdSubmit.label = DiversityManager.getString("FamilyPostListUI","cmdSubmit");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdEdit.addEventListener(MouseEvent.CLICK,this.obf_Q_A_3628);
         listPost.addEventListener(ListEvent.ITEM_DOUBLE_CLICK,this.onDbClickItem);
         cmdSubmit.addEventListener(MouseEvent.CLICK,this.submitPost);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdEdit.removeEventListener(MouseEvent.CLICK,this.obf_Q_A_3628);
         listPost.removeEventListener(ListEvent.ITEM_DOUBLE_CLICK,this.onDbClickItem);
         cmdSubmit.removeEventListener(MouseEvent.CLICK,this.submitPost);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      public function setPostList(param1:Array) : void
      {
         listPost.dataProvider = new DataProvider();
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            listPost.dataProvider.addItem({
               "name":param1[_loc2_],
               "postLevel":_loc2_
            });
            _loc2_++;
         }
      }
      
      private function obf_Q_A_3628(param1:Event) : void
      {
         if(!listPost.selectedItem)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FamilyPostListUI","prompt_NotSelectedPost"));
            return;
         }
         this.editPost(listPost.selectedItem.postLevel);
      }
      
      private function onDbClickItem(param1:ListEvent) : void
      {
         this.editPost(param1.item.postLevel);
      }
      
      private function editPost(param1:int) : void
      {
         if(!GameContext.localPlayer.obf_O_l_2706(obf_Q_D_1342.obf_e_o_1807))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","youCantOperation"));
            return;
         }
         WindowManager.showModalWindow(new InputBoxModule(DiversityManager.getString("FamilyPostListUI","prompt_InputPost"),null,param1,WorldConfig.obf_G_H_2802,true),this.inputPost);
      }
      
      private function inputPost(param1:Object) : void
      {
         if(!obf_L_l_4100.isEmpty(param1.content))
         {
            listPost.dataProvider.getItemAt(param1.par).name = param1.content;
            listPost.dataProvider.invalidateItemAt(param1.par);
         }
      }
      
      private function submitPost(param1:Event) : void
      {
         if(!GameContext.localPlayer.obf_O_l_2706(obf_Q_D_1342.obf_e_o_1807))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","youCantOperation"));
            return;
         }
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < listPost.dataProvider.length)
         {
            _loc2_.push(listPost.dataProvider.getItemAt(_loc3_).name);
            _loc3_++;
         }
         obf_F_9_1495.sendEditPost(_loc2_);
         obf_K_e_3075.closeUI(this);
      }
      
      private function obf_5_0_2627(param1:Object) : String
      {
         var _loc2_:Object = obf_F_9_1495.getPostConfig(param1.postLevel);
         var _loc3_:String = "";
         if(Boolean(_loc2_) && JSONUtil.getInt(_loc2_,["numberLimit"]) > 0)
         {
            _loc3_ = DiversityManager.getString("FamilyPostListUI","postNumber_Label",[JSONUtil.getInt(_loc2_,["numberLimit"])]);
         }
         else
         {
            _loc3_ = DiversityManager.getString("FamilyPostListUI","postNumber_Label_ALL");
         }
         return _loc3_ + "\t" + param1.name;
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
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

