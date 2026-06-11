package obf_V_K_965
{
   import obf_O_e_3875.obf_0_4_5_176;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.ui.WindowManager;
   import flash.events.MouseEvent;
   import playerUI.CentCeilUIMC;
   
   public class obf_i_D_2711 extends CentCeilUIMC
   {
      
      private var _iconBag:IconItemBag;
      
      public function obf_i_D_2711(param1:IIconItemUI)
      {
         super();
         this.initDiversity();
         this._iconBag = new IconItemBag(iconBar,param1,0);
         this._iconBag.addValidType(GameItemType.ALL);
         this._iconBag.lockDrag = true;
         this.addListener();
      }
      
      private function addListener() : void
      {
         cmdBuy.addEventListener(MouseEvent.CLICK,this.obf_C_N_3764);
      }
      
      private function removeListener() : void
      {
         cmdBuy.removeEventListener(MouseEvent.CLICK,this.obf_C_N_3764);
      }
      
      public function get iconBag() : IconItemBag
      {
         return this._iconBag;
      }
      
      override public function get width() : Number
      {
         return 170;
      }
      
      override public function get height() : Number
      {
         return 78;
      }
      
      private function obf_C_N_3764(param1:MouseEvent) : void
      {
         if(!obf_K_e_3075.playerBagUI.haveEmptyBag(1))
         {
            WindowManager.showMessageBox(DiversityManager.getString("CommonPrompt","playerBagFull"));
            return;
         }
         if(!this.iconBag.haveIconItem.itemCode)
         {
            return;
         }
         WindowManager.showConfirmBox(DiversityManager.getString("ShopBoxUI","isBuy"),this.obf_W_p_4172,[this.iconBag.haveIconItem.itemCode]);
      }
      
      private function obf_W_p_4172(param1:Object) : void
      {
         if(param1.confirm)
         {
            obf_0_4_5_176.sendChristmasShopReq(this.iconBag.haveIconItem.itemCode);
         }
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function setPrice(param1:Number) : void
      {
         txtCent.text = DiversityManager.getString("ChristmasUI","txtCent",[param1]);
      }
      
      public function initDiversity() : void
      {
         cmdBuy.label = DiversityManager.getString("ChristmasUI","cmdBuy");
         DiversityManager.setTextField(txtCent,"ChristmasUI","txtCent",[0]);
      }
   }
}

