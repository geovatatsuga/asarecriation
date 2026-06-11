package obf_K_y_1096
{
   import obf_0_2_o_501.obf_g_4_2381;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.ui.WindowManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.BloodyWarUIMC;
   
   public class obf_5_X_1155 extends BloodyWarUIMC implements IPlayerUI
   {
      
      public var attackLevel:int;
      
      public var attackExp:int;
      
      public var attackTemp:int;
      
      public var defenseLevel:int;
      
      public var defenseExp:int;
      
      public var defenseTemp:int;
      
      public var attack:int;
      
      public var defense:int;
      
      public function obf_5_X_1155()
      {
         super();
         this.initDiversity();
         titleBox.mouseEnabled = false;
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2 + 300;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.addListener();
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtTitle,"bloodyWarUI","txtTitle");
         DiversityManager.setTextField(txtAttackLevel,"bloodyWarUI","txtAttackLevel");
         DiversityManager.setTextField(txtDefenseLevel,"bloodyWarUI","txtDefenseLevel");
         DiversityManager.setTextField(txtAttackInfo,"bloodyWarUI","txtAttackInfo");
         DiversityManager.setTextField(txtDefenseInfo,"bloodyWarUI","txtDefenseInfo");
         DiversityManager.setTextField(txtAttackTemp,"bloodyWarUI","txtAttackTemp");
         DiversityManager.setTextField(txtDefenseTemp,"bloodyWarUI","txtDefenseTemp");
         DiversityManager.setTextField(txtTip,"bloodyWarUI","txtTip");
         DiversityManager.setTextField(txtAttr,"bloodyWarUI","txtAttr");
         DiversityManager.setTextField(txtAttack,"bloodyWarUI","txtAttack");
         DiversityManager.setTextField(txtDefense,"bloodyWarUI","txtDefense");
         cmdAttackUp.label = DiversityManager.getString("bloodyWarUI","cmdAttackUp");
         cmdChangeAttack.label = DiversityManager.getString("bloodyWarUI","cmdChangeAttack");
         cmdDefenseUp.label = DiversityManager.getString("bloodyWarUI","cmdDefenseUp");
         cmdChangeDefense.label = DiversityManager.getString("bloodyWarUI","cmdChangeDefense");
         txtInfo.htmlText = "<a HREF=\'event:#\'><u>" + DiversityManager.getString("bloodyWarUI","txtInfo") + "</u></a>";
      }
      
      public function addListener() : void
      {
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         obf_K_e_3075.addUIMouseToolTip(txtInfo,"bloodyWar_info");
         cmdAttackUp.addEventListener(MouseEvent.CLICK,this.obf_f_2_2095);
         cmdDefenseUp.addEventListener(MouseEvent.CLICK,this.obf_x_t_3407);
         cmdChangeAttack.addEventListener(MouseEvent.CLICK,this.obf_X_o_4046);
         cmdChangeDefense.addEventListener(MouseEvent.CLICK,this.onChangeDefense);
      }
      
      private function removeListener() : void
      {
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         obf_K_e_3075.removeUIMouseToolTip(txtInfo);
         cmdAttackUp.removeEventListener(MouseEvent.CLICK,this.obf_f_2_2095);
         cmdDefenseUp.removeEventListener(MouseEvent.CLICK,this.obf_x_t_3407);
         cmdChangeAttack.removeEventListener(MouseEvent.CLICK,this.obf_X_o_4046);
         cmdChangeDefense.removeEventListener(MouseEvent.CLICK,this.onChangeDefense);
      }
      
      private function obf_f_2_2095(param1:Event) : void
      {
         this.obf_K_T_3268(1);
      }
      
      private function obf_x_t_3407(param1:Event) : void
      {
         this.obf_K_T_3268(2);
      }
      
      private function obf_X_o_4046(param1:Event) : void
      {
         param1.stopPropagation();
         this.obf_K_B_2396(1);
      }
      
      private function onChangeDefense(param1:Event) : void
      {
         param1.stopPropagation();
         this.obf_K_B_2396(2);
      }
      
      private function obf_K_T_3268(param1:int) : void
      {
         var _loc2_:Object = null;
         if(param1 == 1)
         {
            _loc2_ = obf_g_4_2381.attackList[this.attackLevel - 1];
         }
         else if(param1 == 2)
         {
            _loc2_ = obf_g_4_2381.defenseList[this.defenseLevel - 1];
         }
         if(_loc2_ == null)
         {
            return;
         }
         if(!obf_K_e_3075.playerBagUI || obf_K_e_3075.playerBagUI.getItemCount(obf_g_4_2381.upItemCode) < 1)
         {
            WindowManager.showMessageBox(DiversityManager.getString("bloodyWarUI","noItems"));
            return;
         }
         obf_g_4_2381.sendUpLevel(param1);
      }
      
      private function obf_K_B_2396(param1:int) : void
      {
         obf_K_e_3075.obf_t_P_3183.setType(param1);
         obf_K_e_3075.showUI(obf_K_e_3075.obf_t_P_3183);
      }
      
      public function refresh() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this.attackLevel <= 0 || this.defenseLevel <= 0)
         {
            return;
         }
         var _loc1_:Object = obf_g_4_2381.attackList[this.attackLevel - 1];
         txtAttackLv.text = _loc1_.level;
         if(_loc1_.upNeed > 0)
         {
            txtExpAttack.text = this.attackExp + "/" + _loc1_.upNeed;
            _loc3_ = int(this.attackExp / _loc1_.upNeed * 100);
            expAttackBar.gotoAndStop(_loc3_);
         }
         else
         {
            txtExpAttack.text = "";
            expAttackBar.gotoAndStop(100);
         }
         txtAttackInfo.text = DiversityManager.getString("bloodyWarUI","txtAttackInfo",[_loc1_.addValue]);
         txtAttackTempValue.text = "+" + this.attackTemp;
         var _loc2_:Object = obf_g_4_2381.defenseList[this.defenseLevel - 1];
         txtDefenseLv.text = _loc2_.level;
         if(_loc2_.upNeed > 0)
         {
            txtExpDefense.text = this.defenseExp + "/" + _loc2_.upNeed;
            _loc4_ = int(this.defenseExp / _loc2_.upNeed * 100);
            expDefenseBar.gotoAndStop(_loc4_);
         }
         else
         {
            txtExpDefense.text = "";
            expDefenseBar.gotoAndStop(100);
         }
         txtDefenseInfo.text = DiversityManager.getString("bloodyWarUI","txtDefenseInfo",[_loc2_.addValue]);
         txtDefenseTempValue.text = "+" + this.defenseTemp;
         txtAttackValue.text = this.attack + "";
         txtDefenseValue.text = this.defense + "";
      }
      
      public function refreshTemp() : void
      {
         txtAttackTempValue.text = "+" + this.attackTemp;
         txtDefenseTempValue.text = "+" + this.defenseTemp;
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
         this.visible = true;
         this.refresh();
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
         this.removeListener();
      }
   }
}

