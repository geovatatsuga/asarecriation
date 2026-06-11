package com.sunweb.game.rpg.playerUI.renew
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import flash.events.Event;
   import playerUI.RenewPlanCellMC;
   
   public class obf_0_0_M_111 extends RenewPlanCellMC
   {
      
      public var planIndex:int;
      
      public var money:int;
      
      private var _selected:Boolean;
      
      public function obf_0_0_M_111(param1:int, param2:int, param3:String, param4:Number, param5:int, param6:Boolean = true)
      {
         super();
         this.initDiversity();
         this.planIndex = param5;
         txtTime.text = param3;
         if(param4 < 1 && param6)
         {
            DiversityManager.setTextField(txtDiscountRate,"RenewPlanUI","plan_DiscountRate",[(param4 * 10).toFixed(1)],true);
         }
         this.money = param1 * param2 * param4;
         moneyPoint.addChild(obf_a_f_2935.getMoneyDisplay(this.money));
         this.selected = false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTime,"RenewPlanUI","cellRenewTime");
         DiversityManager.setTextField(txtDeyCost,"RenewPlanUI","cellRenewCost");
         DiversityManager.setTextField(txtDeyDiscountRate,"RenewPlanUI","cellDiscountRate");
         txtTime.mouseEnabled = false;
         txtDiscountRate.mouseEnabled = false;
      }
      
      public function set selected(param1:Boolean) : void
      {
         this.gotoAndStop(param1 ? 3 : 2);
         this._selected = param1;
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      private function onClick(param1:Event) : void
      {
         this.selected = !this.selected;
      }
   }
}

