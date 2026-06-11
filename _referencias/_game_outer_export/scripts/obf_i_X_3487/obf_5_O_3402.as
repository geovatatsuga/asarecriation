package obf_I_x_2551
{
   import obf_D_Y_975.obf_7_q_3477;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.InOutItemUIMC;
   
   public class obf_5_O_3402 extends InOutItemUIMC implements IPlayerUI
   {
      
      private var type:int;
      
      private var itemConfig:Object;
      
      public function obf_5_O_3402()
      {
         super();
         bg.mouseEnabled = false;
         title;
         mouseEnabled = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.initDiversity();
         this.addListener();
      }
      
      public function setType(param1:int) : void
      {
         this.type = param1;
      }
      
      public function setItemConfig(param1:Object) : void
      {
         this.itemConfig = param1;
      }
      
      public function initDiversity() : void
      {
         cmdSure.label = DiversityManager.getString("inOutItemUI","cmdSure");
         cmdCancel.label = DiversityManager.getString("inOutItemUI","cmdCancel");
      }
      
      private function addListener() : void
      {
         cmdLeft.addEventListener(MouseEvent.CLICK,this.obf_W_2_1463);
         cmdRight.addEventListener(MouseEvent.CLICK,this.obf_0_0_f_72);
         cmdSure.addEventListener(MouseEvent.CLICK,this.obf_H_Z_3613);
         cmdCancel.addEventListener(MouseEvent.CLICK,this.onClose);
      }
      
      private function removeListener() : void
      {
         cmdLeft.removeEventListener(MouseEvent.CLICK,this.obf_W_2_1463);
         cmdRight.removeEventListener(MouseEvent.CLICK,this.obf_0_0_f_72);
         cmdSure.removeEventListener(MouseEvent.CLICK,this.obf_H_Z_3613);
         cmdCancel.removeEventListener(MouseEvent.CLICK,this.onClose);
      }
      
      private function obf_W_2_1463(param1:Event) : void
      {
         var _loc2_:int = int(this.input.text);
         if(_loc2_ <= 1)
         {
            return;
         }
         _loc2_--;
         this.input.text = _loc2_ + "";
      }
      
      private function obf_0_0_f_72(param1:Event) : void
      {
         var _loc2_:int = int(this.input.text);
         var _loc3_:String = JSONUtil.getStr(this.itemConfig,["code"]);
         var _loc4_:int = GameItemManager.getStackSize(_loc3_);
         var _loc5_:int = obf_K_e_3075.playerBagUI.getItemCount(_loc3_);
         if(_loc2_ >= _loc4_ || _loc2_ >= _loc5_)
         {
            return;
         }
         _loc2_ += 1;
         this.input.text = _loc2_ + "";
      }
      
      private function obf_H_Z_3613(param1:Event) : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = int(this.input.text);
         if(_loc2_ <= 0)
         {
            return;
         }
         var _loc3_:String = JSONUtil.getStr(this.itemConfig,["code"]);
         var _loc4_:int = GameItemManager.getStackSize(_loc3_);
         if(this.type == 1)
         {
            if(_loc2_ > _loc4_ || _loc2_ > obf_K_e_3075.playerBagUI.getItemCount(_loc3_))
            {
               WindowManager.showMessageBox(DiversityManager.getString("inOutItemUI","noItem"));
               return;
            }
         }
         else if(this.type == 2)
         {
            _loc5_ = int(obf_K_e_3075.pocketItemUI.items[_loc3_]);
            if(_loc2_ > _loc4_ || _loc2_ > _loc5_)
            {
               WindowManager.showMessageBox(DiversityManager.getString("inOutItemUI","noItem"));
               return;
            }
         }
         obf_7_q_3477.obf_w_c_1946(this.type,this.itemConfig.code,int(this.input.text));
         this.clear();
         obf_K_e_3075.closeUI(this);
      }
      
      private function onClose(param1:Event) : void
      {
         this.clear();
         obf_K_e_3075.closeUI(this);
      }
      
      private function clear() : void
      {
         this.type = 0;
         this.itemConfig = null;
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return bg.getBounds(bg).contains(bg.mouseX,bg.mouseY);
         }
         return false;
      }
      
      public function showUI() : void
      {
         this.input.text = "1";
         if(this.type == 1)
         {
            DiversityManager.setTextField(this.txtTitle,"inOutItemUI","txtTitle1");
         }
         else if(this.type == 2)
         {
            DiversityManager.setTextField(this.txtTitle,"inOutItemUI","txtTitle2");
         }
         this.visible = true;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
      }
   }
}

